#!/usr/bin/env bash

# _INPUT_TOUCHPAD_DEVICE="SNSL0027:00 2C2F:0027 Touchpad"
# _INPUT_TOUCHPAD_ACCEL_SPEED=0.6

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

    if [[ -z ${_INPUT_TOUCHPAD_DEVICE} ]]; then
        echo "Error: _INPUT_TOUCHPAD_DEVICE must be set in ${_env_file}"
        exit 1
    fi
    if [[ -z ${_INPUT_TOUCHPAD_ACCEL_SPEED} ]]; then
        echo "Error: _INPUT_TOUCHPAD_ACCEL_DEVICE must be set in ${_env_file}"
        exit 1
    fi
    if [[ -z ${_INPUT_TOUCHPAD_TAPPING} ]]; then
        echo "Error: _INPUT_TOUCHPAD_TAPPING must be set in ${_env_file}"
        exit 1
    fi
}

main() {
    # Read the environment variables
    read_env

    xinput set-prop "${_INPUT_TOUCHPAD_DEVICE}" "libinput Natural Scrolling Enabled" 1
    xinput set-prop "${_INPUT_TOUCHPAD_DEVICE}" "libinput Accel Speed" ${_INPUT_TOUCHPAD_ACCEL_SPEED}
    # Common values for "Click Method Enabled"
    # `0, 0`: No click method
    # `1, 0`: Button areas (Click Method 1)
    # `0, 1`: Clickfinger (Click Method 2)
    # `1, 1`: both methods enabled (If supported)
    xinput set-prop "${_INPUT_TOUCHPAD_DEVICE}" "libinput Click Method Enabled" 0 1

    if [[ "${_INPUT_TOUCHPAD_TAPPING}" == "true" ]]; then
        xinput set-prop "${_INPUT_TOUCHPAD_DEVICE}" "libinput Tapping Enabled" 1
    fi
}

main "${@}"
