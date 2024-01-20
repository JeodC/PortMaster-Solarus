# Solarus for PortMaster
## Introduction
The Solarus RPG game engine set up to run with PortMaster. Many retro handheld firmwares have Solarus built in, but some do not. Further, built-in Solarus is at the mercy of provided firmware libraries and joystick configs.
By running Solarus through PortMaster, we can provide additional libraries as needed and customize controls via GPtoKeyB (Gamepad to Keyboard emulation).

## Usage
Unzip to ports folder. Games (the `.solarus` files) need to be downloaded separately and added to the `solarus/games` folder. 
Find them on the [Solarus Website](https://solarus-games.org/games/).  

You can copy the contents of `gamelist.xml` into your own `gamelist.xml` file.

## Disclaimers
Certain games have patches applied on first run. These patches help the games boot and play, but may have unintended side effects later on. Other Solarus games have been tested but either would not work or would require extensive patching.

## Thanks
The solarus-run binary provided by Cebion.
[Solarus](https://solarus-games.org/)
