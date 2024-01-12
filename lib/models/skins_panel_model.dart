class SkinPanelModel {
  SkinPanelModel({
    required this.skinName,
    required this.championName,
    required this.fullPrice,
    required this.shardPrice,
    required this.disenchantPrice,
  });

  final String skinName;
  final String championName;
  final int fullPrice;
  final int shardPrice;
  final int disenchantPrice;

  static List<Map<String, dynamic>> titles = <Map<String, dynamic>>[
    <String, dynamic>{
      'field': 'Skin Name',
      'numeric': false,
    },
    <String, dynamic>{
      'field': 'Champion Name',
      'numeric': false,
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

  SkinPanelModel copyWith({
    String? skinName,
    String? championName,
    int? fullPrice,
    int? shardPrice,
    int? disenchantPrice,
  }) {
    return SkinPanelModel(
      skinName: skinName ?? this.skinName,
      championName: championName ?? this.championName,
      fullPrice: fullPrice ?? this.fullPrice,
      shardPrice: shardPrice ?? this.shardPrice,
      disenchantPrice: disenchantPrice ?? this.disenchantPrice,
    );
  }
}
