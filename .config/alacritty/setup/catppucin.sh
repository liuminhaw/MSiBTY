#!/bin/bash

if [[ ${#} -ne 2 ]]; then
    echo "[ERROR] ${FUNCNAME[0]} usage error" 1>&2 
    exit 1
fi

source ${_SCRIPT_DIR}/libs/helper.sh

_src=${1}
_dest=${2}

execute mkdir -p ${_dest}/themes
execute curl -LO --output-dir ${_dest}/themes https://github.com/catppuccin/alacritty/raw/main/catppuccin-mocha.toml
