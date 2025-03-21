#!/usr/bin/env bash
# This script is used to automatically detect and configure the displays
# Note: use `xrandr -q` to get the display names

# _BUILTIN_DISPLAY="eDP-1"
# _BUILTIN_DISPLAY_RESOLUTION="1920x1200"
# _EXTERNAL_DISPLAY_RESOLUTION="1920x1080"

# -----------------------------------------------------------------------------------
# read_env: Read the environment variables from the .env file located in the same
# directory as the script
#
# Returns:
#   Exit script with exit code 1 if the .env file is not found or the required
#   environment variables are not set.
# -----------------------------------------------------------------------------------
read_env() {
    local _script_dir=$(cd $(dirname "${0}") && pwd)
    local _env_file="${_script_dir}/.env"

    if [[ ! -f "${_env_file}" ]]; then
        echo "Error: ${_env_file} file not found"
        exit 1
    fi

    source "${_env_file}"

    if [[ -z ${_BUILTIN_DISPLAY} ]]; then
        echo "Error: _BUILTIN_DISPLAY must be set in ${_env_file}"
        exit 1
    fi
    if [[ -z ${_BUILTIN_DISPLAY_RESOLUTION} ]]; then
        echo "Error: _BUILTIN_DISPLAY_RESOLUTION must be set in ${_env_file}"
        exit 1
    fi
    if [[ -z ${_EXTERNAL_DISPLAY_RESOLUTION} ]]; then
        echo "Error: _EXTERNAL_DISPLAY_RESOLUTION must be set in ${_env_file}"
        exit 1
    fi
}

# --------------------------------------------------------------------------------------------------------------------------
# gen_ext_args: Generate the arguments when external displays is attached
# Globals:
#   _BUILTIN_DISPLAY
#   _BUILTIN_DISPLAY_RESOLUTION
#   _EXTERNAL_DISPLAY_RESOLUTION
# Arguments:
#   builtin_position: The position of the builtin display, "off" sets the builtin display off
#   external_position: The position of the external display, "off" sets the external display off
#   detected_display: Name of external detected display
#   displays: A list of displays
# Outputs:
#   argument string for xrandr command
# --------------------------------------------------------------------------------------------------------------------------
gen_ext_args() {
    if [[ ${#} -ne 4 ]]; then
        echo "Usage error in function ${FUNCNAME[0]}: ${#}"
        exit 1
    fi

    local _builtin_pos=${1}
    local _external_pos=${2}
    local _detected_display=${3}
    local _displays=(${4})

    local _arguments

    if [[ "${_builtin_pos}" == "off" ]]; then
        _arguments="--output ${_BUILTIN_DISPLAY} --off"
    else
        _arguments="--output ${_BUILTIN_DISPLAY} --primary --mode ${_BUILTIN_DISPLAY_RESOLUTION} --pos ${_builtin_pos} --rotate normal"
    fi

    for _display in "${_displays[@]}"; do
        if [[ "${_display}" == "${_detected_display}" ]]; then
            _arguments="${_arguments} --output ${_display} --mode ${_EXTERNAL_DISPLAY_RESOLUTION} --pos ${_external_pos} --rotate normal"
        else
            _arguments="${_arguments} --output ${_display} --off"
        fi
    done
    echo "${_arguments}"
}

main() {
    # Read the environment variables
    read_env

    local _mode=${1}
    local declare _detected_displays
    local declare _displays

    if [[ ${#} -eq 1 && "${_mode}" == "normal" ]]; then
        _detected_displays=()
    else
        read -r -d ' ' -a _detected_displays <<<"$(xrandr -q | grep " connected " | grep -v "${_BUILTIN_DISPLAY}" | cut -d ' ' -f1)"
    fi
    read -r -d ' ' -a _displays <<<"$(xrandr -q | grep "connected" | grep -v "${_BUILTIN_DISPLAY}" | cut -d ' ' -f1)"

    local _arguments
    if [[ ${#_detected_displays[@]} -eq 1 && ${_mode} == "top" ]]; then
        _resolution_height=$(echo ${_EXTERNAL_DISPLAY_RESOLUTION} | cut -d'x' -f2)
        _arguments=$(gen_ext_args "0x${_resolution_height}" "0x0" "${_detected_displays[0]}" "${_displays[*]}")

        # _arguments="--output ${_BUILTIN_DISPLAY} --primary --mode ${_BUILTIN_DISPLAY_RESOLUTION} --pos 0x${_resolution_height} --rotate normal"
        # for _display in "${_displays[@]}"; do
        #     if [[ "${_display}" == "${_detected_displays[0]}" ]]; then
        #         _arguments="${_arguments} --output ${_display} --mode ${_EXTERNAL_DISPLAY_RESOLUTION} --pos 0x0 --rotate normal"
        #     else
        #         _arguments="${_arguments} --output ${_display} --off"
        #     fi
        # done
    elif [[ ${#_detected_displays[@]} -eq 1 && ${_mode} == "left" ]]; then
        _resolution_width=$(echo ${_EXTERNAL_DISPLAY_RESOLUTION} | cut -d'x' -f1)
        _arguments=$(gen_ext_args "${_resolution_width}x0" "0x0" "${_detected_displays[0]}" "${_displays[*]}")

        # _arguments="--output ${_BUILTIN_DISPLAY} --primary --mode ${_BUILTIN_DISPLAY_RESOLUTION} --pos ${_resolution_width}x0 --rotate normal"
        # for _display in "${_displays[@]}"; do
        #     if [[ "${_display}" == "${_detected_displays[0]}" ]]; then
        #         _arguments="${_arguments} --output ${_display} --mode ${_EXTERNAL_DISPLAY_RESOLUTION} --pos 0x0 --rotate normal"
        #     else
        #         _arguments="${_arguments} --output ${_display} --off"
        #     fi
        # done
    elif [[ ${#_detected_displays[@]} -eq 1 && ${_mode} == "right" ]]; then
        _resolution_width=$(echo ${_EXTERNAL_DISPLAY_RESOLUTION} | cut -d'x' -f1)
        _arguments=$(gen_ext_args "0x0" "${_resolution_width}x0" "${_detected_displays[0]}" "${_displays[*]}")

        # _arguments="--output ${_BUILTIN_DISPLAY} --primary --mode ${_BUILTIN_DISPLAY_RESOLUTION} --pos 0x0 --rotate normal"
        # for _display in "${_displays[@]}"; do
        #     if [[ "${_display}" == "${_detected_displays[0]}" ]]; then
        #         _arguments="${_arguments} --output ${_display} --mode ${_EXTERNAL_DISPLAY_RESOLUTION} --pos ${_resolution_width}x0 --rotate normal"
        #     else
        #         _arguments="${_arguments} --output ${_display} --off"
        #     fi
        # done
    elif [[ ${#_detected_displays[@]} -eq 1 ]]; then
        _arguments=$(gen_ext_args "off" "0x0" "${_detected_displays[0]}" "${_displays[*]}")

        # _arguments="--output ${_BUILTIN_DISPLAY} --off"
        # for _display in "${_displays[@]}"; do
        #     if [[ "${_display}" == "${_detected_displays[0]}" ]]; then
        #         _arguments="${_arguments} --output ${_display} --primary --mode ${_EXTERNAL_DISPLAY_RESOLUTION} --pos 0x0 --rotate normal"
        #     else
        #         _arguments="${_arguments} --output ${_display} --off"
        #     fi
        # done
    else
        _arguments=$(gen_ext_args "0x0" "off" "none" "${_displays[*]}")

        # _arguments="--output ${_BUILTIN_DISPLAY} --mode ${_BUILTIN_DISPLAY_RESOLUTION} --pos 0x0 --rotate normal"
        # for _display in "${_displays[@]}"; do
        #     _arguments="${_arguments} --output ${_display} --off"
        # done
    fi

    # For debugging
    # echo "xrandr ${_arguments}"
    # Actual command
    xrandr ${_arguments}
}

main "${@}"
