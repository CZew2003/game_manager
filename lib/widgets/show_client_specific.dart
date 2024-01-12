import 'package:flutter/material.dart';

class ShowClientSpecific extends StatelessWidget {
  const ShowClientSpecific({
    super.key,
    required this.title,
    required this.text,
    required this.foreground,
    required this.background,
  });

  final String title;
  final String text;
  final Color foreground;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CircleAvatar(
          radius: 40,
          backgroundColor: background,
          foregroundColor: foreground,
          child: Text(
            text,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }
}
