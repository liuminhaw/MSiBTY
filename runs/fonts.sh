#!/bin/bash

source ${_SCRIPT_DIR}/libs/helper.sh

# echo "Dry: ${_DRY}"
# echo "Is Dry: ${_IS_DRY}"

execute sudo pacman -Sy --needed ttf-intone-nerd

execute install_aur "${HOME}/builds" "https://aur.archlinux.org/noto-fonts-tc.git"
