#/usr/env python3
####################################################
# This script was created by cphyc.                #
#                                                  #
# Whoever finds it interesting shall buy me a      #
# beer or any drink if he is interested in         #
# having fun with me. Otherwise, he can just       #
# use it, modify it and add my name to his fork    #
# (if he wants to).                                #
####################################################

import time
from subprocess import call
import sys

# Function to check the target time is actually a time
def check_target_time(h,m):
    assert(0<= h <  24)
    assert(0<= m <= 60)
    
# get the target time
print (sys.argv)
if ":" in sys.argv[1]:
    try:
        t_hour, t_min = sys.argv[1].split(":")
        t_hour = int(t_hour)
        t_min = int(t_min)
        check_target_time (t_hour, t_min)
        arg = 2
    except:
        raise Exception("Error while reading time format.")
else:
    try:
        t_hour, t_min= int(sys.argv[1]), int(sys.argv[2])
        check_target_time (t_hour, t_minute)
        arg = 3
    except:
        raise Exception("Error while reading time format.")

# get the current time
t = time.localtime()
c_hour, c_min = t.tm_hour, t.tm_min
print(c_hour, c_min)
print(t_hour, t_min)

# calculate the remaining time
if t_hour - c_hour >= 0 and t_min - c_min >= 0:
    r_hour = t_hour - c_hour
else:
    r_hour = 24 - t_hour - c_hour
r_min = t_min - c_min

# Calculte the time remaining in seconds
# remaining hours + remaining minutes - current time
r_sec = r_hour*3600 + r_min*60 - t.tm_sec

# sleep (haha) this whole time
if r_min < 0:
    print("Sleeping {}h{}m ({}s).".format(r_hour-1, r_min+60, r_sec))
else:
    print("Sleeping {}hw{}m ({}s)".format(r_hour, r_min, r_sec))
time.sleep(r_sec)

# actually execute the command which is contained in the remaining arguments
call(sys.argv[arg:])
