const String getRandomSkin = 'select champions.name, skins.personalId from skins join champions on '
    'skins.idChampion = champions.idChampion order by rand() limit 1;';

const String registerAccountProcedure = 'call game_manager.creare_client(?, ?, ?, @verify);';

const String verifyLoginUser = 'select * from clients where username = ? and password = ?';

const String getAllChampionsName = 'select name from champions';

const String getClientsInformations = '''
SELECT 
    clients.*, roles.name
FROM
    clients
        LEFT JOIN
    employees ON employees.idClient = clients.idClient
        LEFT JOIN
    roles ON roles.idRole = employees.role
WHERE
    clients.username = ?;
''';

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

const String getRegionRankStatusQuery = '''
  SELECT 
      regions.name, ranks.name, clients.statusMatches
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

const String callAddFriendProcedure = 'call game_manager.AddFriend(?, ?);';

const String getMatchPreviewQuery = '''
  SELECT 
      matches.idMatch, matches.duration, teams.name
  FROM
      playermatch
          JOIN
      matches ON matches.idMatch = playermatch.idMatch
          JOIN
      teams ON matches.winner = teams.idTeam
          JOIN
      clients ON playermatch.idPlayer = clients.idClient
  WHERE
      clients.username = ?
  ORDER BY
      matches.idMatch desc
''';

const String getPlayerPreviewQuery = '''
  SELECT 
    clients.username,
    positions.name,
    teams.name,
    champions.name,
    skins.personalId,
    playermatch.item1,
    playermatch.item2,
    playermatch.item3,
    playermatch.item4,
    playermatch.item5,
    playermatch.item6,
    playermatch.damageDealt,
    primaryRunes.name,
    secondaryRunes.name,
    ranks.name
FROM
    playermatch
        JOIN
    clients ON clients.idClient = playermatch.idPlayer
        JOIN
    positions ON positions.idPosition = playermatch.position
        JOIN
    teams ON teams.idTeam = playermatch.team
        JOIN
    champions ON champions.idChampion = playermatch.idChampion
        JOIN
    skins ON skins.idSkin = playermatch.idSkin
        JOIN
    runes AS primaryRunes ON primaryRunes.idRune = playermatch.primaryRunes
        JOIN
    runes AS secondaryRunes ON secondaryRunes.idRune = playermatch.secondaryRunes
        JOIN
    ranks ON clients.ranking = ranks.idRank
WHERE
    playermatch.idMatch = ?;
''';

const String getLootChampionsQuery = '''
  SELECT 
      champions.name,
      champions.shardPrice,
      champions.disenchantPrice,
      lootchampions.idLootChampion
  FROM
      lootchampions
          JOIN
      clients ON lootchampions.idClient = clients.idClient
      join champions on
      lootchampions.idChampion = champions.idChampion
  WHERE
      clients.username = ?;
''';

const String getLootSkinsQuery = '''
  SELECT 
      champions.name,
      skins.priceOrangeEssence,
      skins.disenchantOrangeEssence,
      skins.name,
      skins.personalId,
      lootskins.idLootSkin
  FROM
      lootskins
          JOIN
      clients ON lootskins.idClient = clients.idClient
      join skins on
      lootskins.idSkin = skins.idSkin
      join champions on
      champions.idChampion = skins.idChampion
  WHERE
      clients.username = ?;
''';

const String getAllClients = '''
  SELECT 
    username,
    ranks.name,
    regions.name,
    blueEssence,
    clients.orrangeEssence,
    riotPoints,
    password
FROM
    clients
        LEFT JOIN
    employees ON clients.idClient = employees.idClient
        LEFT JOIN
    roles ON employees.role = roles.idRole
		LEFT JOIN
	ranks on ranks.idRank = clients.ranking
		LEFT JOIN
	regions on regions.idRegion = clients.region
WHERE
    roles.name IS NULL;
''';

const String getChampionsInfoQuery = 'select * from champions order by name';
const String getSkinsInfoQuery = '''
SELECT 
    skins.name,
    champions.name,
    skins.priceRp,
    skins.priceOrangeEssence,
    skins.disenchantOrangeEssence
FROM
    skins
        JOIN
    champions ON skins.idChampion = champions.idChampion
ORDER BY champions.name
''';

const String buyChampionShard = 'call game_manager.BuyChampWithShard(?);';
const String disenchantSkinProcedure = 'call game_manager.DisenchantSkin(?, ?);';
const String getRegionDataQuery = 'select * from regions';

const String getRanksDataQuery = '''
SELECT 
    ranks.name AS rank_name, COUNT(clients.ranking) AS number_players
FROM
    ranks
        LEFT JOIN
    clients ON clients.ranking = ranks.idRank
GROUP BY ranks.name;
''';

const String getMostActiveClientsQuery = '''
SELECT 
    clients.username, COUNT(playermatch.idPlayer)
FROM
    clients
        JOIN
    playermatch ON playermatch.idPlayer = clients.idClient
GROUP BY clients.username
ORDER BY COUNT(playermatch.idPlayer) DESC
LIMIT 5;
''';

const String getEmployeeData = '''
SELECT 
    name, username, salary, hoursMonthly, expirationContract
FROM
    employees
        JOIN
    clients ON clients.idClient = employees.idClient
WHERE
    employees.role = 1;
''';

const String getMoneyQuery = 'select * from riotBank';

const String generateMatchProcedure = 'call game_manager.StartMatch();';

const String disenchantChampionProcedure = 'call game_manager.DisenchantChampShard(?, ?);';

const String buyChampShardWithRPProcedure = 'call game_manager.BuyChampShardWithRP(?);';

const String buySkinShardWithRPProcedure = 'call game_manager.BuySkinShardWithRP(?);';

const String buySkinShardProcedure = 'call game_manager.BuySkinWithShard(?, ?);';
