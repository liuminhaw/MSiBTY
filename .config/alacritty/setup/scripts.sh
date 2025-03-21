#!/usr/bin/env bash

# echo "DRY: ${_DRY}"
# echo "IS DRY: ${_IS_DRY}"

if [[ ${#} -ne 2 ]]; then
    echo "[ERROR] ${FUNCNAME[0]} usage error" 1>&2 
    exit 1
fi

source ${_SCRIPT_DIR}/libs/helper.sh

_src=${1}
_dest=${2}

execute cp -r ${_src}/scripts ${_dest}/scripts

if [[ ${_IS_DRY} -eq 1 ]]; then
    _scripts=$(find ${_src}/scripts -mindepth 1 -maxdepth 1 -executable -type f) 
else 
    _scripts=$(find ${_dest}/scripts -mindepth 1 -maxdepth 1 -executable -type f) 
fi

for _script in ${_scripts}; do 
    _script=$(basename ${_script})
    if [[ -L /${HOME}/bin/${_script%.*} ]]; then
        execute rm /${HOME}/bin/${_script%.*}
    fi
    execute ln -s ${_dest}/scripts/${_script} /${HOME}/bin/${_script%.*}
done
