import time
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

def champions_values():
    insert_query = "INSERT INTO Champions VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"

    champions_data = []

    respond = requests.get('https://ddragon.leagueoflegends.com/cdn/13.23.1/data/en_US/champion.json')
    body = respond.json()
    champions = body['data']
    last = len(champions)
    for key, champion in champions.items():
        id = champion['key']
        name = champion['id']
        if name == 'Hwei':
            continue
        stats = champion['stats']
        hp = stats['hp']
        mana = stats['mp']
        manaType = champion['partype']
        armor = stats['armor']
        magicResist = stats['spellblock']
        speed = stats['movespeed']
        healthRegen = stats['hpregen']
        damage = stats['attackdamage']
        attackSpeed = stats['attackspeed']
        fullPrice = champion['info']['difficulty'] * 1000
        shardPrice = fullPrice // 2
        disenchantPrice = fullPrice // 5
        values = (id, name, hp, mana, manaType, armor, magicResist, speed, healthRegen, damage, attackSpeed, fullPrice,
                  shardPrice, disenchantPrice)

        champions_data.append(values)

    try:
        cursor.executemany(insert_query, champions_data)
        connection.commit()
        print('Inserted succesfully')
    except mysql.connector.Error as error:
        print(f'Error: {error}')
        if connection.is_connected():
            connection.rollback()

champions_values()
