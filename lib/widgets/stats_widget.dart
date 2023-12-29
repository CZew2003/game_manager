import 'package:flutter/material.dart';

class StatsWidget extends StatelessWidget {
  const StatsWidget({super.key, required this.statName, required this.statValue, required this.fontSize});

  final String statName;
  final String statValue;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$statName:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            statValue,
            style: TextStyle(
              fontSize: fontSize,
            ),
          ),
        ),
      ],
    );
  }
}
