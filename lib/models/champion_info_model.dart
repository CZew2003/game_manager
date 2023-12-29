import 'skin_model.dart';
import 'spell_model.dart';

class ChampionInfoModel {
  const ChampionInfoModel({
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
    required this.acquired,
    required this.spells,
    required this.skins,
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
  final bool acquired;
  final List<SpellModel> spells;
  final List<SkinModel> skins;

  ChampionInfoModel acquireChampion() {
    return ChampionInfoModel(
      name: name,
      health: health,
      mana: mana,
      manaType: manaType,
      armor: armor,
      magicResist: magicResist,
      movementSpeed: movementSpeed,
      healthRegen: healthRegen,
      damage: damage,
      attackSpeed: attackSpeed,
      fullPrice: fullPrice,
      acquired: true,
      spells: spells,
      skins: skins,
    );
  }
}
