import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ClientModel with ChangeNotifier {
  late String _username;
  late Role _role;
  late int _orangeEssence;
  late int _blueEssence;
  late int _riotPoints;
  ClientModel() {
    _username = '';
    _role = Role.client;
    _orangeEssence = 0;
    _blueEssence = 0;
    _riotPoints = 0;
  }

  set setUser(String username) {
    _username = username;
    notifyListeners();
  }

  void resetUser() {
    _username = '';
    notifyListeners();
  }

  String get getUsername => _username;

  set setRole(Role role) {
    _role = role;
    notifyListeners();
  }

  Role get getRole => _role;

  int get getBlueEssence => _blueEssence;

  int get getRiotPoint => _riotPoints;

  int get getOrangeEssence => _orangeEssence;

  set setBlueEssence(int blueEssence) {
    _blueEssence = blueEssence;
    notifyListeners();
  }

  set setOrangeEssence(int orangeEssence) {
    _orangeEssence = orangeEssence;
    notifyListeners();
  }

  set setRiotPoints(int riotPoints) {
    _riotPoints = riotPoints;
    notifyListeners();
  }
}

enum Role { client, admin, superAdmin }
