#!/usr/bin/env bash

switch_to() {
    if [[ ${#} -ne 1 ]]; then
        echo "[ERROR] ${FUNCNAME[0]} usage error" 1>&2
        exit 1
    fi

    local _selected_name=${1}

    if [[ -z ${TMUX} ]]; then
        tmux attach-session -t ${_selected_name}
    else
        tmux switch-client -t ${_selected_name}
    fi
}

_selected=$(find ~/coding -mindepth 1 -maxdepth 3 -type d ! -path '*/.*' | fzf)
# _selected=$(find ~/ -mindepth 1 -maxdepth 5 -type d ! -path '*/.*' | fzf)
# _selected=$(find ~/ -type d | fzf)
if [[ -z ${_selected} ]]; then
    exit 0
fi

_selected_name=$(basename ${_selected} | tr ":,. " "____")

if tmux has-session -t=${_selected_name} 2> /dev/null; then
    switch_to ${_selected_name}
else
    tmux new-session -ds ${_selected_name} -c ${_selected}
    tmux send-keys -t ${_selected_name} "ready-tmux" Enter
    switch_to ${_selected_name}
fi

