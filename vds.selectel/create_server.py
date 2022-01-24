import json
import yaml
import requests
from yaml.loader import BaseLoader

config = yaml.load(open('server_config.yml', 'r'), Loader=BaseLoader)
target_os = config.get('os')
target_plan = config.get('plan')
target_location = config.get('location')

token = open('token', 'r').read()
images_info = requests.get('https://api.vscale.io/v1/images', headers={'X-Token': token}).text
all_images = json.loads(images_info)
master_images = list(filter(lambda obj: obj.get('id').endswith('master')
                                        and obj.get('id').startswith(target_os)
                                        and target_location in obj.get('locations')
                            , all_images))
target_image = sorted(master_images, key=lambda obj: obj.get('id'), reverse=True)[0]

server_name = config.get('server-name')

server_obj = {
    'make_from': target_image.get('id')
    , 'rplan': target_plan
    , 'do_start': True
    , 'name': server_name
    , 'keys': [int(config.get('ssh_key_id'))]
    , 'location': target_location
}
server_json = json.dumps(server_obj)
server_id = json.loads(requests.post('https://api.vscale.io/v1/scalets',
                                     headers={'X-Token': token},
                                     data=server_json
                                     ).text).get('id')
print('server created')
