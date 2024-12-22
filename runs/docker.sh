#!/usr/bin/env bash

source ${_SCRIPT_DIR}/libs/helper.sh

# echo "Dry: ${_DRY}"
# echo "Is Dry: ${_IS_DRY}"

execute sudo pacman -Sy --needed docker docker-compose docker-buildx

execute sudo systemctl enable docker
execute sudo systemctl start docker

execute sudo usermod -aG docker ${USER}


