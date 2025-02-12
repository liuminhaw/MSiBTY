#!/usr/bin/env bash

source ${_SCRIPT_DIR}/libs/helper.sh

# echo "Dry: ${_DRY}"
# echo "Is Dry: ${_IS_DRY}"

_version=v0.1.0
_file=edtmp_${_version}.tar.gz

execute wget -O /tmp/${_file} \
    https://github.com/liuminhaw/edtmp/releases/download/${_version}/${_file}

execute mkdir -p ${HOME}/.scripts/edtmp
execute tar -zxf /tmp/${_file} -C ${HOME}/.scripts/edtmp
execute chmod +x ${HOME}/.scripts/edtmp/edtmp_${_version}.sh

execute sudo ln -sf ${HOME}/.scripts/edtmp/edtmp_${_version}.sh /usr/local/bin/edtmp

execute rm /tmp/${_file}

