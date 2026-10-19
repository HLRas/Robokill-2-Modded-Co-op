# Robokill 2: Leviathan Five — Local Co-op Mod

Two-player local co-op and controller support for the Flash game *Robokill 2: Leviathan Five*.

## Play

Run **`Robokill 2 (Co-op).exe`**. It bundles the Adobe Flash Player 32 projector, so nothing needs to be installed.

### Who controls what

| Setup | Player 1 (yellow) | Player 2 (green) |
|---|---|---|
| No controller | Keyboard + mouse | — |
| 1 controller, solo (default) | Keyboard + mouse and/or the controller | — |
| 1 controller, co-op | Keyboard + mouse | The controller |
| 2 controllers | Keyboard + mouse and/or controller 1 | Controller 2 |

**Starting co-op:** hold **START for 3 seconds** on the joining controller: the only controller, or controller 2. A countdown shows at the top of the screen. With one controller, it switches from Player 1 to Player 2, and Player 1 carries on with keyboard + mouse.

**Leaving co-op:** Player 2 holds **START for 3 seconds**. With one controller, it goes back to controlling Player 1.

A quick tap of START pauses. In menus, any controller moves the cursor and **RT / A / LT** acts as a left click.

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

Main mod code: `src/scripts/Tools/Input.as` (controllers, crosshairs), `src/scripts/ObjectBase/PlayerBase.as` (player 2, lock-on, full-charge indicator), `src/scripts/Scenes/MainScene.as` (co-op logic: join, respawn, targeting), `src/scripts/Scenes/MainMenu.as` (cheat code).

## Credits

*Robokill 2: Leviathan Five* is by Rock Solid Arcade. This is an unofficial fan mod.

The MIT license in `LICENSE` covers the mod's own changes and build scripts. The original game's code, art and sounds belong to their owners, and the bundled Flash Player projector belongs to Adobe.
