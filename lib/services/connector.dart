import 'package:mysql1/mysql1.dart';

class Connector {
  static String host = 'localhost', user = 'root', password = 'TosaDumitru17', db = 'game_manager';
  static int port = 3306;

  Connector();

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db,
    );
    return await MySqlConnection.connect(settings);
  }

  Future<Results> getQueryResults(MySqlConnection conn, String query, [List<Object?>? params]) async {
    String newQuery = replacePlaceholders(query, params);
    print(newQuery);
    final result1 = await conn.query(newQuery);
    final result2 = await conn.query(newQuery);
    return result2;
  }

  Future<void> callProcedure(MySqlConnection conn, String procedure, [List<Object?>? params]) async {
    await conn.query(procedure, params);
  }

  String replacePlaceholders(String original, List<Object?>? replacements) {
    int index = 0;
    if (replacements == null) {
      return original;
    }
    return original.replaceAllMapped('?', (match) {
      if (index < replacements.length) {
        String replacement = replacements[index] as String;
        index++;
        return replacement;
      }
      return match.group(0)!;
    });
  }
}
