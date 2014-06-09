#!/bin/bash

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

# Start the synergy server daemon and sleep to ensure it's up
# prior to kicking off our uber-simple client initialization
synergys &
sleep 2

# now, reverse-ssh into synergy client using key-based auth
# and kick off synergy client over an encrypted network tunnel
ssh -R 127.0.0.1:24800:127.0.0.1:24800 ccc@129.199.224.36 "synergyc -f 127.0.0.1"& 
zenity --info --title "Synergy" --text "Synergy server-client launched."
# end of script
