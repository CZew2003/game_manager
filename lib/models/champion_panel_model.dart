class ChampionPanelModel {
  const ChampionPanelModel({
    required this.name,
    required this.health,
    required this.mana,
    required this.manaType,
    required this.armor,
    required this.magicResist,
    required this.movementSpeed,
    required this.healthRegen,
    required this.damage,
    required this.attackSpeed,
    required this.fullPrice,
    required this.shardPrice,
    required this.disenchantPrice,
  });

  final String name;
  final int health;
  final int mana;
  final String manaType;
  final int armor;
  final int magicResist;
  final int movementSpeed;
  final int healthRegen;
  final int damage;
  final double attackSpeed;
  final int fullPrice;
  final int shardPrice;
  final int disenchantPrice;

  static List<Map<String, dynamic>> titles = <Map<String, dynamic>>[
    <String, dynamic>{
      'field': 'Name',
      'numeric': false,
    },
    <String, dynamic>{
      'field': 'Health',
      'numeric': true,
    },
    <String, dynamic>{
      'field': 'Mana',
      'numeric': true,
    },
    <String, dynamic>{
      'field': 'Mana Type',
      'numeric': false,
    },
    <String, dynamic>{
      'field': 'Armor',
      'numeric': true,
    },
    <String, dynamic>{
      'field': 'Magic Resist',
      'numeric': true,
    },
    <String, dynamic>{
      'field': 'Movement Speed',
      'numeric': true,
    },
    <String, dynamic>{
      'field': 'Health Regen',
      'numeric': true,
    },
    <String, dynamic>{
      'field': 'Damage',
      'numeric': true,
    },
    <String, dynamic>{
      'field': 'Attack Speed',
      'numeric': true,
    },
    <String, dynamic>{
      'field': 'Full Price',
      'numeric': true,
    },
    <String, dynamic>{
      'field': 'Shard Price',
      'numeric': true,
    },
    <String, dynamic>{
      'field': 'Disenchant Price',
      'numeric': true,
    },
  ];

  ChampionPanelModel copyWith({
    String? name,
    int? health,
    int? mana,
    String? manaType,
    int? armor,
    int? magicResist,
    int? movementSpeed,
    int? healthRegen,
    int? damage,
    double? attackSpeed,
    int? fullPrice,
    int? shardPrice,
    int? disenchantPrice,
  }) {
    return ChampionPanelModel(
      name: name ?? this.name,
      health: health ?? this.health,
      mana: mana ?? this.mana,
      manaType: manaType ?? this.manaType,
      armor: armor ?? this.armor,
      magicResist: magicResist ?? this.magicResist,
      movementSpeed: movementSpeed ?? this.movementSpeed,
      healthRegen: healthRegen ?? this.healthRegen,
      damage: damage ?? this.damage,
      attackSpeed: attackSpeed ?? this.attackSpeed,
      fullPrice: fullPrice ?? this.fullPrice,
      shardPrice: shardPrice ?? this.shardPrice,
      disenchantPrice: disenchantPrice ?? this.disenchantPrice,
    );
  }
}
