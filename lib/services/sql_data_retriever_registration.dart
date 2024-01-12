import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:provider/provider.dart';

import '../models/client_model.dart';
import 'connector.dart';
import 'sql_queries.dart';

class SqlDataRetriverRegistration {
  Future<String> getRandomSkinFromDatabase() async {
    final Connector db = Connector();
    final MySQLConnection conn = await db.getConnection();
    await conn.connect();

    final IResultSet results = await conn.execute(getRandomSkin);
    late String randomSkinPath;
    for (final ResultSetRow result in results.rows) {
      randomSkinPath = '${result.colAt(0)}_${result.colAt(1)}.jpg';
    }
    conn.close();
    return randomSkinPath;
  }

  Future<bool> verifyAccount(String username, String password) async {
    final Connector db = Connector();
    if (username.isEmpty || password.isEmpty) {
      return false;
    }
    bool result = false;
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final PreparedStmt stmt = await conn.prepare(verifyLoginUser);
      await stmt.execute(<String>[username, password]).then((IResultSet results) {
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
    final Connector db = Connector();
    if (username.isEmpty || password.isEmpty || region.isEmpty) {
      return false;
    }
    bool result = false;
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      await conn.execute('set @verify = NULL');
      final PreparedStmt stmt = await conn.prepare(registerAccountProcedure);
      await stmt.execute(<String>[region, username, password]).then((IResultSet vaue) async {
        final IResultSet results = await conn.execute('select @verify as verify');
        for (final ResultSetRow res in results.rows) {
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
    final Connector db = Connector();
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final PreparedStmt stmt = await conn.prepare(getClientsInformations);
      await stmt.execute(<String>[username]).then((IResultSet results) {
        for (final ResultSetRow result in results.rows) {
          final String? value = result.colAt(9);
          switch (value) {
            case null:
              context.read<ClientModel>().role = Role.client;
            case 'admin':
              context.read<ClientModel>().role = Role.admin;
            case 'super_admin':
              context.read<ClientModel>().role = Role.superAdmin;
            default:
              context.read<ClientModel>().role = Role.client;
          }
          context.read<ClientModel>().blueEssence = int.parse(result.colAt(4)!);
          context.read<ClientModel>().orangeEssence = int.parse(result.colAt(6)!);
          context.read<ClientModel>().riotPoints = int.parse(result.colAt(5)!);
        }
      });
      conn.close();
    });
  }
}
