# -*- coding: utf-8 -*-
"""
Created on Sun Nov 08 00:04:46 2015

@author: Camilo
"""

# Copyright 2015 IBM Corp. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os
from flask import Flask, jsonify
from flask import request
from watson_developer_cloud import RelationshipExtractionV1Beta as RelationshipExtraction
import json
import ast
import xmltodict
import requests


user_ = '9f8f3b0b-67b3-4ed6-8dff-a275c7d74aaa'
pass_ = 'aeVsoRd90RnL'

relationship_extraction = RelationshipExtraction(username = user_, password = pass_)


global dep_date
global arrival_date
dep_date = 0
arrival_date = 0


url = 'https://ec2-54-77-6-21.eu-west-1.compute.amazonaws.com:8143/flightavailability/1.0/?FlightDate=1&Origin=1&Destination=1&Class=1'
headers = {'Authorization': 'Bearer 3b8ea5e33ce5caf0392cf6b7c7f41d5'}

r = requests.get(url, headers=headers, verify=False)

#print(r.text)


from_emi_api = ast.literal_eval(r.text)
#print(type(from_emi_api))
flights = from_emi_api['FlightAvailabilityList']
#print(len(flights))

dep_date = flights[0]['FlightDateTime']
arrival_date = flights[1]['FlightDateTime']

print(dep_date)
print(arrival_date)

app = Flask(__name__)

@app.route('/')
def Welcome():
    return app.send_static_file('index.html')

@app.route('/myapp')
def WelcomeToMyapp():
    return 'Welcome again to my app running on Bluemix!'

@app.route('/api/people')
def GetPeople():
    list = [
        {'name': 'John', 'age': 28},
        {'name': 'Bill', 'val': 26}
    ]
    return jsonify(results=list)

@app.route('/api/people/<name>')
def SayHello(name):
    message = {
        'message': 'Hello ' + name
    }
    return jsonify(results=message)


    
@app.route('/text', methods=['GET', 'POST'])
def Text():
    global number_passengers
    global destination
    global origin
    
    destination = "Doha"
    origin = "Doha"
    number_passengers = 0
    
    if request.method == 'POST':
        #print('IN POST')
        text = request.get_json()
        mess = relationship_extraction.extract(text['text'])
        print(type(mess))
        #print(text['text'])
        #print(mess)
        locations = []
        #dates = []
        try:
            data = xmltodict.parse(mess)
            #print(type(data))
            #print(data)
            data_b = json.dumps(data, indent = 2)
            #print(data_b)
            #print(data['mentions'])

            new_data = json.loads(json.dumps(data))
            #print(type(new_data)) # '{"e": {"a": ["text", "text"]}}'
            rep = new_data['rep']
            doc = rep['doc']
            
            ent = doc['entities']['entity']
            #print(len(ent))
            
            for x in range(len(ent)):                
                if ent[x]['@type'] == "PERSON":
                    number_passengers = number_passengers + 1
                if ent[x]['@type'] == "GPE":
                    locations.append(ent[x]['mentref']['#text'])             
                    
                    
            print("number_passengers:")
            print(number_passengers)
            print(locations)
            
            if len(locations) == 2:
                destination = locations[0]
                origin = locations[1]
                
            elif len(locations) == 1:
                destination = locations[0]
                
                
                
            print("Destination: ")
            print(destination)
            print("origin: ")
            print(origin)
            
            print("dep_date: ")
            print(dep_date)
            print("arrival_date: ")
            print(arrival_date)
            #print(mentions)
            #print(new_data)
            
            #text_ = dict(new_data)
            #print(text_)
            #print(type(text_))
            #parsed = ast.literal_eval(new_data)
            
            #print(type(parsed))
            #print(parsed)
            
            #for key, value in doc.items() :
             #   print("\n")
              #  print(key, value)
            #print(data)
        except:
            print("could convert")
            
        #print("if")
        message = {'message': mess}
        
    else:
        #print("else")
        message = {'message': 'Boris Mierda'}
    return jsonify(results=message)
    

port = os.getenv('PORT', '5000')
if __name__ == "__main__":
	app.run(host='0.0.0.0', port=int(port))