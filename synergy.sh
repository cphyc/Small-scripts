 #!/bin/bash
# onesyn.sh

# Start the synergy server daemon and sleep to ensure it's up
# prior to kicking off our uber-simple client initialization
synergys &
sleep 2

# now, reverse-ssh into synergy client using key-based auth
# and kick off synergy client over an encrypted network tunnel
ssh -R 127.0.0.1:24800:127.0.0.1:24800 ccc@129.199.224.36 "synergyc -f 127.0.0.1"& 
zenity --info --title "Synergy" --text "Synergy server-client launched."
# end of script
