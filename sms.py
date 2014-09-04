#!/usr/bin/env python2

import sys

if __name__ == "__main__" :
    # get message from argument
    message = sys.argv[1:]

    #create the url
    url = r"https://smsapi.free-mobile.fr/sendmsg?user=14639048&pass=bUQgagQNfkHEGh&msg="+" ".join(message)

    # convert into url
    
    
    # request the page
    # TODO: check hy it's necessary to verify ...
    import requests
    r = requests.get(url, verify=False)

    # check the outcode
    if r.status_code <> 200:
        raise Exception("Error - status code %s"%r.status_code)
    
