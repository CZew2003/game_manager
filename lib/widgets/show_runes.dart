import 'package:flutter/material.dart';

class ShowRunes extends StatelessWidget {
  const ShowRunes({
    super.key,
    required this.primaryRunes,
    required this.secondaryRunes,
  });

  final String primaryRunes;
  final String secondaryRunes;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        const Text(
          'Runes: ',
          style: TextStyle(fontSize: 32),
        ),
        const SizedBox(
          width: 20,
        ),
        Image.asset(
          'assets/runes/$primaryRunes.png',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 10,
        ),
        Image.asset(
          'assets/runes/$secondaryRunes.png',
          width: 20,
          height: 20,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
