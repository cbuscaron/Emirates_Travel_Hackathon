# -*- coding: utf-8 -*-
"""
Created on Sat Nov 07 16:26:02 2015

@author: Camilo
"""

import requests
import json

url = 'http://emix.mybluemix.net/text'
payload = {'text': 'I want to travel to Dubai on November 24'}

r = requests.post(url, json=payload)

print(r)

print(r.json())