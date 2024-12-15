#!/bin/bash

log() {
    if [[ ${_DRY} -eq 1 || ${_IS_DRY} -eq 1 ]]; then
        echo "[DRY RUN]: ${@}"
    else
        echo "[EXECUTE]: ${@}"
    fi
}

execute() {
    if [[ ${_IS_DRY} -eq 1 ]]; then
        log "${@}"
        return
    else
        log "execute ${@}"
    fi

    if [[ ${_DRY} -eq 1 ]]; then
        _IS_DRY=1 "${@}"
        return 
    fi


    "${@}"
}

# TODO (Maybe):
# - backup origin before copying
copy_dir() {
    if [[ ${#} -ne 2 && ${#} -ne 3 ]]; then
        echo "[ERROR] ${FUNCNAME[0]} usage error" 1>&2
        return 1
    fi

    local _from=${1}
    local _to=${2}
    local _filter=${3}

    pushd ${_from} > /dev/null
        log "pushd path: $(pwd)"
        local _dirs=$(find . -mindepth 1 -maxdepth 1 -type d)
        local _dir
        for _dir in ${_dirs}; do

            echo "${_dir}" | grep -qv "${_filter}"
            if (( PIPESTATUS[1] == 0 )); then
                log "filtering ${_dir}"
                continue
            fi

            _dir=$(sed 's|^\./||' <<< ${_dir})
            execute rm -rf ${_to}/${_dir}
            execute cp -r ${_dir} ${_to}/${_dir}

            # Execute setup scripts in ${_to}/${_dir} if there is any
            if [[ -d ${_dir}/setup ]]; then
                local _scripts=$(find ${_dir}/setup -mindepth 1 -maxdepth 1 -executable -type f) 
                local _script
                for _script in ${_scripts}; do
                    _script=$(sed 's|^\./||' <<< ${_script})
                    log "execute ${_script}"
                    # echo "Dry: ${_DRY}"
                    # echo "Is Dry: ${_IS_DRY}"
                    _IS_DRY=0 execute ${_script} "${_dir}" "${_to}/${_dir}"
                done
            fi
        done
    popd > /dev/null
}

# TODO (Maybe):
# - backup origin before copying
copy_file() {
    if [[ ${#} -ne 2 && ${#} -ne 3 ]]; then
        echo "[ERROR] ${FUNCNAME[0]} usage error" 1>&2
        return 1
    fi

    local _from=${1}
    local _to=${2}
    local _filter=${3}
    local _name=$(basename ${_from})

    echo "${_from}" | grep -qv "${_filter}"
    if (( PIPESTATUS[1] == 0 )); then
        log "filtering ${_from}"
        return
    fi

    if [[ -f ${_to}/${_name} ]]; then
        execute rm ${_to}/${_name}
    fi
    execute cp ${_from} ${_to}/${_name}
}

install_aur() {
    if [[ ${#} -ne 2 ]]; then
        echo "[ERROR] ${FUNCNAME[0]} usage error" 1>&2
        return 1
    fi

    local _aur_build_dir=${1}
    local _git_repo=${2}
    local _package_name=$(basename ${_git_repo} .git)

    pushd ${_aur_build_dir} > /dev/null
        log "pushd path: $(pwd)"
        if [[ ! -d ${_package_name} ]]; then
            log "cloning ${_git_repo}"
            git clone ${_git_repo}
        else
            log "git repo exist, no need to clone"
        fi
    popd > /dev/null

    pushd ${_aur_build_dir}/${_package_name} > /dev/null
        git pull
        makepkg --needed --syncdeps --install --rmdeps --clean
    popd > /dev/null
}

