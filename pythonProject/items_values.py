import mysql.connector
import requests

try:
    connection = mysql.connector.connect(
        host='localhost',
        user='root',
        password='TosaDumitru17',
        database='game_manager'
    )
    if connection.is_connected():
        print('Connected! OWOWOWWOWOOWO')
    cursor = connection.cursor()
except mysql.connector.Error as error:
    print('ERROOROR')


def get_items_values():
    insert_query = "INSERT INTO Items VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
    items_query = []

    respond = requests.get('https://ddragon.leagueoflegends.com/cdn/13.24.1/data/en_US/item.json')
    body = respond.json()
    items = body['data']
    for id, value in items.items():
        if not value['gold']['purchasable'] or not value['maps']['11']:
            continue
        values = [id, value['name'], value['plaintext']]
        if 'stats' in value:
            stats = value['stats']
            if 'FlatPhysicalDamageMod' in stats:
                values.append(stats['FlatPhysicalDamageMod'])
            else:
                values.append(0)

            if 'FlatMagicDamageMod' in stats:
                values.append(stats['FlatMagicDamageMod'])
            else:
                values.append(0)

            if 'FlatArmorMod' in stats:
                values.append(stats['FlatArmorMod'])
            else:
                values.append(0)

            if 'FlatSpellBlockMod' in stats:
                values.append(stats['FlatSpellBlockMod'])
            else:
                values.append(0)

            if 'FlatCritChanceMod' in stats:
                values.append(stats['FlatCritChanceMod'] * 100)
            else:
                values.append(0)
            if 'FlatHPPoolMod' in stats:
                values.append(stats['FlatHPPoolMod'])
            else:
                values.append(0)
        else:
            values.extend([0, 0, 0, 0, 0, 0])

        values.append(value['gold']['total'])
        items_query.append(tuple(values))

    try:
        cursor.executemany(insert_query, items_query)
        connection.commit()
        print('Inserted succesfully')
    except mysql.connector.Error as error:
        print(f'Error: {error}')
        if connection.is_connected():
            connection.rollback()


get_items_values()
