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
GAMEDIR="/$directory/ports/oceansheart"

#Create savedir
$ESUDO rm -rf ~/.solarus/oceans-heart-saves
ln -sfv $GAMEDIR/savedata ~/.solarus/oceans-heart-saves

# Patch stuff
if [ -d "$GAMEDIR/patch/" ]; then
    for solarus_file in "$GAMEDIR/game"/*.solarus; do
        if [ -e "$solarus_file" ]; then
            "$GAMEDIR/lib/7za" l "$solarus_file" | grep -i 'swipe_fade.lua'
            if [ $? -eq 0 ]; then
                "$GAMEDIR/lib/7za" a -r "$solarus_file" "$GAMEDIR/patch/scripts/"
                rm -r "$GAMEDIR/patch/"
            fi
        fi
    done
fi

cd $GAMEDIR

# Setup controls
$ESUDO chmod 666 /dev/tty1
$ESUDO chmod 666 /dev/uinput
$GPTOKEYB "solarus-run" -c "oceansheart.gptk" & 
SDL_GAMECONTROLLERCONFIG="$sdl_controllerconfig"

# Run the game
./solarus-run $GAMEDIR/game/*.solarus 2>&1 | tee -a ./"log.txt"
$ESUDO kill -9 $(pidof gptokeyb)
$ESUDO systemctl restart oga_events & 
printf "\033c" >> /dev/tty1