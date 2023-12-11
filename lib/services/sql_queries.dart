const String getRandomSkin = 'select champions.name, skins.personalId from skins join champions on '
    'skins.idChampion = champions.idChampion order by rand() limit 1;';

const String callProcedura = 'call game_manager.creare_client(?, ?, ?, ?);';

const String verifyLoginUser = 'select * from clients where clientName = "?" and password = "?"';
