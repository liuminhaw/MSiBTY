#!/usr/bin/env bash

if [[ ${#} -ne 2 ]]; then
    echo "[ERROR] ${FUNCNAME[0]} usage error" 1>&2 
    exit 1
fi

source ${_SCRIPT_DIR}/libs/helper.sh

_src=${1}
_dest=${2}

# memory script
execute curl -L --create-dirs --output ${_dest}/scripts/memory https://raw.githubusercontent.com/vivien/i3blocks-contrib/refs/heads/master/memory/memory
execute chmod +x ${_dest}/scripts/memory

# disk usage script
execute curl -L --create-dirs --output ${_dest}/scripts/disk_usage https://raw.githubusercontent.com/vivien/i3blocks-contrib/refs/heads/master/disk_usage/disk_usage
execute chmod +x ${_dest}/scripts/disk_usage

# battery status script
execute curl -L --create-dirs --output ${_dest}/scripts/battery https://raw.githubusercontent.com/vivien/i3blocks-contrib/refs/heads/master/battery/battery
execute chmod +x ${_dest}/scripts/battery

# cpu usage script
execute curl -L --create-dirs --output ${_dest}/scripts/cpu_usage https://raw.githubusercontent.com/vivien/i3blocks-contrib/refs/heads/master/cpu_usage/cpu_usage
execute chmod +x ${_dest}/scripts/cpu_usage

# volume status script
execute curl -L --create-dirs --output ${_dest}/scripts/volume-pulseaudio https://raw.githubusercontent.com/vivien/i3blocks-contrib/refs/heads/master/volume-pulseaudio/volume-pulseaudio
execute chmod +x ${_dest}/scripts/volume-pulseaudio

