#!/usr/bin/env bash

source ${_SCRIPT_DIR}/libs/helper.sh

# echo "Dry: ${_DRY}"
# echo "Is Dry: ${_IS_DRY}"

_release_info=$(curl -s https://api.github.com/repos/liuminhaw/edtmp/releases/latest)
_src=$(echo "${_release_info}" | grep "browser_download_url" | cut -d : -f 2,3 | tr -d \")
_file=$(basename "${_src}")
_version=$(jq -r '.tag_name' <<<"${_release_info}")

execute wget -O /tmp/${_file} ${_src}

execute mkdir -p ${HOME}/bin
execute mkdir -p ${HOME}/.scripts/edtmp
execute tar -zxf /tmp/${_file} -C ${HOME}/.scripts/edtmp
execute chmod +x ${HOME}/.scripts/edtmp/edtmp_${_version}.sh

execute ln -sf ${HOME}/.scripts/edtmp/edtmp_${_version}.sh ${HOME}/bin/edtmp

execute rm /tmp/${_file}
