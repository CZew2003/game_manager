import 'package:game_manager/services/connector.dart';
import 'package:mysql1/mysql1.dart';
import 'sql_queries.dart';

class SqlDataRetriverRegistration {
  Future<String> getRandomSkinFromDatabase() async {
    Connector db = Connector();
    MySqlConnection conn = await db.getConnection();
    Results results = await db.getQueryResults(conn, getRandomSkin);
    late String randomSkinPath;
    for (var result in results) {
      randomSkinPath = '${result[0]}_${result[1]}.jpg';
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
      await db.getQueryResults(conn, verifyLoginUser, [username, password]).then(
        (results) {
          if (results.isNotEmpty) {
            result = true;
          } else {
            result = false;
          }
        },
      );
    });
    return result;
  }
}
