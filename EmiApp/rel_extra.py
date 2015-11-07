# -*- coding: utf-8 -*-
"""
Created on Sat Nov 07 14:21:48 2015

@author: Camilo
"""
import time
from watson_developer_cloud import RelationshipExtractionV1Beta as RelationshipExtraction

username = 'df01d8cb-4784-475d-bb36-4d219cca992c'
password='JUmnnnWtTluW'
relationship_extraction = RelationshipExtraction(username = 'df01d8cb-4784-475d-bb36-4d219cca992c', 
                                                 password ='JUmnnnWtTluW')

print(relationship_extraction.extract("I would like to travel to dubai next week"))

try:
  while True:
      time.sleep(10000)
except KeyboardInterrupt:
  pass