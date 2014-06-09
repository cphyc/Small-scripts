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


acpi -b | cut -d ',' -f 2 | cut -d '%' -f 1 | cut -d " " -f 2
