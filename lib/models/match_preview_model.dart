import 'player_preview_model.dart';

class MatchPreviewModel {
  MatchPreviewModel({
    required this.winner,
    required this.duration,
    required this.matchId,
    required this.players,
    required this.user,
  });

  final Team winner;
  final int duration;
  final int matchId;
  final List<PlayerPreviewModel> players;
  final String user;
}

enum Team { blue, red }
