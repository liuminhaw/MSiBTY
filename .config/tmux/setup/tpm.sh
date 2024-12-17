#!/usr/bin/env bash

# echo "DRY: ${_DRY}"
# echo "IS DRY: ${_IS_DRY}"

if [[ ${#} -ne 2 ]]; then
    echo "[ERROR] ${FUNCNAME[0]} usage error" 1>&2 
    exit 1
fi

source ${_SCRIPT_DIR}/libs/helper.sh

if [[ ! -d ${HOME}/.tmux/plugins ]]; then
    execute mkdir -p ${HOME}/.tmux/plugins
fi

if [[ ! -d ${HOME}/.tmux/plugins/tpm ]]; then 
    execute git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm
fi
