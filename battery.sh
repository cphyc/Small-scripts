#!/bin/sh

####################################################
# This script was created by cphyc.                #
#                                                  #
# Whoever finds it interesting shall buy me a      #
# beer or any drink if he is interested in         #
# having fun with me. Otherwise, he can just       #
# use it, modify it and add my name to his fork    #
# (if he wants to).                                #
####################################################

BATTERY_LOW=7
BATTERY_CRITICAL=5
BATTERY_WARN=10
BATTERY=$(acpi -b | cut -d ',' -f 2 | cut -d '%' -f 1 | cut -d " " -f 2)
BATTERY_PREV=$([ -e /tmp/running_low ] && cat /tmp/running_low || 0)
BATTERY_STATE=$(acpi -b | cut -d ',' -f 1 | cut -d ':' -f 2 | cut -d " " -f 2)
NOTIF=notify-send

if [ $BATTERY_STATE == "Discharging" ]; then
    # Checks that the battery hasnot reached the minimu
    if [ $BATTERY -lt $BATTERY_WARN ] ; then
	echo $BATTERY > /tmp/running_low
    fi
    if [ $BATTERY -lt $BATTERY_PREV ]; then
	if [ $BATTERY -le $BATTERY_LOW ]; then
	    notify-send "Battery critically low ($BATTERY%)!" "Will shut down at $BATTERY_CRITICAL%." -u critical
	elif [ $BATTERY -le $BATTERY_WARN ] ; then
	    notify-send "Battery low ($BATTERY%)!" "Will shut down at $BATTERY_CRITICAL%." -u normal
	fi
    fi
    [ $BATTERY -le $BATTERY_CRITICAL ] && halt -p
fi

echo $BATTERY
