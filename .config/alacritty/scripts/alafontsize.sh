#! /bin/bash
#
# This script is used to change the font size of the terminal in the alacritty.yml file

_ALACRITTY_CONFIG="${HOME}/.config/alacritty/alacritty.toml"

# -------------------------------------
# Show script usage
# Output:
#  Write usage information to stdout
# -------------------------------------
show_help() {
	cat <<EOF
Usage: 
    ${0##*/} get
    ${0##*/} set <font size>
EOF
}

# ------------------------------------------------------------------------
# Get and show the current font size from alacritty config file
# Globals:
#  _ALACRITTY_CONFIG
# Output:
#   Write the current font size to stdout
# ------------------------------------------------------------------------
get_font_size() {
	local _font_size=$(grep "size = " ${_ALACRITTY_CONFIG} | awk '{print $3}')
	echo "Current font size: ${_font_size}"
}

# ------------------------------------------------------------------------
# Set font size to given value
# Globals:
#  _ALACRITTY_CONFIG
# Arguments:
#  $1: font size
# Output:
#  Write modified result to stdout
# ------------------------------------------------------------------------
set_font_size() {
	if [[ ${#} -ne 1 ]]; then
		echo "[ERROR] Function ${FUNCNAME[0]}: invalid numver of arguments"
		exit 1
	fi

	local _font_size=${1}

	# Check if the font size is a number
	if [[ ! ${_font_size} =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
		echo "[ERROR] Function ${FUNCNAME[0]}: input font size is not a number"
		exit 1
	fi

	# Check if font size setup exist in the file
	if [[ $(grep -c "size = " ${_ALACRITTY_CONFIG}) -ne 1 ]]; then
		echo "[ERROR] Function ${FUNCNAME[0]}: font size setup does not exist in config"
		exit 1
	fi

	# Backup config file
	cp ${_ALACRITTY_CONFIG} ${_ALACRITTY_CONFIG}.bak

	# Change font size
	sed -E "s/size = [0-9]*\.?[0-9]*/size = ${_font_size}/" ${_ALACRITTY_CONFIG} >${_ALACRITTY_CONFIG}.tmp
	cat ${_ALACRITTY_CONFIG}.tmp >${_ALACRITTY_CONFIG}

	# Remove temporary file
	rm ${_ALACRITTY_CONFIG}.tmp

	echo "Font size changed to ${_font_size}"
}

main() {
	if [[ ${#} -eq 1 && ${1} == "get" ]]; then
		get_font_size
	elif [[ ${#} -eq 2 && ${1} == "set" ]]; then
		set_font_size ${2}
	else
		show_help
		exit 1
	fi
}

main ${@}
