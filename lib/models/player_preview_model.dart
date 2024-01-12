import 'match_preview_model.dart';

class PlayerPreviewModel {
  PlayerPreviewModel({
    required this.username,
    required this.position,
    required this.team,
    required this.championName,
    required this.personalSkinId,
    required this.items,
    required this.damageDealt,
    required this.primaryRunes,
    required this.secondaryRunes,
    required this.rank,
  });

  final String username;
  final String position;
  final Team team;
  final String championName;
  final int personalSkinId;
  final List<int> items;
  final int damageDealt;
  final String primaryRunes;
  final String secondaryRunes;
  final String rank;
}
