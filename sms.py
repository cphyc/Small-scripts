#!/usr/bin/env python2

import sys
import requests

CONFIG = {
    "user": "CONFIGUREME",
    "pass": "CONFIGUREME"
}

if __name__ == "__main__" :
    # get message from argument
    message = " ".join(sys.argv[1:])

    #create the url
    url = r"https://smsapi.free-mobile.fr/sendmsg?user={}&pass={}&msg={}".format(CONFIG['user'], CONFIG['pass'], message)
    
    # request the page
    r = requests.get(url, verify=False)

    # check the outcode
    if r.status_code != 200:
        raise Exception("Error - status code {}".format(r.status_code))
    
