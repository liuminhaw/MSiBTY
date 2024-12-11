#!/bin/bash

source ${_SCRIPT_DIR}/libs/helper.sh

# echo "Dry: ${_DRY}"
# echo "Is Dry: ${_IS_DRY}"

execute sudo pacman -Sy --needed git \
    less \
    which \
    wget \
    man-db man-pages texinfo \
    lshw \
    zip unzip \
    fuse2
