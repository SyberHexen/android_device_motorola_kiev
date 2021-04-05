#!/vendor/bin/sh
#
# Start fingerprint HAL according to SKU
#
# Copyright (c) 2020 Lenovo
# All rights reserved.
#
# author: chengql2@lenovo.com
# date: July 1, 2020
#

script_name=${0##*/}
script_name=${script_name%.*}
function log {
    echo "$script_name: $*" > /dev/kmsg
}

prop_persist_fps=persist.vendor.hardware.fingerprint

FPS_VENDOR_EGIS=egis
FPS_VENDOR_CHIPONE=chipone

prop_radio=$(getprop ro.vendor.hw.radio)
log "ro.vendor.hw.radio: [$prop_radio]"

if [ $prop_radio == JAPAN ]; then
    log "- start Chipone fingerprint HAL service"
    start chipone_fp_hal
    setprop $prop_persist_fps $FPS_VENDOR_CHIPONE
else
    log "- start EgisTech fingerprint HAL service"
    start ets_hal
    setprop $prop_persist_fps $FPS_VENDOR_EGIS
fi
