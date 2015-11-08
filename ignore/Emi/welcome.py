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
import json
from watson_developer_cloud import RelationshipExtractionV1Beta as RelationshipExtraction

app = Flask(__name__)

user_ = '9f8f3b0b-67b3-4ed6-8dff-a275c7d74aaa'
pass_ = 'aeVsoRd90RnL'

relationship_extraction = RelationshipExtraction(username = user_, password = pass_)

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
    if request.method == 'POST':
        #print('IN POST')
        text = request.get_json()
        mess = str(relationship_extraction.extract(text['text']))
        #print(text['text'])
        #print(mess)
    
        message = {
            'message': mess
        }
        return jsonify(results=message)
    else:
        message = {
        'message': 'Boris Mierda'
    }
    return jsonify(results=message)
    

port = os.getenv('PORT', '5000')
if __name__ == "__main__":
    
	app.run(host='0.0.0.0', port=int(port))
