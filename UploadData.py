# coding: utf-8 -*-
#!/usr/bin/python
import json
import requests
import sys

t1Value = sys.argv[1]
h1Value = sys.argv[2]

data=[{'Name': 't1', 'Value': t1Value}, {'Name': 'h1', 'Value': h1Value}]
data=json.dumps(data)
url="http://www.lewei50.com/api/V1/gateway/UpdateSensors/01"
headers={'userkey': '8c68c4d61c83443d803b6a3d710edfdd'}
response = requests.post(url, headers=headers, data=data)

print response.text

