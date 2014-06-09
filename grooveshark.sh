#!/bin/sh

#####################################################
# This script was created by cphyc and adapted from #
# http://hang4r.blogspot.com/2011/06/control-synergy-server-and-its-clients.html
#                                                   #
# Whoever finds it interesting shall buy me a       #
# beer or any drink if he is interested in          #
# having fun with me. Otherwise, he can just        #
# use it, modify it and add my name to his fork     #
# (if he wants to).                                 #
#####################################################

echo "Looking for an existing instance (be sure Grooveshark is alone in
Firefox)..."
ID=`xdotool search --name Grooveshark | tail -n 1`
echo $ID
if [[ $ID == "" ]]
then
	export DISPLAY=:0
	echo "Opening grooveshark in the background ..."
	firefox -new-window http://grooveshark.com &
	sleep 2
	ID=`xdotool search --name Grooveshark | tail -n 1`
else
	echo "Found !"
fi
echo "Got id : $ID"
echo "Executing the $1 command"
xdotool key --window $ID $1
