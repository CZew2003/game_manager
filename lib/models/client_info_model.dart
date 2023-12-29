class ClientInfoModel {
  const ClientInfoModel({
    required this.rank,
    required this.region,
    required this.username,
    required this.friends,
  });

  final String rank;
  final String region;
  final String username;
  final List<String> friends;
}
