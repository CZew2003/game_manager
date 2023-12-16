import 'package:flutter/material.dart';
import 'package:game_manager/constants/color_constants.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../models/client_model.dart';

class AppBarNavigation extends StatelessWidget {
  const AppBarNavigation({super.key, required this.toggleOnTap});

  final Function() toggleOnTap;

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            // bottomRight: Radius.circular(28),
            // bottomLeft: Radius.circular(28),
            ),
      ),
      backgroundColor: appBarColor,
      surfaceTintColor: appBarColor,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        'Game Manager',
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            icon: const Icon(Icons.close),
            color: Colors.black,
            onPressed: () {
              exit(0);
            },
          ),
        ),
      ],
    );
  }
}
