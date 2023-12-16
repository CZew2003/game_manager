import 'package:mysql_client/mysql_client.dart';

class Connector {
  static String host = 'localhost', user = 'root', password = 'TosaDumitru17', db = 'game_manager';
  static int port = 3306;

  Connector();

  Future<MySQLConnection> getConnection() async {
    return await MySQLConnection.createConnection(
      host: host,
      port: port,
      userName: user,
      password: password,
      databaseName: db,
    );
  }
}
