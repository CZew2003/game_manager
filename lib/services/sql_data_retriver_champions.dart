import 'package:mysql_client/mysql_client.dart';

import '../models/champion_info_model.dart';
import '../models/champion_model.dart';
import '../models/skin_model.dart';
import '../models/spell_model.dart';
import 'connector.dart';
import 'sql_queries.dart';

class SqlDataRetriverChampions {
  Future<List<ChampionModel>> getChampionsFromClient(String username) async {
    final List<ChampionModel> champions = <ChampionModel>[];
    final Connector db = Connector();
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final PreparedStmt stmt = await conn.prepare(getChampionOwnership);
      await stmt.execute(<String>[username]).then((IResultSet results) {
        for (final ResultSetRow result in results.rows) {
          champions.add(
            ChampionModel(
              name: result.colAt(0)!,
              acquired: int.parse(result.colAt(1)!) == 1,
            ),
          );
        }
      });
      await conn.close();
    });
    return champions;
  }

  Future<ChampionInfoModel> getChampionInfoFromClient(String username, String champion) async {
    final List<SpellModel> spells = <SpellModel>[];
    final List<SkinModel> skins = <SkinModel>[];
    late ChampionInfoModel championInfoModel;
    final Connector db = Connector();
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final PreparedStmt stmt = await conn.prepare(getSpellsInfos);
      await stmt.execute(<String>[champion]).then((IResultSet results) {
        for (final ResultSetRow result in results.rows) {
          spells.add(
            SpellModel(
              name: result.colAt(2)!,
              description: result.colAt(3)!,
              position: int.parse(result.colAt(4)!),
              cooldown: int.parse(result.colAt(5)!),
            ),
          );
        }
      });
      await stmt.deallocate();
      final PreparedStmt stmt1 = await conn.prepare(getSkinsInfos);
      await stmt1.execute(<String>[champion, username]).then((IResultSet results) {
        for (final ResultSetRow result in results.rows) {
          if (result.colAt(3) == 'default') {
            continue;
          }
          skins.add(
            SkinModel(
              personalId: int.parse(result.colAt(2)!),
              name: result.colAt(3)!,
              price: int.parse(result.colAt(4)!),
              acquired: bool.parse(result.colAt(7)!),
            ),
          );
        }
      });
      await stmt1.deallocate();
      final PreparedStmt stmt2 = await conn.prepare(getChampionInfo);
      await stmt2.execute(<String>[username, champion]).then((IResultSet results) {
        for (final ResultSetRow result in results.rows) {
          championInfoModel = ChampionInfoModel(
            name: result.colAt(1)!,
            health: int.parse(result.colAt(2)!),
            mana: int.parse(result.colAt(3)!),
            manaType: result.colAt(4)!,
            armor: int.parse(result.colAt(5)!),
            magicResist: int.parse(result.colAt(6)!),
            movementSpeed: int.parse(result.colAt(7)!),
            healthRegen: int.parse(result.colAt(8)!),
            damage: int.parse(result.colAt(9)!),
            attackSpeed: double.parse(result.colAt(10)!),
            fullPrice: int.parse(result.colAt(11)!),
            acquired: bool.parse(result.colAt(14)!),
            spells: spells,
            skins: skins,
          );
        }
      });
      await conn.close();
    });
    return championInfoModel;
  }

  Future<bool> buyChampion(String username, String championName) async {
    final Connector db = Connector();
    bool result = true;
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final PreparedStmt stmt = await conn.prepare(callBuyChampionProcedure);
      try {
        await stmt.execute(<String>[username, championName]);
        result = true;
      } on Exception {
        result = false;
      } finally {
        await stmt.deallocate();
      }
      await conn.close();
    });
    return result;
  }

  Future<bool> buySkinWithRp(String username, String skinName) async {
    final Connector db = Connector();
    late bool result;
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final PreparedStmt stmt = await conn.prepare(callBuySkinWithRpProcedure);
      try {
        await stmt.execute(<String>[username, skinName]).then((IResultSet results) {
          result = true;
        });
      } on Exception {
        result = false;
      } finally {
        await stmt.deallocate();
      }
      await conn.close();
    });
    return result;
  }
}
