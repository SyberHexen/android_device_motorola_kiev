#!/vendor/bin/sh
#
# lsmod fingerprint driver according to SKU
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

prop_radio=$(getprop ro.vendor.hw.radio)
log "ro.vendor.hw.radio: [$prop_radio]"

if [ $prop_radio == JAPAN ]; then
    log "- insmod Chipone fingerprint sensor driver"
    insmod /vendor/lib/modules/fpsensor_spi_tee.ko
else
    log "- insmod EgisTech fingerprint sensor driver"
    insmod /vendor/lib/modules/ets_fps_mmi.ko
fi
