import 'package:mysql_client/mysql_client.dart';

import 'connector.dart';
import 'sql_queries.dart';

class SqlDataRetrieverStore {
  Future<void> buyChampShard(String username) async {
    final Connector db = Connector();
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      await conn.prepare(buyChampShardWithRPProcedure).then((PreparedStmt stmt) async {
        await stmt.execute(<String>[username]);
      });
      await conn.close();
    });
  }

  Future<void> buySkinShard(String username) async {
    final Connector db = Connector();
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      await conn.prepare(buySkinShardWithRPProcedure).then((PreparedStmt stmt) async {
        await stmt.execute(<String>[username]);
      });
      await conn.close();
    });
  }

  Future<void> buyRp(String username, int price) async {
    final Connector db = Connector();
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      await conn.prepare(buyRpProcedure).then((PreparedStmt stmt) async {
        await stmt.execute(<String>[username, price.toString()]);
      });
      await conn.close();
    });
  }

  Future<void> buyOrangeEssence(String username, int price) async {
    final Connector db = Connector();
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      await conn.prepare(buyOrangeEssenceProcedure).then((PreparedStmt stmt) async {
        await stmt.execute(<String>[username, price.toString()]);
      });
      await conn.close();
    });
  }

  Future<void> buyBlueEssence(String username, int price) async {
    final Connector db = Connector();
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      await conn.prepare(buyBlueEssenceProcedure).then((PreparedStmt stmt) async {
        await stmt.execute(<String>[username, price.toString()]);
      });
      await conn.close();
    });
  }
}
