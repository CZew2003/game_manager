import time

import requests


def dowload_images():
    response = requests.get('https://ddragon.leagueoflegends.com/cdn/13.24.1/data/en_US/item.json')
    nr_calls = 1
    body = response.json()
    items = body['data']
    for id, value in items.items():
        if nr_calls == 95:
            print('Asteptam 2 minute')
            time.sleep(120)

        if not value['gold']['purchasable'] or not value['maps']['11']:
            continue
        image_path = value['image']['full']
        response1 = requests.get('https://ddragon.leagueoflegends.com/cdn/13.24.1/img/item/' + image_path)
        nr_calls = nr_calls + 1
        with open('C:\\Users\\lumin\\Desktop\\cursuri\\Baze de date\\proiect\\items\\'
                  + id + '.jpg', 'wb') as f:
            f.write(response1.content)


dowload_images()
