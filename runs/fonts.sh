#!/usr/bin/env bash

source ${_SCRIPT_DIR}/libs/helper.sh

# echo "Dry: ${_DRY}"
# echo "Is Dry: ${_IS_DRY}"

execute sudo pacman -Sy --needed ttf-intone-nerd ttf-font-awesome 
execute sudo pacman -Sy noto-fonts-emoji noto-fonts

execute install_aur "${HOME}/builds" "https://aur.archlinux.org/noto-fonts-tc.git"

