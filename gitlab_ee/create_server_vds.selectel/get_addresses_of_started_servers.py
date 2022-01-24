import requests
import json

token = open('token', 'r').read()
servers = json.loads(requests.get('https://api.vscale.io/v1/scalets', headers={'X-Token': token}).text)
for server in servers:
    print(server.get('name'))
    print(server.get('public_address'))

