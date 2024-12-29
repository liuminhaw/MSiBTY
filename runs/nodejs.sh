#!/usr/bin/env bash

source ${_SCRIPT_DIR}/libs/helper.sh

execute sudo pacman -Sy --needed nodejs npm

execute sudo npm install -g hallmark
