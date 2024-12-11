#!/bin/bash

source ${_SCRIPT_DIR}/libs/helper.sh

# echo "Dry: ${_DRY}"
# echo "Is Dry: ${_IS_DRY}"

execute install_aur "${HOME}/builds" "https://aur.archlinux.org/google-chrome.git"
