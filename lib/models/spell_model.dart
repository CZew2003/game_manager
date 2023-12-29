class SpellModel {
  SpellModel({
    required this.name,
    required this.description,
    required this.position,
    required this.cooldown,
  });
  final String name;
  final String description;
  final int position;
  final int cooldown;
}
