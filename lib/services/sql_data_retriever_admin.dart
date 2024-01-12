import 'dart:math';

import 'package:mysql_client/src/mysql_client/connection.dart';

import '../models/champion_panel_model.dart';
import '../models/client_panel_model.dart';
import '../models/employee_model.dart';
import '../models/skins_panel_model.dart';
import 'connector.dart';
import 'sql_queries.dart';
import 'utils.dart';

class SqlDataRetrieverAdmin {
  Future<List<ClientPanelModel>> getClientsPanel() async {
    final Connector db = Connector();
    final List<ClientPanelModel> clients = <ClientPanelModel>[];
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final IResultSet results = await conn.execute(getAllClients);
      for (final ResultSetRow row in results.rows) {
        clients.add(
          ClientPanelModel(
            username: row.colAt(0)!,
            rank: row.colAt(1)!,
            region: row.colAt(2)!,
            blueEssence: int.parse(row.colAt(3)!),
            orangeEssence: int.parse(row.colAt(4)!),
            riotPoints: int.parse(row.colAt(5)!),
            password: row.colAt(6)!,
          ),
        );
      }
      await conn.close();
    });
    return clients;
  }

  Future<List<ChampionPanelModel>> getChampionPanel() async {
    final List<ChampionPanelModel> champions = <ChampionPanelModel>[];
    final Connector db = Connector();
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final IResultSet results = await conn.execute(getChampionsInfoQuery);
      for (final ResultSetRow row in results.rows) {
        champions.add(
          ChampionPanelModel(
            name: row.colAt(1)!,
            health: int.parse(row.colAt(2)!),
            mana: int.parse(row.colAt(3)!),
            manaType: row.colAt(4)!,
            armor: int.parse(row.colAt(5)!),
            magicResist: int.parse(row.colAt(6)!),
            movementSpeed: int.parse(row.colAt(7)!),
            healthRegen: int.parse(row.colAt(8)!),
            damage: int.parse(row.colAt(9)!),
            attackSpeed: double.parse(row.colAt(10)!),
            fullPrice: int.parse(row.colAt(11)!),
            shardPrice: int.parse(row.colAt(12)!),
            disenchantPrice: int.parse(row.colAt(13)!),
          ),
        );
      }
      await conn.close();
    });
    return champions;
  }

  Future<List<SkinPanelModel>> getSkinPanel() async {
    final List<SkinPanelModel> skins = <SkinPanelModel>[];
    final Connector db = Connector();
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final IResultSet results = await conn.execute(getSkinsInfoQuery);
      for (final ResultSetRow row in results.rows) {
        skins.add(
          SkinPanelModel(
            skinName: row.colAt(0)!,
            championName: row.colAt(1)!,
            fullPrice: int.parse(row.colAt(2)!),
            shardPrice: int.parse(row.colAt(3)!),
            disenchantPrice: int.parse(row.colAt(4)!),
          ),
        );
      }
      await conn.close();
    });
    return skins;
  }

  Future<List<Map<String, dynamic>>> getRegionData() async {
    final List<Map<String, dynamic>> regions = <Map<String, dynamic>>[];
    final Connector db = Connector();
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final IResultSet results = await conn.execute(getRegionDataQuery);
      double totalPlayer = 0;
      for (final ResultSetRow row in results.rows) {
        totalPlayer += int.parse(row.colAt(3)!);
      }
      for (final ResultSetRow row in results.rows) {
        regions.add(
          <String, dynamic>{
            'name': row.colAt(1),
            'serverBase': row.colAt(2),
            'players': int.parse(row.colAt(3)!),
            'ratio': int.parse(row.colAt(3)!) / totalPlayer * 100,
            'color': Utils.getRandomColor(),
          },
        );
      }
      await conn.close();
    });
    return regions;
  }

  Future<List<Map<String, dynamic>>> getRanksData() async {
    final List<Map<String, dynamic>> ranks = <Map<String, dynamic>>[];
    final Connector db = Connector();
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final IResultSet results = await conn.execute(getRanksDataQuery);
      double maxValue = 0;
      for (final ResultSetRow row in results.rows) {
        maxValue = max(maxValue, double.parse(row.colAt(1)!));
      }
      for (final ResultSetRow row in results.rows) {
        ranks.add(<String, dynamic>{
          'name': row.colAt(0),
          'players': double.parse(row.colAt(1)!),
          'maxim': maxValue,
        });
      }
      await conn.close();
    });
    return ranks;
  }

  Future<List<Map<String, dynamic>>> getMostActivePlayers() async {
    final List<Map<String, dynamic>> players = <Map<String, dynamic>>[];
    final Connector db = Connector();
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final IResultSet results = await conn.execute(getMostActiveClientsQuery);
      double maxValue = 0;
      for (final ResultSetRow row in results.rows) {
        maxValue = max(maxValue, double.parse(row.colAt(1)!));
      }
      for (final ResultSetRow row in results.rows) {
        players.add(<String, dynamic>{
          'name': row.colAt(0),
          'matches': double.parse(row.colAt(1)!),
          'maxim': maxValue,
        });
      }
      await conn.close();
    });
    return players;
  }

  Future<List<EmployeeModel>> getAllEmployees() async {
    final List<EmployeeModel> employees = <EmployeeModel>[];
    final Connector db = Connector();
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final IResultSet results = await conn.execute(getEmployeeData);
      for (final ResultSetRow row in results.rows) {
        employees.add(
          EmployeeModel(
              name: row.colAt(0)!,
              username: row.colAt(1)!,
              salary: '${row.colAt(2)!} Lei',
              hoursMonthly: int.parse(row.colAt(3)!),
              expirationDate: row.colAt(4)!),
        );
      }
      await conn.close();
    });
    return employees;
  }

  Future<int> getMoneyBank() async {
    late int value;
    final Connector db = Connector();
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final IResultSet results = await conn.execute(getMoneyQuery);
      for (final ResultSetRow row in results.rows) {
        value = int.parse(row.colAt(1)!);
      }
      await conn.close();
    });
    return value;
  }

  Future<void> generateMatch() async {
    final Connector db = Connector();
    await db.getConnection().then((conn) async {
      await conn.connect();
      await conn.execute(generateMatchProcedure);
      await conn.close();
    });
  }
}
