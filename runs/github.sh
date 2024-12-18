#!/usr/bin/env bash

source ${_SCRIPT_DIR}/libs/helper.sh

execute sudo pacman -Sy --needed github-cli

if ! gh status &> /dev/null; then
    execute gh auth login
fi

execute gh extension install yusukebe/gh-markdown-preview

