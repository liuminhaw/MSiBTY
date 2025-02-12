#!/usr/bin/env bash

source ${_SCRIPT_DIR}/libs/helper.sh

# echo "Dry: ${_DRY}"
# echo "Is Dry: ${_IS_DRY}"

if [[ ${_IS_DRY} -eq 1 ]]; then
    echo "[DRY RUN]: curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh"
else
    echo "[EXECUTE]: curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh"
    curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
fi


