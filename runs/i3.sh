#!/bin/bash

# Run `startx /usr/bin/i3` to start i3 window manager

source ${_SCRIPT_DIR}/libs/helper.sh

execute sudo pacman -Sy --needed xorg-server xorg-xinit xorg-xinput
execute sudo pacman -Sy --needed i3 dmenu

execute sudo pacman -Sy --needed i3blocks

