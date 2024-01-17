# Solarus for PortMaster
## Introduction
The Solarus RPG game engine set up to run with PortMaster. Many retro handheld firmwares have Solarus built in, but some do not. Further, built-in Solarus is at the mercy of provided firmware libraries and joystick configs.
By running Solarus through PortMaster, we can provide additional libraries as needed and customize controls via GPtoKeyB.

## Usage
Unzip to ports folder. Scripts provided are an example, and an easy template. For different games, one only needs to change the `$GAME` variable. Games (the `.solarus` files) need to be downloaded separately and added to the `solarus/games` folder. 
Find them on the [Solarus Website](https://solarus-games.org/games/).  

You can copy the contents of `gamelist.xml` into your own `gamelist.xml` file.

## Disclaimers
This is just a Solarus runner. Certain games may have issues running on various devices. The games `Ocean's Heart`, `Hallow's Eve`, and `Tunics!` are a few that do not function as expected on an Anbernic RG351P running AmberELEC, for example.

## Thanks
The solarus-run binary provided by Cebion.
[Solarus](https://solarus-games.org/)
