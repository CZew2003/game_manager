import 'package:flutter/material.dart';

class ClientModel with ChangeNotifier {
  ClientModel() {
    _username = '';
    _role = Role.client;
    _orangeEssence = 0;
    _blueEssence = 0;
    _riotPoints = 0;
  }
  late String _username;
  late Role _role;
  late int _orangeEssence;
  late int _blueEssence;
  late int _riotPoints;

  set user(String username) {
    _username = username;
    notifyListeners();
  }

  void resetUser() {
    _username = '';
    notifyListeners();
  }

  String get user => _username;

  set role(Role role) {
    _role = role;
    notifyListeners();
  }

  Role get role => _role;

  int get blueEssence => _blueEssence;

  int get riotPoints => _riotPoints;

  int get orangeEssence => _orangeEssence;

  set blueEssence(int blueEssence) {
    _blueEssence = blueEssence;
    notifyListeners();
  }

  set orangeEssence(int orangeEssence) {
    _orangeEssence = orangeEssence;
    notifyListeners();
  }

  set riotPoints(int riotPoints) {
    _riotPoints = riotPoints;
    notifyListeners();
  }
}

enum Role { client, admin, superAdmin }
