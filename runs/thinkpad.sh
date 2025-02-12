#!/usr/bin/env bash

source ${_SCRIPT_DIR}/libs/helper.sh

# echo "Dry: ${_DRY}"
# echo "Is Dry: ${_IS_DRY}"

execute sudo pacman -Sy

execute install_aur "${HOME}/builds" "https://aur.archlinux.org/thinkfan.git"
execute install_aur "${HOME}/builds" "https://aur.archlinux.org/thinkfan-ui.git"

