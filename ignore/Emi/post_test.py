# -*- coding: utf-8 -*-
"""
Created on Sat Nov 07 16:26:02 2015

@author: Camilo
"""

import requests
import json

url = 'http://emix.mybluemix.net/text'
payload = {'text': 'Find flight for me and my wife '}

r = requests.post(url, json=payload)

print(r)

print(r.json())