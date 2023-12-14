import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  const ButtonText({
    super.key,
    required this.toggleOnPressed,
    required this.text,
  });

  final Function() toggleOnPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: toggleOnPressed,
        style: const ButtonStyle(
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
