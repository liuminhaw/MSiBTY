#!/usr/bin/env bash

source ${_SCRIPT_DIR}/libs/helper.sh

execute sudo pacman -Sy --needed tmux

execute install_aur "${HOME}/builds" "https://aur.archlinux.org/tmux-bash-completion-git.git"
