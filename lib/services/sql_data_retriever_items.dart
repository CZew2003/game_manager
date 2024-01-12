import 'package:mysql_client/mysql_client.dart';

import '../models/item_model.dart';
import 'connector.dart';
import 'sql_queries.dart';

class SqlDataRetriverItems {
  Future<List<ItemModel>> getAllItems() async {
    final Connector db = Connector();
    final List<ItemModel> items = <ItemModel>[];
    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final IResultSet results = await conn.execute(getAllItemsQuery);
      for (final ResultSetRow result in results.rows) {
        items.add(
          ItemModel(
            id: int.parse(result.colAt(0)!),
            name: result.colAt(1)!,
            description: result.colAt(2)!,
            attackDamage: int.parse(result.colAt(3)!),
            abilityPower: int.parse(result.colAt(4)!),
            armor: int.parse(result.colAt(5)!),
            magicResist: int.parse(result.colAt(6)!),
            criticalStrike: int.parse(result.colAt(7)!),
            health: int.parse(result.colAt(8)!),
            price: int.parse(result.colAt(9)!),
          ),
        );
      }
      await conn.close();
    });
    return items;
  }
}
