#!/bin/bash

# TODOs (Maybe)
# v export DRY RUN checks to every executing script (to get an overview of what each script is doing)

_SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
_FILTER=""
_DRY=0

source ${_SCRIPT_DIR}/libs/helper.sh

while :; do
    case ${1} in
    --dry)
        _DRY=1
        ;;
    -?*)
        echo -e "[WARN] Unknown option (ignored): ${1}" 1>&2
        exit 1
        ;;
    *)
        break
        ;;
    esac

    shift
done

export _SCRIPT_DIR

_FILTER=${1}
log "${_SCRIPT_DIR} -- ${_FILTER}"

cd ${_SCRIPT_DIR}
_scripts=$(find ./runs -maxdepth 1 -mindepth 1 -executable -type f | sort)

for _script in ${_scripts}; do
    _script=$(sed 's|^\./||' <<< ${_script})

    echo "${_script}" | grep -qv "${_FILTER}"
    if (( PIPESTATUS[1] == 0 )); then
        log "filtering ${_script}"
	continue
    fi

    execute ./${_script}
done
