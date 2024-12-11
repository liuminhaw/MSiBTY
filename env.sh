#!/bin/bash

_SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
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

log "------------------- env setup -----------------------"

log "------------------- copying config dirs -----------------------"
execute copy_dir .config ${HOME}/.config

log "------------------- copying config files -----------------------"
execute copy_file .bashrc ${HOME}
