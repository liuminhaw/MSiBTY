#!/bin/bash

# Run `startx /usr/bin/i3` to start i3 window manager

source ${_SCRIPT_DIR}/libs/helper.sh

execute sudo pacman -Sy --needed xorg-server xorg-xinit 
execute sudo pacman -Sy --needed i3 dmenu
