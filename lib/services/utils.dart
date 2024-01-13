import 'dart:math';
import 'package:flutter/material.dart';

class Utils {
  static List<T> modelBuilderRows<M, T>(List<M> models, T Function(int index, M model) builder) => models
      .asMap()
      .map<int, T>((int index, M model) => MapEntry<int, T>(index, builder(index, model)))
      .values
      .toList();

  static Color getRandomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  static DateTime getDate(String date) {
    final List<int> list = date.split('-').map(int.parse).toList();
    return DateTime(list[0], list[1], list[2]);
  }
}

enum PanelType {
  champion,
  skin;
}
