#!/bin/bash

source ${_SCRIPT_DIR}/libs/helper.sh

execute sudo pacman -Sy --needed pulseaudio pulseaudio-alsa

# Enable and start pulseaudio service
execute systemctl --user enable pulseaudio.service
execute systemctl --user start pulseaudio.service


