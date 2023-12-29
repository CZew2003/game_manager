import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../models/client_model.dart';

class AppBarNavigation extends StatelessWidget {
  const AppBarNavigation({super.key, required this.toggleOnTap});

  final void Function() toggleOnTap;

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(),
      backgroundColor: appBarColor,
      surfaceTintColor: appBarColor,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: toggleOnTap,
      ),
      title: const Text(
        'Game Manager',
      ),
      centerTitle: true,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            children: <Widget>[
              Image.asset(
                'assets/currencies/blueEssence.png',
                height: 30,
                width: 30,
              ),
              Text('${context.watch<ClientModel>().blueEssence}'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            children: <Widget>[
              Image.asset(
                'assets/currencies/orangeEssence.png',
                height: 30,
                width: 30,
              ),
              Text('${context.watch<ClientModel>().orangeEssence}'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            children: <Widget>[
              Image.asset(
                'assets/currencies/riotPoints.png',
                height: 30,
                width: 30,
              ),
              Text('${context.watch<ClientModel>().riotPoints}'),
            ],
          ),
        ),
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
