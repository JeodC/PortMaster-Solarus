# Solarus for PortMaster
## Introduction
The Solarus RPG game engine set up to run with PortMaster. Many retro handheld firmwares have Solarus built in, but some do not. Further, built-in Solarus is at the mercy of provided firmware libraries and joystick configs.
By running Solarus through PortMaster, we can provide additional libraries as needed and customize controls via GPtoKeyB (Gamepad to Keyboard emulation).

## Usage
Unzip to `roms/ports` folder. Games (the `.solarus` files) need to be downloaded separately and added to the `portgame/game` folder or the `solarusengine/games` folder if you're using the AIO zip.  

Find the games on the [Solarus Website](https://solarus-games.org/games/).  

Find a Solarus Engine game not listed here? Request it!  

## Testing Data
Created at https://plaintexttools.github.io/plain-text-table/
```
╔════════╤════════════╤═══════════╤═╤════════╤════════════╤═══════╗
║ Tested │ Resolution │ CFW       │ │ Tested │ Resolution │ CFW   ║
╠════════╪════════════╪═══════════╪═╪════════╪════════════╪═══════╣
║ x      │ 480x320    │ AmberELEC │ │        │ 720x720    │ ArkOS ║
╟────────┼────────────┼───────────┼─┼────────┼────────────┼───────╢
║ x      │ 480x320    │ ArkOS     │ │        │ 720x720    │ JelOS ║
╟────────┼────────────┼───────────┼─┼────────┼────────────┼───────╢
║        │ 480x320    │ JelOS     │ │        │ 854x480    │ ArkOS ║
╟────────┼────────────┼───────────┼─┼────────┼────────────┼───────╢
║        │ 640x480    │ AmberELEC │ │        │ 960x544    │ ArkOS ║
╟────────┼────────────┼───────────┼─┼────────┼────────────┼───────╢
║        │ 640x480    │ ArkOS     │ │ x      │ 1280x720   │ JelOS ║
╟────────┼────────────┼───────────┼─┼────────┼────────────┼───────╢
║        │ 640x480    │ JelOS     │ │        │ 1920x1152  │ ArkOS ║
╚════════╧════════════╧═══════════╧═╧════════╧════════════╧═══════╝
```

## Thanks
The solarus-run binary provided by Cebion.  
Max Mraz for assisting with troubleshooting.  
[Solarus Team](https://solarus-games.org/).
