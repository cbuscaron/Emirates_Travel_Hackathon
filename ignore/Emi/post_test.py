# -*- coding: utf-8 -*-
"""
Created on Sat Nov 07 16:26:02 2015

@author: Camilo
"""

import requests
import json

url = 'http://localhost:5000/text'
payload = {'text': 'I want to travel to Cuba from San Francisco next Friday'}

r = requests.post(url, json=payload)

print(r)

print(r.json())