#!/vendor/bin/sh
scriptname=${0##*/}

notice()
{
  echo "$*"
  echo "$scriptname: $*" > /dev/kmsg
}

usb_dcp_icl_ua=1500000
hvdcp_power_max=15000
# carrier set on early time (early than early-init)
carrier=`getprop ro.carrier`
radio=`getprop ro.vendor.hw.radio`


# Set usb dcp and hvdcp properties base on radio
get_charge_properties_on_radio ()
{
    case $radio in
        # North America Region
        NA|VZW )
        usb_dcp_icl_ua=2000000
        hvdcp_power_max=15000
        ;;
        ROW|JAPAN )
        usb_dcp_icl_ua=1500000
        hvdcp_power_max=20000
        ;;
    esac # end $radio
}

# Set usb dcp and hvdcp properties base on carrier
get_charge_properties_on_carrier ()
{
    case $carrier in
        # North America Region - Google Project Fi
        fi )
        usb_dcp_icl_ua=1500000
        hvdcp_power_max=15000
        ;;
#if more additional requirements by carrier,
#please append them
    esac # end $carrier
}

get_charge_properties_on_radio
notice "rewrite charge prop base on radio, usb_dcp=$usb_dcp_icl_ua, hvdcp_power=$hvdcp_power_max"
get_charge_properties_on_carrier
notice "rewirte charge prop base on carrier, usb_dcp=$usb_dcp_icl_ua, hvdcp_power=$hvdcp_power_max"

echo $usb_dcp_icl_ua > /sys/class/power_supply/usb/device/usb_dcp_icl_ua
echo $hvdcp_power_max > /sys/class/power_supply/battery/device/force_hvdcp_power_max
