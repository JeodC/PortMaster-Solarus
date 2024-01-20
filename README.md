# Solarus for PortMaster
## Introduction
The Solarus RPG game engine set up to run with PortMaster. Many retro handheld firmwares have Solarus built in, but some do not. Further, built-in Solarus is at the mercy of provided firmware libraries and joystick configs.
By running Solarus through PortMaster, we can provide additional libraries as needed and customize controls via GPtoKeyB (Gamepad to Keyboard emulation).

## Usage
Unzip to ports folder. Games (the `.solarus` files) need to be downloaded separately and added to the `solarus/games` folder. 
Find them on the [Solarus Website](https://solarus-games.org/games/).  

You can copy the contents of `gamelist.xml` into your own `gamelist.xml` file.

## Thanks
The solarus-run binary provided by Cebion.  
Max Mraz for assisting with game patching.  
[Solarus](https://solarus-games.org/)
