#!/usr/bin/env bash

_ALACRITTY_CONFIG="${HOME}/.config/alacritty/alacritty.toml"

_DARK_MODE="mocha"
_LIGHT_MODE="latte"

_ORIG_THEME=""
_NEW_THEME=""

# -------------------------------------
# Show script usage
# Output:
#  Write usage information to stdout
# -------------------------------------
show_help() {
    cat <<EOF
Usage: 
    ${0##*/} light
    ${0##*/} dark
EOF
}

# ------------------------------------------------------------------------
# Modify alacritty theme to given mode
# Globals:
#   _ALACRITTY_CONFIG
# Arguments:
#   $1: mode, "dark" or "light"
# ------------------------------------------------------------------------
mod_alacritty_theme() {
    if [[ ${#} -ne 1 ]]; then
        echo "[ERROR] Function ${FUNCNAME[0]}: invalid number of arguments"
        exit 1
    fi
    set_theme "${1}"

    # Backup config file
    cp "${_ALACRITTY_CONFIG}" "${_ALACRITTY_CONFIG}.bak"

    # Change font size
    sed "s/${_ORIG_THEME}/${_NEW_THEME}/" "${_ALACRITTY_CONFIG}" >"${_ALACRITTY_CONFIG}.tmp"
    cat "${_ALACRITTY_CONFIG}.tmp" >"${_ALACRITTY_CONFIG}"

    # Remove temporary file
    rm "${_ALACRITTY_CONFIG}.tmp"
}
#
# -----------------------------------------------------------------------------
# Set the _ORIG_THEME and _NEW_THEME global variable based on the given mode
# Globals:
#   _ORIG_THEME
#   _NEW_THEME
#   _DARK_MODE
#   _LIGHT_MODE
# Arguments:
#   $1: mode, "dark" or "light"
# -----------------------------------------------------------------------------
set_theme() {
    if [[ ${#} -ne 1 ]]; then
        echo "[ERROR] Function ${FUNCNAME[0]}: invalid number of arguments"
        exit 1
    fi
    local _mode=${1}

    case ${_mode} in
    dark)
        _ORIG_THEME=${_LIGHT_MODE}
        _NEW_THEME=${_DARK_MODE}
        ;;
    light)
        _ORIG_THEME=${_DARK_MODE}
        _NEW_THEME=${_LIGHT_MODE}
        ;;
    *)
        echo "[ERROR] Function ${FUNCNAME[0]}: invalid mode, use 'dark' or 'light'"
        exit 1
        ;;
    esac
}

main() {
    if [[ ${#} -ne 1 ]]; then
        show_help
        exit 1
    fi

    local _mode=${1}
    if [[ "${_mode}" != "dark" && "${_mode}" != "light" ]]; then
        show_help
        exit 1
    fi

    mod_alacritty_theme "${_mode}"
}

main "${@}"
