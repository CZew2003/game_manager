import 'client_model.dart';

class ClientPanelModel {
  ClientPanelModel({
    required this.username,
    required this.rank,
    required this.region,
    required this.blueEssence,
    required this.orangeEssence,
    required this.riotPoints,
    required this.password,
  });

  final String username;
  final String password;
  final String rank;
  final String region;
  final int blueEssence;
  final int orangeEssence;
  final int riotPoints;
  static List<Map<String, dynamic>> titles = <Map<String, dynamic>>[
    <String, dynamic>{
      'field': 'Username',
      'numeric': false,
      'role': Role.admin,
    },
    <String, dynamic>{
      'field': 'Password',
      'numeric': false,
      'role': Role.superAdmin,
    },
    <String, dynamic>{
      'field': 'Rank',
      'numeric': false,
      'role': Role.admin,
    },
    <String, dynamic>{
      'field': 'Region',
      'numeric': false,
      'role': Role.admin,
    },
    <String, dynamic>{
      'field': 'Blue Essence',
      'numeric': true,
      'role': Role.superAdmin,
    },
    <String, dynamic>{
      'field': 'Orange Essence',
      'numeric': true,
      'role': Role.superAdmin,
    },
    <String, dynamic>{
      'field': 'Riot Points',
      'numeric': true,
      'role': Role.superAdmin,
    },
  ];

  ClientPanelModel copyWith({
    String? username,
    String? password,
    String? rank,
    String? region,
    int? blueEssence,
    int? orangeEssence,
    int? riotPoints,
  }) {
    return ClientPanelModel(
      username: username ?? this.username,
      password: password ?? this.password,
      rank: rank ?? this.rank,
      region: region ?? this.region,
      blueEssence: blueEssence ?? this.blueEssence,
      orangeEssence: orangeEssence ?? this.orangeEssence,
      riotPoints: riotPoints ?? this.riotPoints,
    );
  }
}
