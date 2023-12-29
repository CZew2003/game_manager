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
      final PreparedStmt stmt2 = await conn.prepare(getRegionAndRankQuery);
      await stmt2.execute(<String>[username]).then((IResultSet results) {
        for (final ResultSetRow row in results.rows) {
          clientInfoModel = ClientInfoModel(
            rank: row.colAt(1)!,
            region: row.colAt(0)!,
            username: username,
            friends: friends,
          );
        }
      });
      await conn.close();
    });

    return clientInfoModel;
  }
}
