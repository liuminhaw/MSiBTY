#!/usr/bin/env bash

_INPUT_DEVICE="SNSL0027:00 2C2F:0027 Touchpad"
_INPUT_ACCEL_SPEED=0.6

xinput set-prop "${_INPUT_DEVICE}" "libinput Natural Scrolling Enabled" 1
xinput set-prop "${_INPUT_DEVICE}" "libinput Accel Speed" ${_INPUT_ACCEL_SPEED}
# Common values for "Click Method Enabled"
# `0, 0`: No click method
# `1, 0`: Button areas (Click Method 1)
# `0, 1`: Clickfinger (Click Method 2)
# `1, 1`: both methods enabled (If supported)
xinput set-prop "${_INPUT_DEVICE}" "libinput Click Method Enabled" 0 1
