#!/bin/bash

#
# author: vaidas jablonskis <jablonskis at gmail dot com>
#
# script which allows to control wifi on/of, battery life extender,
# performance level for samsung series 9 laptop
#

# these paths should be correct by default
# if not set the variables correctly
batt_life_ext="/sys/devices/platform/samsung/battery_life_extender"
perf_level="/sys/devices/platform/samsung/performance_level"
kbd="/sys/devices/platform/samsung/leds/samsung::kbd_backlight/brightness"

# wlan rfkill name tends to change, so just to be safe
rfkill="$(grep -l "samsung-wlan" /sys/devices/platform/samsung/rfkill/rfkill*/name)"
if [[ -f "$rfkill" ]]; then
wlan_state="$(echo "$rfkill" | sed 's/name$/state/')"
fi

# function which toggles battery life extender on/off
batt() {
    batt_life_ext_value="$(cat $batt_life_ext)"
    if [[ $batt_life_ext_value -eq 0 ]]; then
     echo "1" > $batt_life_ext
     su ccc -c "notify-send --hint=int:transient:1 -t 250 'Battery life extender:' ON"
    else
     echo "0" > $batt_life_ext
     su ccc -c "notify-send --hint=int:transient:1 -t 250 'Battery life extender:' OFF"
    fi
}

# function which toggles performance level (normal or silent)
perf() {
    perf_level_value="$(cat $perf_level)"
    if [[ "$perf_level_value" == "silent" ]]; then
     echo "normal" > $perf_level
     su ccc -c "notify-send --hint=int:transient:1 -t 250 'Normal'"
    elif [[ "$perf_level_value" == "normal" ]]; then
     echo "silent" > $perf_level
     su ccc -c "notify-send --hint=int:transient:1 -t 250 'Silent'"
    fi
}

# function which toggles wifi on/off
wlan() {
    wlan_state_value="$(cat $wlan_state)"
    if [[ $wlan_state_value -eq 0 ]]; then
     echo "1" > $wlan_state
     su ccc -c "notify-send --hint=int:transient:1 -t 250 'WiFi:' ON"
    else
     echo "0" > $wlan_state
     su ccc -c "notify-send --hint=int:transient:1 -t 250 'WiFi:' OFF"
    fi
}

#function which increases the keyboard backlight
#takes too arguments : value (+1,-1, [0-8]) and abs(olute)|nothing
function kbd {
    backlight_value=$(cat $kbd)
    if [[ $2 -eq "relat" ]]; then
	backlight_new_value=`expr $backlight_value + "$1"`
    else
	backlight_new_value=="$1"
    fi
#    echo "New_value :" $backlight_new_value
    if [[ $backlight_new_value -eq -1 ]]; then backlight_new_value=0; fi
    echo $backlight_new_value > $kbd

    su ccc -c "notify-send --hint=int:transient:1 -t 250 'Keyboard Backlight: $backlight_new_value'"
}

case "$1" in
    batt)
        batt
        ;;
    perf)
        perf
        ;;
    wlan)
        wlan
        ;;
    kbd)
	case "$2" in
	    "up")
		kbd 2 relat;;
	    "down")
		kbd -2 relat;;
	    [0-8])
		kbd "$2";;
	    *)
		echo "Error in argument of kbd : out of range";;
	esac
	;;
    *)
        echo "Usage: $0 {batt|perf|wlan|kbd (up|down)}"
        exit 1
	;;
esac
