#!/usr/bin/env bash

# This script modifies the theme of alacritty, tmux, and neovim

_CONFIG_FILES=(
    "${HOME}/.config/nvim/lua/plugins/colortheme.lua"
    "${HOME}/.config/tmux/tmux.conf"
)

# _NEOVIM_CONFIG="${HOME}/.config/nvim/lua/plugins/colorscheme.lua"
# _TMUX_CONFIG="${HOME}/.config/tmux/tmux.conf"

_DARK_MODE="macchiato"
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
# Modify theme to mode in given config file
# Globals:
#   _ORIG_THEME
#   _NEW_THEME
# Arguments:
#   $1: mode, "dark" or "light"
#   $2: config file to modify
# ------------------------------------------------------------------------
mod_theme() {
    if [[ ${#} -ne 2 ]]; then
        echo "[ERROR] Function ${FUNCNAME[0]}: invalid number of arguments"
        exit 1
    fi
    local _config_file="${2}"
    set_theme "${1}"

    sed -i "s/${_ORIG_THEME}/${_NEW_THEME}/" "${_config_file}"
}

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

    alatheme "${_mode}"
    for _file in "${_CONFIG_FILES[@]}"; do
        mod_theme "${_mode}" "${_file}"
    done
}

main "${@}"
