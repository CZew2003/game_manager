import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../screens/champions_screen.dart';
import '../screens/items_screen.dart';
import '../screens/loot.dart';
import '../screens/match_history_screen.dart';
import '../screens/store_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List<bool> colors = <bool>[false, false, false, false, false];

  List<String> routes = <String>[
    ChampionsScreen.route,
    ItemsScreen.route,
    MatchHistoryScreen.route,
    LootScreen.route,
    StoreScreen.route,
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Material(
        color: bottomAppBarColor,
        child: SizedBox(
          height: 56,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: routes.map((String route) {
                return TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStatePropertyAll<Color>(
                      Colors.blueGrey[300]!,
                    ),
                  ),
                  onPressed: () async {
                    await Navigator.pushNamed(context, route);
                  },
                  onHover: (bool selected) {
                    setState(() {
                      colors[routes.indexOf(route)] = selected;
                    });
                  },
                  child: Text(
                    route.replaceAll('-', ' ').replaceAll('Screen', '').replaceAll('/', ''),
                    style: TextStyle(
                      fontSize: 16,
                      color: colors[routes.indexOf(route)] ? Colors.black : Colors.black38,
                    ),
                  ),
                );
              }).toList()),
        ),
      ),
    );
  }
}
