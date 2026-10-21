# Robokill 2: Leviathan Five — Local Co-op Mod

Two-player local co-op and controller support for the Flash game *Robokill 2: Leviathan Five*.

## Play

Run **`Robokill 2 (Co-op).exe`**. It bundles the Adobe Flash Player 32 projector, so nothing needs to be installed.

The title screen shows the mod version (**CO-OP MOD V1.0**, then V1.01, V1.02, … with each update; **BETA** on the beta channel). Online play needs the same version on both PCs.

### Updates

Keep the exe together with the `fscommand` folder (it holds the updater).

- **RELEASE** is the `main` branch; **BETA** is the `working-tree` branch, with newer but less tested changes.
- **UPDATES** on the title screen shows what you have installed and the latest release and beta. Pick one to switch to it (or reinstall it). After you confirm, the game closes, the updater downloads that version from GitHub, and the game restarts.
- If your channel has a newer version, the title screen offers it when the game starts.
- The updater only replaces `Robokill 2 (Co-op).exe` and writes `channel.txt`. Saves aren't touched.

### Who controls what

| Setup | Player 1 (yellow) | Player 2 (green) |
|---|---|---|
| No controller | Keyboard + mouse | — |
| 1 controller, solo (default) | Keyboard + mouse and/or the controller | — |
| 1 controller, co-op | Keyboard + mouse | The controller |
| 2 controllers | Keyboard + mouse and/or controller 1 | Controller 2 |

**Starting co-op:** hold **START for 3 seconds** on the joining controller: the only controller, or controller 2. A countdown shows at the top of the screen. With one controller, it switches from Player 1 to Player 2, and Player 1 carries on with keyboard + mouse.

**Leaving co-op:** Player 2 holds **START for 3 seconds**. With one controller, it goes back to controlling Player 1.

A quick tap of START pauses. In menus, any controller moves the cursor and **RT / A / LT** acts as a left click. The same goes while a comms message is on screen, so you can press its **SKIP** button.

### Player 2 controls

| Button | Action |
|---|---|
| Hold START (3 s) | Join / leave co-op |
| Left stick / D-pad | Move |
| Right stick | Aim (green crosshair) |
| RT / A / LT | Fire |
| LB / X | Use active item 1 |
| RB | Use active item 2 |
| Tap START | Pause |
| Back | Map |
| Y | Inventory |

Press **F9** in-game to see raw controller values, which helps if buttons are mapped wrong on your controller.

### Extras

- **Controller lock-on for point weapons:** the Laser, Shredder, Charge Laser, Cluster Grenades and Charge Rockets hit at the aim point rather than along the aim line. On a controller (either player), a faint bracket reticle shows where they will hit while one is equipped. It locks onto the nearest enemy within about 20° of where you're aiming and turns brighter when locked. Crack tiles and thrown bombs are ignored. With no enemy in that cone, shots hit at the normal crosshair. Mouse aiming works as before.
- **Full-charge indicator:** when a charge weapon is fully charged, it bleeps and flashes white, then keeps blinking until you fire.
- **Cheat code:** on the *Select a Mission* screen, press **↑ ↓ ← → ↑ ↑ ↓ ←** on the keyboard. It unlocks all 12 missions, raises the player to level 50 (if lower) and adds $1,000,000, for the selected save only. A sound plays when it works.

### Co-op rules

- Cash, XP, level, keys, inventory and the weapon loadout are shared. Each player has their own shields.
- Enemies go for whichever player is closest. Either player can walk through a door, and the other comes along.
- If one player dies, the other keeps going. The downed player respawns next to their partner once the room is cleared, with no button press or penalty.
- If both die, it works like single player: you lose a little cash, the enemy reclaims rooms, and you restart from the checkpoint.

## Online co-op

A friend can join over the internet as Player 2.

- **Host:** start a mission and pause. The pause menu shows **ONLINE: JOIN CODE: XXXXXX**. Give your friend the code.
- **Friend:** on the title screen choose **JOIN ONLINE**, type the code and press **CONNECT**. They see your game and play Player 2 with their controller, or the keyboard: **WASD** move, **arrow keys** aim and fire, **Space / Shift** items, **I** inventory, **M** map, **P** pause, **Enter** to click in menus.
- **Leaving:** the friend presses **ESC** (or holds **BACK** for 3 seconds). If they reconnect with the same code, they spawn again.

**Setup:** nothing. The exe connects to a built-in server, a small free relay on Oracle Cloud in Johannesburg. To run your own, see [relay/README.md](relay/README.md) and set `relay=<ip>:7777` in `online.txt` next to the exe (both players).

How it works: the host's game does everything. Your friend's copy runs no game logic: it shows a live copy of the host's screen and sends its controller back. Pictures the friend's copy already has are sent by name, text as text, and each frame only says what moved; the friend's copy plays frames a little behind (as little as the connection's jitter allows) and blends movement between them at 60 fps, so it stays smooth. That needs about 10–40 KB/s from the host, plus pictures on new rooms. Both players must run the same version of the exe.

- **Your own robot moves straight away.** The friend's copy draws Player 2 (body, legs, guns, shadow and the green crosshair) where its own input is taking it, replaying that input with the game's movement maths (counted in the host's game ticks) instead of waiting a round trip for the host. A correction from the host blends in over about 100 ms. To turn this off, put `predict=0` in the friend's `online.txt`.
- **Your own shots are instant, and what you hit counts.** With the Blaster, Shotgun, Pulse Gun, Plasma Shotgun and Grenade launcher, the friend's copy fires Player 2's guns itself, from the robot it draws, and moves the bullets with the game's rules (room edges, crates, pulse bounces). If a bullet hits an enemy on the friend's screen, the host applies the hit through the game's normal damage code (shields, kills, drops and experience as usual), even if it would have missed on the host. The host still flies its own copies of those bullets, so crates and barrels break on both screens. Lasers, the Shredder and charge weapons are still fired by the host. `localshots=0` in the host's `online.txt` turns this off.
- **Rooms appear straight away.** The friend's copy builds each room's floor itself from the host's list of draw calls (a few KB instead of ~700 KB of pixels), and floor marks (blood, scorch marks) are sent the same way. Every picture the friend's copy of the game already has (enemy and effect animations, tiles, decals) is sent by name; joining takes a moment while both copies load those pictures.
- **No lag build-up on slow connections.** The friend's copy acknowledges every frame. The host only sends a new frame while the link isn't queueing, and sends pictures (new rooms, floor marks) in small pieces between frames, as fast as the link allows. A slow upload makes pictures arrive later instead of delaying everything.
- **Quick taps count.** A button pressed and released between two frames still reaches the game.

Press **F8** on either side for live stats: round trip between the players (`rtt`), ping to the server, upload/download, frames skipped and pictures waiting (host), jitter, playback delay, late frames, and how far Player 2 would be drawn from its real position without and with prediction (`player 2 off 36>2`), and the average correction when a host frame arrives (`fix`, which is what shows as rubber banding; guest).

## Save games

Saves are **not** stored in this folder. Flash keeps them per Windows user in:

```
%APPDATA%\Macromedia\Flash Player\#SharedObjects\<random>\localhost\robokill2.sol
```

Pulling, pushing or re-cloning the repo never uploads, overwrites or wipes anyone's saves. `.gitignore` also blocks `*.sol` and other save files in case one gets copied in here. To back up your saves, copy that `.sol` file somewhere safe. Every local Robokill 2 exe (original, controller or co-op) shares the same save file.

## Build from source

Requirements: Windows and Java 11+ on PATH.

Some asset file names are long. If cloning fails with "Filename too long", run `git config --global core.longpaths true` or clone into a shorter folder.

```powershell
powershell -ExecutionPolicy Bypass -File build\build.ps1
```

The script downloads [JPEXS FFDec](https://github.com/jindrapetrik/jpexs-decompiler) 26.3.0 and the Adobe Flash Player 32 projector into `tools/` (git-ignored). It compiles the classes listed in `build/modified-classes.txt` into `original/Robokill2.swf`, sets the SWF version to 21 (needed for controllers), and writes `Robokill 2 (Co-op).exe`.

Notes:
- FFDec can only **replace** existing classes, not add new ones. Put new code into existing classes.
- If you change another class in `src/scripts`, add its path to `build/modified-classes.txt`.

## Layout

| Path | What |
|---|---|
| `Robokill 2 (Co-op).exe` | Ready-to-play build |
| `original/Robokill2.swf` | Unmodified game, used as the base for builds |
| `src/` | Decompiled game: ActionScript in `scripts/`, plus images, sounds and fonts |
| `build/` | Build script and the list of modified classes |
| `relay/` | Online co-op relay server and setup guide |
| `fscommand/`, `updater/` | The updater the game starts (built from `updater/Updater.cs`), and its source |
| `version.txt` | The mod version, read from GitHub by the updater (written by the build) |
| `online.txt` | Which relay server online co-op uses |

Main mod code: `src/scripts/Tools/Input.as` (controllers, crosshairs), `src/scripts/ObjectBase/PlayerBase.as` (player 2, lock-on, full-charge indicator), `src/scripts/Scenes/MainScene.as` (co-op logic: join, respawn, targeting), `src/scripts/Scenes/MainMenu.as` (cheat code, join screen), `src/scripts/Tools/Net.as` (online co-op).

## Credits

*Robokill 2: Leviathan Five* is by Rock Solid Arcade. This is an unofficial fan mod.

The MIT license in `LICENSE` covers the mod's own changes and build scripts. The original game's code, art and sounds belong to their owners, and the bundled Flash Player projector belongs to Adobe.
