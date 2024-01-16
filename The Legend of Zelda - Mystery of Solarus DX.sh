#!/bin/bash

if [ -d "/opt/system/Tools/PortMaster/" ]; then
  controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
  controlfolder="/opt/tools/PortMaster"
else
  controlfolder="/roms/ports/PortMaster"
fi

source $controlfolder/control.txt

get_controls

source $controlfolder/device_info.txt

SOLARUSDIR="/$directory/ports/solarus"
GAMEDIR="$SOLARUSDIR/games"
GAME="zmos"

cd $SOLARUSDIR

# Setup controls
$ESUDO chmod 666 /dev/tty1
$ESUDO chmod 666 /dev/uinput
$GPTOKEYB "solarus-run" -xbox360 & 

# Run the game
chmod +xwr ./solarus-run
./solarus-run "$GAMEDIR/$GAME.solarus" 2>&1 | tee -a ./"${GAME}_log.txt"
$ESUDO kill -9 $(pidof gptokeyb)
$ESUDO systemctl restart oga_events & 
printf "\033c" >> /dev/tty1
