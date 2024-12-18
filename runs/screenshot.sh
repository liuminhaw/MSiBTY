#!/usr/bin/env bash

source ${_SCRIPT_DIR}/libs/helper.sh

# echo "Dry: ${_DRY}"
# echo "Is Dry: ${_IS_DRY}"

execute sudo pacman -Sy shutter
execute sudo pacman -Sy maim xclip xdotool

execute mkdir ${HOME}/Screenshots
