const String getRandomSkin = 'select champions.name, skins.personalId from skins join champions on '
    'skins.idChampion = champions.idChampion order by rand() limit 1;';

const String registerAccountProcedure = 'call game_manager.creare_client(?, ?, ?, @verify);';

const String verifyLoginUser = 'select * from clients where username = ? and password = ?';

const String getAllChampionsName = 'select name from champions';

const String getClientsInformations = 'select * from clients where username = ?';

const String getChampionOwnership = '''
  WITH AllChampions AS (
      SELECT idChampion, name
      FROM champions
  ),
  UserChampions AS (
      SELECT c.idChampion, c.name AS champion_name, 
             CASE WHEN cc.idClient IS NOT NULL THEN 1 ELSE 0 END AS owned_by_user
      FROM AllChampions c
      LEFT JOIN (
          SELECT idChampion, idClient
          FROM clientchampions
          WHERE idClient IN (SELECT idClient FROM clients WHERE username = ?)
      ) cc ON c.idChampion = cc.idChampion
  )
  SELECT champion_name, owned_by_user
  FROM UserChampions
  order by champion_name;
''';

const String getSpellsInfos = '''
  select * from spells
  join champions c on spells.idChampion = c.idChampion where c.name = ?;
''';

const String getSkinsInfos = '''
  SELECT DISTINCT
      skins.*,
      CASE WHEN clientskins.idClient IS NOT NULL THEN 'true' ELSE 'false' END AS Owned
  FROM 
      skins
  JOIN 
      champions ON skins.idChampion = champions.idChampion AND champions.name = ?
  LEFT JOIN 
      clientskins ON clientskins.idSkin = skins.idSkin 
      AND clientskins.idClient = (SELECT idClient FROM clients WHERE username = ?);
''';

const String getChampionInfo = '''
  SELECT 
    champions.*,
    case when clientchampions.idClient is not null then 'true' else 'false' end as Owned
  from champions
  left join
    clientchampions on clientchampions.idChampion = champions.idChampion
    and clientchampions.idClient = (select idClient from clients where username = ?)
  where champions.name = ?;
''';

const String callBuyChampionProcedure = 'call game_manager.BuySkinWithOrangeEssence(?, ?);';

const String getAllItemsQuery = 'select * from items';

const String getRegionAndRankQuery = '''
  SELECT 
      regions.name, ranks.name
  FROM
      clients
          JOIN
      regions ON clients.region = regions.idRegion
          JOIN
      ranks ON clients.ranking = ranks.idRank
  WHERE
      username = ?;
''';

const String getFriendsQuery = '''
  SELECT 
      c_friend.username
  FROM
      friends as f
  JOIN
    clients as c_main on c_main.idClient = f.friend1 or c_main.idClient = f.friend2
  JOIN 
    clients as c_friend on c_friend.idClient = f.friend1 or c_friend.idClient = f.friend2
  WHERE
      c_main.username = ?
      and  c_friend.idClient != c_main.idClient;
''';

const String callBuySkinWithRpProcedure = 'call BuySkinWithRP(?, ?);';
