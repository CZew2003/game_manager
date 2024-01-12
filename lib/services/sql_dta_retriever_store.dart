import 'package:mysql_client/src/mysql_client/connection.dart';

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
}
