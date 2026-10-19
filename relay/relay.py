#!/usr/bin/env python3
"""Relay server for Robokill 2 online co-op.

Flash cannot accept incoming connections, so both players connect out to this relay. The host registers and gets a
join code, the guest sends that code, and from then on the relay just forwards data between the two.

Wire format (both directions): u32 length (big-endian, counts the type byte), u8 type, payload.
Strings are u16 length + UTF-8 (AS3 writeUTF/readUTF).

  client -> relay: HOST(version)  JOIN(code, version)  DATA(bytes)  PING
  relay -> client: CODE(code)  PEER_JOINED  PEER_LEFT  ERROR(message)  DATA(bytes)

Only needs the Python 3.8+ standard library.
"""
import argparse
import asyncio
import logging
import random
import struct

HOST, JOIN, DATA, PING = 1, 2, 3, 4
CODE, PEER_JOINED, PEER_LEFT, ERROR = 10, 11, 12, 13

# Flash asks for this before it opens a socket (on port 843, then on the game port).
POLICY = (b'<?xml version="1.0"?><cross-domain-policy>'
          b'<allow-access-from domain="*" to-ports="*"/></cross-domain-policy>\0')
CODE_ALPHABET = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789"
MAX_MESSAGE = 8 * 1024 * 1024
MAX_ROOMS = 200
IDLE_TIMEOUT = 120

log = logging.getLogger("relay")
rooms = {}
fixed_code = None


def utf(text):
    raw = text.encode("utf-8")
    return struct.pack(">H", len(raw)) + raw


def read_utf(buf, pos):
    (n,) = struct.unpack_from(">H", buf, pos)
    return buf[pos + 2:pos + 2 + n].decode("utf-8", "replace"), pos + 2 + n


class Peer:
    def __init__(self, writer):
        self.writer = writer
        self.room = None

    def send(self, kind, payload=b""):
        if not self.writer.is_closing():
            self.writer.write(struct.pack(">IB", len(payload) + 1, kind) + payload)


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
    global fixed_code
    if fixed_code and fixed_code not in rooms:
        return fixed_code
    while True:
        code = "".join(random.choice(CODE_ALPHABET) for _ in range(6))
        if code not in rooms:
            return code


async def serve_policy(reader, writer):
    try:
        await asyncio.wait_for(reader.readuntil(b"\0"), 10)
        log.info("policy file sent on the policy port")
        writer.write(POLICY)
        await writer.drain()
    except Exception:
        pass
    finally:
        writer.close()


async def handle(reader, writer):
    peer = Peer(writer)
    addr = writer.get_extra_info("peername")
    try:
        header = await asyncio.wait_for(reader.readexactly(4), IDLE_TIMEOUT)
        if header == b"<pol":
            await reader.readuntil(b"\0")
            log.info("policy file sent on the game port to %s", addr)
            writer.write(POLICY)
            await writer.drain()
            return
        while True:
            (length,) = struct.unpack(">I", header)
            if length < 1 or length > MAX_MESSAGE:
                log.info("%s sent a bad length %d", addr, length)
                return
            body = await asyncio.wait_for(reader.readexactly(length), IDLE_TIMEOUT)
            await on_message(peer, body[0], body[1:])
            header = await asyncio.wait_for(reader.readexactly(4), IDLE_TIMEOUT)
    except (asyncio.IncompleteReadError, asyncio.TimeoutError, ConnectionError):
        pass
    except Exception:
        log.exception("error from %s", addr)
    finally:
        leave(peer)
        writer.close()


async def on_message(peer, kind, payload):
    room = peer.room
    if kind == DATA:
        if room:
            other = room.other(peer)
            if other:
                other.send(DATA, payload)
                if peer is room.host:
                    room.host_bytes += len(payload)
                else:
                    room.guest_bytes += len(payload)
                # Back-pressure: a slow receiver slows the sender instead of growing memory here.
                await other.writer.drain()
    elif kind == HOST and room is None and len(rooms) >= MAX_ROOMS:
        peer.send(ERROR, utf("THE ONLINE SERVER IS FULL"))
    elif kind == HOST and room is None:
        version, _ = read_utf(payload, 0)
        code = new_code()
        peer.room = rooms[code] = Room(code, peer, version)
        peer.send(CODE, utf(code))
        log.info("room %s opened (%s)", code, version)
    elif kind == JOIN and room is None:
        code, pos = read_utf(payload, 0)
        version, _ = read_utf(payload, pos)
        target = rooms.get(code.strip().upper())
        if not target:
            peer.send(ERROR, utf("NO GAME WITH THAT CODE"))
        elif target.guest:
            peer.send(ERROR, utf("THAT GAME IS FULL"))
        elif target.version != version:
            peer.send(ERROR, utf("YOU AND THE HOST HAVE DIFFERENT GAME VERSIONS"))
        else:
            target.guest = peer
            peer.room = target
            target.host.send(PEER_JOINED)
            peer.send(PEER_JOINED)
            log.info("guest joined room %s", target.code)
    # PING and anything unknown only keep the connection alive.


def leave(peer):
    room = peer.room
    if not room:
        return
    peer.room = None
    if peer is room.host:
        rooms.pop(room.code, None)
        if room.guest:
            room.guest.send(PEER_LEFT)
            room.guest.room = None
            room.guest.writer.close()
        log.info("room %s closed", room.code)
    else:
        room.guest = None
        room.host.send(PEER_LEFT)
        log.info("guest left room %s", room.code)


async def main():
    global fixed_code
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--port", type=int, default=7777)
    parser.add_argument("--policy-port", type=int, default=0,
                        help="serve the Flash socket policy on this port too, e.g. 843 (the projector exe doesn't "
                             "ask for one; a browser-hosted SWF would)")
    parser.add_argument("--fixed-code", help="for testing: give the first host this code")
    parser.add_argument("--stats", action="store_true", help="log each room's data rate every 10 s")
    args = parser.parse_args()
    fixed_code = args.fixed_code
    logging.basicConfig(level=logging.INFO, format="%(asctime)s %(message)s")

    servers = [await asyncio.start_server(handle, "0.0.0.0", args.port)]
    if args.policy_port:
        try:
            servers.append(await asyncio.start_server(serve_policy, "0.0.0.0", args.policy_port))
        except OSError as e:
            log.warning("no policy server on port %d (%s)", args.policy_port, e)
    log.info("relay listening on port %d", args.port)
    tasks = [s.serve_forever() for s in servers]
    if args.stats:
        tasks.append(log_stats())
    await asyncio.gather(*tasks)


async def log_stats():
    while True:
        await asyncio.sleep(10)
        for room in list(rooms.values()):
            if room.host_bytes or room.guest_bytes:
                log.info("room %s: host->guest %.0f KB/s, guest->host %.1f KB/s", room.code,
                         room.host_bytes / 10240, room.guest_bytes / 10240)
                room.host_bytes = room.guest_bytes = 0


if __name__ == "__main__":
    asyncio.run(main())
