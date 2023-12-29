import 'package:mysql_client/mysql_client.dart';

class Connector {
  Connector();
  static String host = 'localhost', user = 'root', password = 'TosaDumitru17', db = 'game_manager';
  static int port = 3306;

  Future<MySQLConnection> getConnection() async {
    return MySQLConnection.createConnection(
      host: host,
      port: port,
      userName: user,
      password: password,
      databaseName: db,
    );
  }
}
