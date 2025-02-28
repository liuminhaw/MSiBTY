#!/usr/bin/env bash

source ${_SCRIPT_DIR}/libs/helper.sh

# echo "Dry: ${_DRY}"
# echo "Is Dry: ${_IS_DRY}"

if which go > /dev/null; then
    execute go install github.com/bootdotdev/bootdev@latest
fi

