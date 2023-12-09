import requests
import mysql.connector

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


def get_values():
    insert_query = "INSERT INTO Skins VALUES (%s, %s, %s, %s, %s, %s, %s)"

    skins_data = []

    id = 1

    response = requests.get('https://ddragon.leagueoflegends.com/cdn/13.24.1/data/en_US/champion.json')
    champions = response.json()['data']
    for champion in champions:
        if champion == 'Hwei':
            continue
        print(champion)
        response1 = requests.get('https://ddragon.leagueoflegends.com/cdn/13.23.1/data/en_US/champion/'
                                 + champion + '.json')
        data = response1.json()['data'][champion]
        for skin in data['skins']:
            values = [id]
            id += 1
            values.append(data['key'])
            personalId = int(skin['num'])
            values.append(personalId)
            values.append(skin['name'])
            if personalId == 0:
                values.extend([0, 0, 0])
            else:
                price = 0
                if skin['chromas']:
                    price = 2000
                else:
                    price = 1000
                values.extend([price, int(price * 1.5), int(price * 0.5)])
            skins_data.append(tuple(values))

    print(len(skins_data))
    try:
        cursor.executemany(insert_query, skins_data)
        connection.commit()
        print('Inserted succesfully')
    except mysql.connector.Error as error:
        print(f'Error: {error}')
        if connection.is_connected():
            connection.rollback()


get_values()