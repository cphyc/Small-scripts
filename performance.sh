#!/bin/bash
# this simple script takes care of toggling the performance mode on Samsung series 9 (and possible other samsung) laptops.
# it's written by Jos Poortvliet and licensed public domain cuz its brain-dead simple to write, even for him :D
#
# This script requires the performance_level file to be accessible by the user.
# To make that happen, add the three lines below (without the first #'s) in your /etc/rc.c/boot.local file.
# This will ensure these lines get executed on each boot!
#
# --
#
# # allow changing performance level
# chgrp users /sys/devices/platform/samsung/performance_level
# chmod 664 /sys/devices/platform/samsung/performance_level
#
# --
#
# Of course, you now want to assign the ventilator (Fn F11) to this script.
# You first need to ensure the Fn keys work. Go to the link below and follow instructions if they don't work already:
# https://bugzilla.redhat.com/show_bug.cgi?id=838036
#
# Now you have to connect the keys to actions which trigger the script. The easiest way is to
# go to the KDE systemsettings and open 'Shortcuts and Gestures'. Then follow these steps:
# 1. Create a new global shortcut (on the bottom: edit > new > global shortcut > command/URL)
# 2. As trigger, assign the Fn-F11 key
# 3. As Action, simply browse for where you put this script (for example /home/jospoortvliet/bin/performance.sh)
# the script should now work (provided you have already executed the chmod!)
#
# Or, instead of making the hotkeys, import the khotkeys file I created instead:
# https://dl.dropbox.com/u/29347181/NP900X3C.khotkeys
#
# Check also the wlan script for the S9!
#

if cat /sys/devices/platform/samsung/performance_level | grep silent > /dev/null;
then 
	echo normal > /sys/devices/platform/samsung/performance_level;
	notify-send --hint int:transient:1 -t 1500 "Powerplan switched to normal." 2>/dev/null
#kdialog --passivepopup 'normal' --title 'performance level' 1
else 
	echo silent > /sys/devices/platform/samsung/performance_level
	notify-send --hint int:transient:1 -t 1500 "Powerplan switched to silent." 2>/dev/null
#kdialog --passivepopup 'silent' --title 'performance level' 1 
exit 0
fi
