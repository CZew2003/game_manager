import time

import requests

def skins_images():
    respond = requests.get('https://ddragon.leagueoflegends.com/cdn/13.23.1/data/en_US/champion.json')

    body = respond.json()

    champions = body['data']


    def get_skins():
        skins = 0
        for champion in champions:
            print(champion)
            respond1 = requests.get('https://ddragon.leagueoflegends.com/cdn/13.23.1/data/en_US/champion/'
                                    + champion + '.json')
            body1 = respond1.json()
            skins += len(body1['data'][champion]['skins'])

        print(skins)


    def get_champs():
        champs = 0
        for champion in champions:
            champs += 1

        print(champs)


    def download():
        respond1 = requests.get('https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Aatrox_0.jpg')
        with open('C:\\Users\\lumin\\Desktop\\cursuri\\Baze de date\\proiect\\skins\\Aatrox_0.jpg', 'wb') as f:
            f.write(respond1.content)


    def downloadSkins():
        nrCalls = 1
        for champion in champions:
            if nrCalls == 95:
                print('Asteptam 2 minute aia e')
                nrCalls = 0
                time.sleep(120)
            print(champion)
            nrCalls += 1
            respond1 = requests.get('https://ddragon.leagueoflegends.com/cdn/13.23.1/data/en_US/champion/'
                                    + champion + '.json')
            body1 = respond1.json()
            skins = body1['data'][champion]['skins']
            for skin in skins:
                if nrCalls == 95:
                    print('Asteptam 2 minute aia e')
                    nrCalls = 0
                    time.sleep(120)

                id = int(skin['id']) % 1000
                nrCalls += 1
                respond1 = requests.get('https://ddragon.leagueoflegends.com/cdn/img/champion/splash/'
                                        + champion + '_' + str(id) + '.jpg')
                with open('C:\\Users\\lumin\\Desktop\\cursuri\\Baze de date\\proiect\\skins\\'
                          + champion + '_' + str(id) + '.jpg', 'wb') as f:
                    f.write(respond1.content)


    downloadSkins()

skins_images()