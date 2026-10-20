# Online relay

Flash can't accept incoming connections, so both players connect out to this small relay. The host gets a join code, the friend sends that code, and the relay passes data between them. It's one Python file with no dependencies (`relay.py`, Python 3.8+).

## Free server in Johannesburg (Oracle Cloud Always Free)

Oracle's Always Free tier includes small VMs that don't expire, and it has a Johannesburg region. One VM can run the relay for you and your friends.

1. **Sign up** at [oracle.com/cloud/free](https://www.oracle.com/cloud/free/). Pick **South Africa Central (Johannesburg)** as the home region. It can't be changed later, and Always Free VMs only run in the home region. A card is needed for verification; Always Free resources aren't charged.
2. **Create the VM:** *Compute → Instances → Create instance*.
   - Image: **Canonical Ubuntu** (22.04 or 24.04).
   - Shape: **VM.Standard.E2.1.Micro** (AMD, Always Free). If it says out of capacity, try **VM.Standard.A1.Flex** with 1 OCPU / 6 GB, or try again later.
   - Keep "Assign a public IPv4 address" on, and download the SSH private key.
   - Note the instance's **public IP**.
3. **Open port 7777 in Oracle's firewall:** on the instance page, open the subnet → its *Security List* → *Add Ingress Rules*: source `0.0.0.0/0`, protocol TCP, destination port `7777`.
4. **Install the relay** (from your PC, in this `relay` folder):
   ```sh
   scp -i <key> relay.py rk2-relay.service ubuntu@<IP>:~
   ssh -i <key> ubuntu@<IP>
   ```
   Then on the server:
   ```sh
   sudo mkdir -p /opt/rk2-relay && sudo mv relay.py /opt/rk2-relay/
   sudo mv rk2-relay.service /etc/systemd/system/
   # Oracle's Ubuntu images also block ports in iptables (the rule must go above their REJECT rule):
   sudo iptables -I INPUT 1 -m state --state NEW -p tcp --dport 7777 -j ACCEPT
   sudo netfilter-persistent save
   sudo systemctl daemon-reload
   sudo systemctl enable --now rk2-relay
   systemctl status rk2-relay      # should say "active (running)"
   ```
5. **Point the game at it:** the exe has a built-in server address (`relayHost` in `src/scripts/Tools/Net.as`). To use your own, set `relay=<IP>:7777` in `online.txt` next to the exe; both players need the same one.

Logs: `journalctl -u rk2-relay -f`. Add `--stats` to `ExecStart` to log each game's data rate.

**Note:** Oracle may reclaim Always Free VMs that stay almost idle for 7 days (CPU, network and memory all under 20%). A relay that's only used now and then can hit that. If it gets reclaimed, recreate it with the same steps. Upgrading the account to Pay As You Go stops reclaiming, and Always Free resources still cost nothing.

## Testing on one PC

```sh
python relay/relay.py --fixed-code TEST --stats
```

Make two folders, each with a copy of the exe and an `online.txt`:

- Host: `relay=127.0.0.1:7777`, `autohost=1`, `autostart=1` (jumps straight into mission 1 on the first save)
- Guest: `relay=127.0.0.1:7777`, `autojoin=TEST`

Both copies share the same save file, so back up `robokill2.sol` first (see the main README).

## Protocol

Every message is `u32 length` (big-endian, includes the type byte), `u8 type`, payload. Strings are `u16 length` + UTF-8.

| Type | Direction | Payload |
|---|---|---|
| 1 HOST | client → relay | version |
| 2 JOIN | client → relay | code, version |
| 3 DATA | both | game data, forwarded to the other player |
| 4 PING | client → relay | (keep-alive) |
| 10 CODE | relay → host | join code |
| 11 PEER_JOINED | relay → both | |
| 12 PEER_LEFT | relay → remaining player | |
| 13 ERROR | relay → client | message |

The game data itself is defined in `src/scripts/Tools/Net.as`.
