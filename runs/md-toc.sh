#!/usr/bin/env bash

source ${_SCRIPT_DIR}/libs/helper.sh

# echo "Dry: ${_DRY}"
# echo "Is Dry: ${_IS_DRY}"

_repo=liuminhaw/md-toc

_latest_version=$(curl -s https://api.github.com/repos/${_repo}/releases/latest | jq -r .name)
_file=md-toc_${_latest_version}.tar.gz
# _link=https://github.com/${_repo}/releases/download/${_latest_version}/${_file}

execute echo "Latest version: ${_latest_version}"
execute echo "Download link: ${_link}"

execute wget -O /tmp/${_file} \
    https://github.com/${_repo}/releases/download/${_latest_version}/${_file}

execute mkdir -p ${HOME}/bin
execute mkdir -p ${HOME}/.scripts/md-toc
execute tar -zxf /tmp/${_file} -C ${HOME}/.scripts/md-toc
execute chmod +x ${HOME}/.scripts/md-toc/md-toc.sh

execute ln -sf ${HOME}/.scripts/md-toc/md-toc.sh ${HOME}/bin/md-toc

execute rm /tmp/${_file}
