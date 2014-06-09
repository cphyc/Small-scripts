Small-scripts
=============

Basic small scripts for everyday-life basic tasks!


battery.sh
==========

[shell] Get the battery status through acpi and get from it the percentage of remaining power in it.
Syntax:
    
    bash battery.sh

dring.py
========

[python3] Similar to the "at" command be only requires a python3 distribution (should also work with python2).

Dependencies:

    python3 (or python2 if you really want ...)
    
Syntax: 

    python3 dring.py (hh:mm | hh mm) <any command here>
    
Example:

    python3 dring.py 08:30 mplayer ~/Music/Summertime.mp3
    
grooveshark.sh
==============

[bash] Very basic control of Grooveshark through command line (and therefore with keyboard shortcuts if you configure it). It basically get the id of a window containing "Grooveshark" and sends the command you want to it. If not found, opens a new firefox window (you can change it by changing Firefox into any other browser).

Dependencies:

    xdotool

Syntax:

    bash grooveshark.sh <command>
    
Example:
    
    # Next song
    bash grooveshark.s ctrl+Right
    
    # Pause
    bash grooveshark.sh space
    
    # Lower volume
    bash grooveshark.sh ctrl+Down
    
flac2mp3.sh
===========

[shell] Finds all flac files in directory and convert it to mp3, conserving the id3 tags. You need to have installed flac and some codex for mp3.

Syntax:
    
    bash flac2mp3.sh
    
    
synergy.sh
==========

[bash] Establish a synergy client-server between two computers. The server is behind a firewall or any uncrossable device.
Launch this script on the server side and replace the paramaters by those who fits. The client_adress has to be a reachable adress for the server.
TODO : support error and don't display a successfull message in all cases (which is really stupid).

Dependencies : 

    synergy, ssh, zenity (optional)

Syntax:

    bash synergy.sh
    
