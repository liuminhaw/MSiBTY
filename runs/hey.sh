#!/usr/bin/env bash

source ${_SCRIPT_DIR}/libs/helper.sh

# echo "Dry: ${_DRY}"
# echo "Is Dry: ${_IS_DRY}"

_file=hey_linux_amd64

execute wget -O /tmp/${_file} \
    https://hey-release.s3.us-east-2.amazonaws.com/${_file}

execute mkdir -p ${HOME}/bin
execute mv /tmp/${_file} ${HOME}/bin/hey
execute chmod +x ${HOME}/bin/hey
