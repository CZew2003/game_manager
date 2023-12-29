import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(child: Text(text)),
      backgroundColor: Colors.teal,
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      width: 400,
    ),
  );
}
