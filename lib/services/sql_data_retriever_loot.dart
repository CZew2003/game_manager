import 'package:mysql_client/mysql_client.dart';

import '../models/champion_loot_model.dart';
import '../models/skin_loot_model.dart';
import 'connector.dart';
import 'sql_queries.dart';

class SqlDataRetrieverLoot {
  Future<List<ChampionLootModel>> getChampionLoot(String username) async {
    final List<ChampionLootModel> champions = <ChampionLootModel>[];
    final Connector db = Connector();
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final PreparedStmt stmt = await conn.prepare(getLootChampionsQuery);
      await stmt.execute(<String>[username]).then((IResultSet results) {
        for (final ResultSetRow row in results.rows) {
          champions.add(
            ChampionLootModel(
              name: row.colAt(0)!,
              shardPrice: int.parse(row.colAt(1)!),
              disenchantPrice: int.parse(row.colAt(2)!),
              id: int.parse(row.colAt(3)!),
            ),
          );
        }
      });
      await stmt.deallocate();
      await conn.close();
    });
    return champions;
  }

  Future<List<SkinLootChampion>> getSkinsLoot(String username) async {
    final List<SkinLootChampion> skins = <SkinLootChampion>[];
    final Connector db = Connector();
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final PreparedStmt stmt = await conn.prepare(getLootSkinsQuery);
      await stmt.execute(<String>[username]).then((IResultSet results) {
        for (final ResultSetRow row in results.rows) {
          skins.add(
            SkinLootChampion(
              championName: row.colAt(0)!,
              skinName: row.colAt(3)!,
              personalId: int.parse(row.colAt(4)!),
              shardPrice: int.parse(row.colAt(1)!),
              disenchantPrice: int.parse(row.colAt(2)!),
              id: int.parse(row.colAt(5)!),
            ),
          );
        }
      });
      await stmt.deallocate();
      await conn.close();
    });
    return skins;
  }

  Future<bool> buyChampion(int id) async {
    final Connector db = Connector();
    bool result = true;
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final PreparedStmt stmt = await conn.prepare(buyChampionShard);
      try {
        await stmt.execute(<String>[id.toString()]).then((IResultSet value) => result = true);
      } on Exception {
        result = false;
      }
      await conn.close();
    });
    return result;
  }

  Future<bool> disenchantSkin(String username, int id) async {
    final Connector db = Connector();
    bool result = true;
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final PreparedStmt stmt = await conn.prepare(disenchantSkinProcedure);
      try {
        await stmt.execute(<String>[username, id.toString()]).then((IResultSet value) => result = true);
      } on Exception {
        result = false;
      }
      await conn.close();
    });
    return result;
  }

  Future<bool> disenchantChampion(String username, int id) async {
    final Connector db = Connector();
    bool result = true;
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final PreparedStmt stmt = await conn.prepare(disenchantChampionProcedure);
      try {
        await stmt.execute(<String>[username, id.toString()]).then((IResultSet value) => result = true);
      } on Exception {
        result = false;
      }
      await conn.close();
    });
    return result;
  }

  Future<bool> buySkinShard(String username, int id) async {
    final Connector db = Connector();
    bool result = true;
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final PreparedStmt stmt = await conn.prepare(buySkinShardProcedure);
      try {
        await stmt.execute(<String>[username, id.toString()]).then((IResultSet value) => result = true);
      } on Exception {
        result = false;
      }
      await conn.close();
    });
    return result;
  }
}
