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

# Exports
export LD_LIBRARY_PATH="$GAMEDIR/lib:/usr/lib"

# Set variables
GAMEDIR="/$directory/ports/zeldaxd-mercurischess"

#Create savedir
$ESUDO rm -rf ~/.solarus/zelda-xd2-mercuris-chess
ln -sfv $GAMEDIR/savedata ~/.solarus/zelda-xd2-mercuris-chess

cd $GAMEDIR

# Setup controls
$ESUDO chmod 666 /dev/tty1
$ESUDO chmod 666 /dev/uinput
$GPTOKEYB "solarus-run" -c "zxdmc.gptk" & 

# Run the game
./solarus-run $GAMEDIR/game/*.solarus 2>&1 | tee -a ./"log.txt"
$ESUDO kill -9 $(pidof gptokeyb)
$ESUDO systemctl restart oga_events & 
printf "\033c" >> /dev/tty1