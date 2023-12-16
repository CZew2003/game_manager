import 'package:game_manager/models/client_model.dart';
import 'package:game_manager/services/connector.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:provider/provider.dart';
import 'sql_queries.dart';
import 'package:flutter/material.dart';

class SqlDataRetriverRegistration {
  Future<String> getRandomSkinFromDatabase() async {
    Connector db = Connector();
    MySQLConnection conn = await db.getConnection();
    await conn.connect();

    IResultSet results = await conn.execute(getRandomSkin);
    late String randomSkinPath;
    for (var result in results.rows) {
      randomSkinPath = '${result.colAt(0)}_${result.colAt(1)}.jpg';
    }
    conn.close();
    return randomSkinPath;
  }

  Future<bool> verifyAccount(String username, String password) async {
    Connector db = Connector();
    if (username.isEmpty || password.isEmpty) {
      return false;
    }
    bool result = false;
    await db.getConnection().then((conn) async {
      await conn.connect();
      final stmt = await conn.prepare(verifyLoginUser);
      await stmt.execute([username, password]).then((results) {
        if (results.rows.isNotEmpty) {
          result = true;
        } else {
          result = false;
        }
      });
      conn.close();
    });
    return result;
  }

  Future<bool> registerAccount(String username, String password, String region) async {
    Connector db = Connector();
    if (username.isEmpty || password.isEmpty || region.isEmpty) {
      return false;
    }
    bool result = false;
    await db.getConnection().then((conn) async {
      await conn.connect();
      await conn.execute('set @verify = NULL');
      final stmt = await conn.prepare(registerAccountProcedure);
      await stmt.execute([region, username, password]).then((vaue) async {
        final results = await conn.execute('select @verify as verify');
        for (final res in results.rows) {
          if (res.colAt(0) == '0') {
            result = false;
          } else {
            result = true;
          }
        }
      });
      await stmt.deallocate();
      conn.close();
    });
    return result;
  }

  Future<void> setClient(BuildContext context, String username) async {
    Connector db = Connector();
    await db.getConnection().then((conn) async {
      await conn.connect();
      final stmt = await conn.prepare(getClientsInformations);
      await stmt.execute([username]).then((results) {
        for (final result in results.rows) {
          context.read<ClientModel>().setBlueEssence = int.parse(result.colAt(4)!);
          context.read<ClientModel>().setOrangeEssence = int.parse(result.colAt(6)!);
          context.read<ClientModel>().setRiotPoints = int.parse(result.colAt(5)!);
        }
      });
    });
  }
}
