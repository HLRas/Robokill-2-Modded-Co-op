#!/usr/bin/env python3
"""Relay server for Robokill 2 online co-op.

Flash cannot accept incoming connections, so both players connect out to this relay. The host registers and gets a
join code, the guest sends that code, and from then on the relay just forwards data between the two.

Wire format (both directions): u32 length (big-endian, counts the type byte), u8 type, payload.
Strings are u16 length + UTF-8 (AS3 writeUTF/readUTF).

  client -> relay: HOST(version)  JOIN(code, version)  DATA(bytes)  PING(bytes)
  relay -> client: CODE(code)  PEER_JOINED  PEER_LEFT  ERROR(message)  DATA(bytes)  PONG(the PING's bytes)

Only needs the Python 3.8+ standard library.
"""
import argparse
import asyncio
import logging
import random
import socket
import struct
import time

HOST, JOIN, DATA, PING = 1, 2, 3, 4
CODE, PEER_JOINED, PEER_LEFT, ERROR, PONG = 10, 11, 12, 13, 14

# Flash asks for this before it opens a socket (on port 843, then on the game port).
POLICY = (b'<?xml version="1.0"?><cross-domain-policy>'
          b'<allow-access-from domain="*" to-ports="*"/></cross-domain-policy>\0')
CODE_ALPHABET = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789"
MAX_MESSAGE = 8 * 1024 * 1024
MAX_ROOMS = 200
IDLE_TIMEOUT = 120

# Keep queues short: data waiting here or in the kernel is lag. When a receiver falls behind, the relay stops
# reading from the sender, so the sender sees the backlog (and skips frames) instead of it piling up here.
WRITE_HIGH = 32 * 1024
WRITE_LOW = 8 * 1024
NOTSENT_LOWAT = 16 * 1024
TCP_NOTSENT_LOWAT = getattr(socket, "TCP_NOTSENT_LOWAT", 25)

log = logging.getLogger("relay")
rooms = {}
fixed_code = None
delay_ms = 0
jitter_ms = 0
rate_kbs = 0


def utf(text):
    raw = text.encode("utf-8")
    return struct.pack(">H", len(raw)) + raw


def read_utf(buf, pos):
    (n,) = struct.unpack_from(">H", buf, pos)
    return buf[pos + 2:pos + 2 + n].decode("utf-8", "replace"), pos + 2 + n


class Room:
    def __init__(self, code, host, version):
        self.code = code
        self.host = host
        self.guest = None
        self.version = version
        self.host_bytes = 0
        self.guest_bytes = 0

    def other(self, peer):
        return self.guest if peer is self.host else self.host


def new_code():
    if fixed_code and fixed_code not in rooms:
        return fixed_code
    while True:
        code = "".join(random.choice(CODE_ALPHABET) for _ in range(6))
        if code not in rooms:
            return code


class Peer(asyncio.Protocol):
    def __init__(self):
        self.transport = None
        self.sock = None
        self.addr = None
        self.room = None
        self.buf = bytearray()
        self.started = False
        self.closed = False
        self.last_seen = time.monotonic()
        self.paused_writing = False
        # Test options --delay/--jitter/--rate: when this peer's queued deliveries are due (kept in order), and
        # when the simulated link to it is free again.
        self.deliver_at = 0.0
        self.link_free = 0.0

    # ---- connection ----

    def connection_made(self, transport):
        self.transport = transport
        self.addr = transport.get_extra_info("peername")
        self.sock = transport.get_extra_info("socket")
        transport.set_write_buffer_limits(high=WRITE_HIGH, low=WRITE_LOW)
        if self.sock is not None:
            for level, opt, value in ((socket.IPPROTO_TCP, socket.TCP_NODELAY, 1),
                                      (socket.IPPROTO_TCP, TCP_NOTSENT_LOWAT, NOTSENT_LOWAT)):
                try:
                    self.sock.setsockopt(level, opt, value)
                except OSError:
                    pass
        peers.add(self)

    def connection_lost(self, exc):
        self.closed = True
        peers.discard(self)
        leave(self)

    def close(self):
        if not self.closed and self.transport:
            self.transport.close()

    def quick_ack(self):
        # Acknowledge right away instead of after Linux's 40 ms delayed-ACK timer: Flash can't turn off Nagle,
        # so its small writes wait for this ACK. TCP_QUICKACK is one-shot, so it's set again after every read.
        if self.sock is not None and hasattr(socket, "TCP_QUICKACK"):
            try:
                self.sock.setsockopt(socket.IPPROTO_TCP, socket.TCP_QUICKACK, 1)
            except OSError:
                pass

    def data_received(self, data):
        self.last_seen = time.monotonic()
        self.quick_ack()
        self.buf += data
        if not self.started:
            if len(self.buf) < 4:
                return
            if self.buf[:4] == b"<pol":
                if b"\0" in self.buf:
                    log.info("policy file sent on the game port to %s", self.addr)
                    self.transport.write(POLICY)
                    self.transport.close()
                return
            self.started = True
        buf = self.buf
        pos = 0
        while len(buf) - pos >= 5:
            (length,) = struct.unpack_from(">I", buf, pos)
            if length < 1 or length > MAX_MESSAGE:
                log.info("%s sent a bad length %d", self.addr, length)
                self.transport.close()
                return
            if len(buf) - pos - 4 < length:
                break
            kind = buf[pos + 4]
            payload = bytes(buf[pos + 5:pos + 4 + length])
            pos += 4 + length
            try:
                self.on_message(kind, payload)
            except Exception:
                log.exception("error from %s", self.addr)
                self.transport.close()
                return
            if self.closed:
                return
        if pos:
            del buf[:pos]

    # Back-pressure: while this peer's outgoing buffer is full, stop reading from the other player.
    def pause_writing(self):
        self.paused_writing = True
        other = self.room.other(self) if self.room else None
        if other and other.transport:
            other.transport.pause_reading()

    def resume_writing(self):
        self.paused_writing = False
        other = self.room.other(self) if self.room else None
        if other and other.transport:
            other.transport.resume_reading()

    # ---- messages ----

    def send(self, kind, payload=b""):
        if not self.closed and self.transport and not self.transport.is_closing():
            self.transport.write(struct.pack(">IB", len(payload) + 1, kind) + payload)

    def send_data(self, payload):
        if not delay_ms and not jitter_ms and not rate_kbs:
            self.send(DATA, payload)
            return
        # Simulated network (testing): a link of rate_kbs with an unlimited queue in front of it (like a home
        # router), then delay and jitter. Keeps order, like TCP.
        loop = asyncio.get_running_loop()
        at = loop.time()
        if rate_kbs:
            self.link_free = max(self.link_free, at) + (len(payload) + 45) / (rate_kbs * 1024)
            self.max_queue = max(getattr(self, "max_queue", 0), self.link_free - at)
            at = self.link_free
        at += (delay_ms + random.random() * jitter_ms) / 1000
        # Strictly later than the previous one: timers due at the same moment can run in any order.
        self.deliver_at = max(self.deliver_at + 1e-6, at)
        loop.call_at(self.deliver_at, self.send, DATA, payload)

    def on_message(self, kind, payload):
        room = self.room
        if kind == DATA:
            if room:
                other = room.other(self)
                if other:
                    other.send_data(payload)
                    if self is room.host:
                        room.host_bytes += len(payload)
                    else:
                        room.guest_bytes += len(payload)
        elif kind == PING:
            # Echo, so the game can measure its round trip to the relay.
            self.send(PONG, payload)
        elif kind == HOST and room is None and len(rooms) >= MAX_ROOMS:
            self.send(ERROR, utf("THE ONLINE SERVER IS FULL"))
        elif kind == HOST and room is None:
            version, _ = read_utf(payload, 0)
            code = new_code()
            self.room = rooms[code] = Room(code, self, version)
            self.send(CODE, utf(code))
            log.info("room %s opened (%s)", code, version)
        elif kind == JOIN and room is None:
            code, pos = read_utf(payload, 0)
            version, _ = read_utf(payload, pos)
            target = rooms.get(code.strip().upper())
            if not target:
                self.send(ERROR, utf("NO GAME WITH THAT CODE"))
            elif target.guest:
                self.send(ERROR, utf("THAT GAME IS FULL"))
            elif target.version != version:
                self.send(ERROR, utf("YOU AND THE HOST HAVE DIFFERENT GAME VERSIONS"))
            else:
                target.guest = self
                self.room = target
                target.host.send(PEER_JOINED)
                self.send(PEER_JOINED)
                log.info("guest joined room %s", target.code)
        # Anything unknown only keeps the connection alive.


peers = set()


def leave(peer):
    room = peer.room
    if not room:
        return
    peer.room = None
    other = room.other(peer)
    # The other player may be paused on back-pressure from this one.
    if other and other.transport:
        try:
            other.transport.resume_reading()
        except Exception:
            pass
    if peer is room.host:
        rooms.pop(room.code, None)
        if room.guest:
            room.guest.send(PEER_LEFT)
            room.guest.room = None
            room.guest.close()
        log.info("room %s closed", room.code)
    else:
        room.guest = None
        room.host.send(PEER_LEFT)
        log.info("guest left room %s", room.code)


class PolicyServer(asyncio.Protocol):
    def connection_made(self, transport):
        self.transport = transport
        self.buf = b""
        asyncio.get_running_loop().call_later(10, transport.close)

    def data_received(self, data):
        self.buf += data
        if b"\0" in self.buf:
            log.info("policy file sent on the policy port")
            self.transport.write(POLICY)
            self.transport.close()


async def close_idle():
    while True:
        await asyncio.sleep(10)
        now = time.monotonic()
        for peer in list(peers):
            if now - peer.last_seen > IDLE_TIMEOUT:
                peer.close()


async def log_stats():
    while True:
        await asyncio.sleep(10)
        for room in list(rooms.values()):
            if room.host_bytes or room.guest_bytes:
                queue = ""
                if rate_kbs and room.guest:
                    queue = ", worst queue to guest %.0f ms" % (getattr(room.guest, "max_queue", 0) * 1000)
                    room.guest.max_queue = 0
                log.info("room %s: host->guest %.0f KB/s, guest->host %.1f KB/s%s", room.code,
                         room.host_bytes / 10240, room.guest_bytes / 10240, queue)
                room.host_bytes = room.guest_bytes = 0


async def main():
    global fixed_code, delay_ms, jitter_ms, rate_kbs
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--port", type=int, default=7777)
    parser.add_argument("--policy-port", type=int, default=0,
                        help="serve the Flash socket policy on this port too, e.g. 843 (the projector exe doesn't "
                             "ask for one; a browser-hosted SWF would)")
    parser.add_argument("--fixed-code", help="for testing: give the first host this code")
    parser.add_argument("--stats", action="store_true", help="log each room's data rate every 10 s")
    parser.add_argument("--delay", type=int, default=0, help="for testing: delay game data by this many ms "
                                                             "each way")
    parser.add_argument("--jitter", type=int, default=0, help="for testing: add up to this many ms of random "
                                                              "extra delay (order is kept, as with TCP)")
    parser.add_argument("--rate", type=int, default=0, help="for testing: limit game data to this many KB/s each "
                                                            "way (data queues up beyond that)")
    args = parser.parse_args()
    fixed_code = args.fixed_code
    delay_ms, jitter_ms, rate_kbs = args.delay, args.jitter, args.rate
    logging.basicConfig(level=logging.INFO, format="%(asctime)s %(message)s")

    loop = asyncio.get_running_loop()
    servers = [await loop.create_server(Peer, "0.0.0.0", args.port)]
    if args.policy_port:
        try:
            servers.append(await loop.create_server(PolicyServer, "0.0.0.0", args.policy_port))
        except OSError as e:
            log.warning("no policy server on port %d (%s)", args.policy_port, e)
    log.info("relay listening on port %d%s", args.port,
             " (test: delay %d ms + up to %d ms jitter, rate %s KB/s)" % (delay_ms, jitter_ms, rate_kbs or "unlimited")
             if delay_ms or jitter_ms or rate_kbs else "")
    tasks = [s.serve_forever() for s in servers] + [close_idle()]
    if args.stats:
        tasks.append(log_stats())
    await asyncio.gather(*tasks)


if __name__ == "__main__":
    asyncio.run(main())
