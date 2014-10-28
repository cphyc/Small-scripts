#!/bin/bash

# you can change for askroot, gksudo, sudo
SUDOER=gksudo
profiles=$(tuned-adm list | awk -F"- " '$1=="" { print $2 }')
profile_current=$(tuned-adm active | awk -F': ' '{ print $2 }')
profiles_bool=$(
    for p in $profiles; do 
	[ $p = $profile_current ] && echo TRUE $p || echo FALSE $p
    done
)
profile=$(
    zenity --list --text="$activeProfile" --column='Pick' --column='Behaviour'\
    --radiolist --hide-header $profiles_bool
)

$SUDOER tuned-adm profile $profile && #2&> /dev/null &&
zenity --info --text="Successfully changed power plan, it is now \`$(tuned-adm active | awk -F': ' '{ print $2 }')\'" ||
zenity --info --text="An error occured, power plan not changed" 

