#!/usr/bin/bash

URL=37.59.38.41
notify=1

while true; do
    ping -c 1 $URL > /dev/null
    if [ $? -ne 0 ]; then
        notify=1
    else
        if [ $notify -eq 1 ] ; then
            notify-send "Internet" "You've reached Internet, enjoy!"
            notify=0
        fi
    fi
    sleep 1;
done
