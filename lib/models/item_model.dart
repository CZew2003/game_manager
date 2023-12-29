class ItemModel {
  ItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.attackDamage,
    required this.abilityPower,
    required this.armor,
    required this.magicResist,
    required this.criticalStrike,
    required this.health,
    required this.price,
  });

  final int id;
  final String name;
  final String description;
  final int attackDamage;
  final int abilityPower;
  final int armor;
  final int magicResist;
  final int criticalStrike;
  final int health;
  final int price;
}
