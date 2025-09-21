#!/usr/bin/env bash

source ${_SCRIPT_DIR}/libs/helper.sh

# echo "Dry: ${_DRY}"
# echo "Is Dry: ${_IS_DRY}"

_release_info=$(curl -s https://api.github.com/repos/liuminhaw/mthc/releases/latest)
_src=$(echo "${_release_info}" | grep "browser_download_url.*zst" | cut -d : -f 2,3 | tr -d \")
_file=$(basename "${_src}")

execute wget -O /tmp/${_file} ${_src}
execute sudo pacman -U /tmp/${_file}

execute rm /tmp/${_file}
