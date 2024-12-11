#!/bin/bash

# reflector is a Python script which can retrieve the latest mirror list from the Arch Linux Mirror Status page
# filter the most up-to-date mirrors, sort them by speed and overwrite the file /etc/pacman.d/mirrorlist
# 
# Ref: https://wiki.archlinux.org/title/Reflector

source ${_SCRIPT_DIR}/libs/helper.sh

execute sudo pacman -Sy --needed reflector

execute sudo systemctl enable reflector.timer
execute sudo systemctl start reflector.timer



