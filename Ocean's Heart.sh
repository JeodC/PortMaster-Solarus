#!/bin/bash

# Source SDL controls
if [ -d "/opt/system/Tools/PortMaster/" ]; then
  controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
  controlfolder="/opt/tools/PortMaster"
else
  controlfolder="/roms/ports/PortMaster"
fi
source $controlfolder/control.txt
get_controls

# Set variables
SOLARUSDIR="/$directory/ports/solarus"
CONFIG="/$directory/gamedata/solarus/saves"
GAMEDIR="$SOLARUSDIR/games"
GPTKDIR="$SOLARUSDIR/gptk"
GAME="oceansheart"

#Check for savedir
if [ ! -d "$CONFIG" ]; then
    mkdir -p "$CONFIG"
fi

export LD_LIBRARY_PATH="$SOLARUSDIR/lib"

cd $SOLARUSDIR

# Setup controls
$ESUDO chmod 666 /dev/tty1
$ESUDO chmod 666 /dev/uinput
$GPTOKEYB "solarus-run" -xbox360 & 

# Run the game
chmod +xwr ./solarus-run
./solarus-run "$GAMEDIR/$GAME.solarus" -force-software-rendering 2>&1 | tee -a ./"logs/${GAME}_log.txt"
$ESUDO kill -9 $(pidof gptokeyb)
$ESUDO systemctl restart oga_events & 
printf "\033c" >> /dev/tty1