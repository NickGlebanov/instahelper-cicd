import json
import requests

token = open('token', 'r').read()
images_info = requests.get('https://api.vscale.io/v1/images', headers={'X-Token': token}).text
all_images = json.loads(images_info)
master_images = list(filter(lambda obj: obj.get('id').endswith('master')
                                        and obj.get('id').startswith('ubuntu')
                                        and 'spb0' in obj.get('locations')
                            , all_images))
target_image = sorted(master_images, key=lambda obj: obj.get('id'), reverse=True)[0]
print(json.loads(images_info)[0].get('id'))
print()
