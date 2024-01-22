# Solarus for PortMaster
## Introduction
The Solarus RPG game engine set up to run with PortMaster. Many retro handheld firmwares have Solarus built in, but some do not. Further, built-in Solarus is at the mercy of provided firmware libraries and joystick configs.
By running Solarus through PortMaster, we can provide additional libraries as needed and customize controls via GPtoKeyB (Gamepad to Keyboard emulation).

## Usage
Unzip to `roms/ports` folder. Games (the `.solarus` files) need to be downloaded separately and added to the `portgame/game` folder or the `solarusengine/games` folder if you're using the AIO zip.  

Find the games on the [Solarus Website](https://solarus-games.org/games/).  

Find a Solarus Engine game not listed here? Request it!  

## Testing Data
╔════════╤══════════════╤═══════════╤═╤════════╤════════════╤═══════════╗
║ Tested │ Device       │ CFW       │ │ Tested │ Device     │ CFW       ║
╠════════╪══════════════╪═══════════╪═╪════════╪════════════╪═══════════╣
║ x      │ RG351P/M     │ AmberELEC │ │        │ RG353M/V/P │ ArkOS     ║
╟────────┼──────────────┼───────────┼─┼────────┼────────────┼───────────╢
║        │ RG351P/M     │ ArkOS     │ │        │ RG353M/V/P │ JelOS     ║
╟────────┼──────────────┼───────────┼─┼────────┼────────────┼───────────╢
║        │ RG351P/M     │ JelOS     │ │        │ RG503      │ ArkOS     ║
╟────────┼──────────────┼───────────┼─┼────────┼────────────┼───────────╢
║        │ RG351V       │ AmberELEC │ │        │ RG552      │ AmberELEC ║
╟────────┼──────────────┼───────────┼─┼────────┼────────────┼───────────╢
║        │ RG351V       │ ArkOS     │ │        │ RG552      │ ArkOS     ║
╟────────┼──────────────┼───────────┼─┼────────┼────────────┼───────────╢
║        │ RG351V       │ JelOS     │ │        │ RGB10      │ ArkOS     ║
╟────────┼──────────────┼───────────┼─┼────────┼────────────┼───────────╢
║        │ RG353        │ AmberELEC │ │        │ RGB30      │ ArkOS     ║
╟────────┼──────────────┼───────────┼─┼────────┼────────────┼───────────╢
║        │ RG353        │ ArkOS     │ │        │ RGB30      │ JelOS     ║
╟────────┼──────────────┼───────────┼─┼────────┼────────────┼───────────╢
║        │ RG353        │ JelOS     │ │        │ RK2023     │ ArkOS     ║
╟────────┼──────────────┼───────────┼─┼────────┼────────────┼───────────╢
║        │ Powkiddy x55 │ JelOS     │ │        │            │           ║
╚════════╧══════════════╧═══════════╧═╧════════╧════════════╧═══════════╝

## Thanks
The solarus-run binary provided by Cebion.  
Max Mraz for assisting with troubleshooting.  
[Solarus Team](https://solarus-games.org/).
