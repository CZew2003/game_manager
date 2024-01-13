import 'package:mysql_client/mysql_client.dart';

import '../models/match_preview_model.dart';
import '../models/player_preview_model.dart';
import 'connector.dart';
import 'sql_queries.dart';

class SqlDataRetrieverMatches {
  Future<List<MatchPreviewModel>> getAllMatchesPreview(String username) async {
    final Connector db = Connector();
    final List<MatchPreviewModel> matches = <MatchPreviewModel>[];

    await db.getConnection().then((MySQLConnection conn) async {
      await conn.connect();
      final PreparedStmt stmt = await conn.prepare(getMatchPreviewQuery);
      await stmt.execute(<String>[username]).then((IResultSet results) async {
        for (final ResultSetRow row in results.rows) {
          final List<PlayerPreviewModel> players = <PlayerPreviewModel>[];
          final int matchId = int.parse(row.colAt(0)!);
          final PreparedStmt stmt1 = await conn.prepare(getPlayerPreviewQuery);
          await stmt1.execute(<String>[matchId.toString()]).then(
            (IResultSet results1) {
              for (final ResultSetRow row1 in results1.rows) {
                final List<int> items = <int>[];
                for (int i = 5; i < 11; i++) {
                  items.add(int.parse(row1.colAt(i)!));
                }
                players.add(
                  PlayerPreviewModel(
                    username: row1.colAt(0)!,
                    position: row1.colAt(1)!,
                    team: row1.colAt(2)! == 'Blue team' ? Team.blue : Team.red,
                    championName: row1.colAt(3)!,
                    personalSkinId: int.parse(row1.colAt(4)!),
                    items: items,
                    damageDealt: int.parse(row1.colAt(11)!),
                    primaryRunes: row1.colAt(12)!,
                    secondaryRunes: row1.colAt(13)!,
                    rank: row1.colAt(14)!,
                  ),
                );
              }
            },
          );
          await stmt1.deallocate();
          matches.add(
            MatchPreviewModel(
              winner: row.colAt(2)! == 'Blue team' ? Team.blue : Team.red,
              duration: int.parse(row.colAt(1)!),
              matchId: matchId,
              players: players,
              user: username,
            ),
          );
        }
      });
      await conn.close();
    });

    return matches.take(10).toList();
  }
}
