# Robokill 2: Leviathan Five — Local Co-op Mod

Two-player local co-op and controller support for the Flash game *Robokill 2: Leviathan Five*.

## Play

Run **`Robokill 2 (Co-op).exe`**. It bundles the Adobe Flash Player 32 projector, so nothing needs to be installed.

### Who controls what

| Setup | Player 1 (yellow) | Player 2 (green) |
|---|---|---|
| No controller | Keyboard + mouse | — |
| 1 controller | Keyboard + mouse | Controller |
| 2 controllers | Keyboard + mouse and/or controller 1 | Controller 2 |

In menus, any controller moves the cursor and **RT / A / LT** acts as a left click.

### Player 2 controls

| Button | Action |
|---|---|
| START (or A) | Join the game |
| Left stick / D-pad | Move |
| Right stick | Aim (green crosshair) |
| RT / A / LT | Fire |
| LB / X | Use active item 1 |
| RB | Use active item 2 |
| START | Pause |
| Back | Map |
| Y | Inventory |

Press **F9** in-game to see raw controller values, which helps if buttons are mapped wrong on your controller.

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

Main mod code: `src/scripts/Tools/Input.as` (controllers), `src/scripts/ObjectBase/PlayerBase.as` (player 2), `src/scripts/Scenes/MainScene.as` (co-op logic: join, respawn, targeting).

## Credits

*Robokill 2: Leviathan Five* is by Rock Solid Arcade. This is an unofficial fan mod.

The MIT license in `LICENSE` covers the mod's own changes and build scripts. The original game's code, art and sounds belong to their owners, and the bundled Flash Player projector belongs to Adobe.
