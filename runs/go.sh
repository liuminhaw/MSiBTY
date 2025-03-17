#!/usr/bin/env bash

source ${_SCRIPT_DIR}/libs/helper.sh

execute sudo pacman -Sy --needed go hugo
execute go install golang.org/x/tools/cmd/godoc@latest
