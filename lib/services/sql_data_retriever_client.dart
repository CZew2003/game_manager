import 'package:mysql_client/mysql_client.dart';

import '../models/client_info_model.dart';
import 'connector.dart';
import 'sql_queries.dart';

class SqlDataRetriverClient {
  Future<ClientInfoModel> getClientInformation(String username) async {
    final List<String> friends = <String>[];
    late ClientInfoModel clientInfoModel;
    final Connector db = Connector();
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final PreparedStmt stmt1 = await conn.prepare(getFriendsQuery);
      await stmt1.execute(<String>[username]).then((IResultSet results) {
        for (final ResultSetRow row in results.rows) {
          friends.add(row.colAt(0)!);
        }
      });
      await stmt1.deallocate();
      final PreparedStmt stmt2 = await conn.prepare(getRegionRankStatusQuery);
      await stmt2.execute(<String>[username]).then((IResultSet results) {
        for (final ResultSetRow row in results.rows) {
          clientInfoModel = ClientInfoModel(
            rank: row.colAt(1)!,
            region: row.colAt(0)!,
            username: username,
            friends: friends,
            statusMatches: int.parse(row.colAt(2)!),
          );
        }
      });
      await conn.close();
    });

    return clientInfoModel;
  }

  Future<bool> addFriend(String username1, String username2) async {
    final Connector db = Connector();
    late bool result;
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final PreparedStmt stmt = await conn.prepare(callAddFriendProcedure);
      try {
        await stmt.execute(<String>[username1, username2]).then((IResultSet results) => result = true);
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
