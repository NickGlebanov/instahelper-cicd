import requests

token = open('token', 'r').read()
print(requests.get('https://api.vscale.io/v1/sshkeys', headers={'X-Token': token}).text)