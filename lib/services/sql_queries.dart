const String getRandomSkin = 'select champions.name, skins.personalId from skins join champions on '
    'skins.idChampion = champions.idChampion order by rand() limit 1;';

const String registerAccountProcedure = 'call game_manager.creare_client(?, ?, ?, @verify);';

const String verifyLoginUser = 'select * from clients where username = ? and password = ?';

const String getAllChampionsName = 'select name from champions';

const String getClientsInformations = 'select * from clients where username = ?';
