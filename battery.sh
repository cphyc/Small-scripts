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

MIN_BATTERY=5
WARN_BATTERY=10
BATTERY=`acpi -b | cut -d ',' -f 2 | cut -d '%' -f 1 | cut -d " " -f 2`
BATTERY_PREV=`[ -e /tmp/running_low ] && cat /tmp/running_low || 0`
BATTERY_STATE=`acpi -b | cut -d ',' -f 1 | cut -d ':' -f 2 | cut -d " " -f 2`

if [ $BATTERY_STATE == "Discharging" ]; then
    # Checks that the battery hasnot reached the minimum
    [ $BATTERY -lt $WARN_BATTERY ] && echo $BATTERY > /tmp/running_low &&
    [ $BATTERY -lt $BATTERY_PREV ] && zenity --info --text="Battery low ($BATTERY%)\! Will shut down at $MIN_BATTERY%."
    [ -e /tmp/running_low ] && [ $BATTERY -le $MIN_BATTERY ] && halt -p
fi

echo $BATTERY
