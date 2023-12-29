class SkinModel {
  SkinModel({
    required this.personalId,
    required this.name,
    required this.price,
    required this.acquired,
  });
  final int personalId;
  final String name;
  final int price;
  final bool acquired;

  SkinModel acquireSkin() {
    return SkinModel(personalId: personalId, name: name, price: price, acquired: true);
  }
}
