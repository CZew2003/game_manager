import 'package:flutter/material.dart';
import 'package:game_manager/constants/color_constants.dart';
import 'package:game_manager/screens/Loot.dart';
import 'package:game_manager/screens/champions_screen.dart';
import 'package:game_manager/screens/home_screen.dart';
import 'package:game_manager/screens/match_history_screen.dart';
import 'package:game_manager/screens/store_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List<bool> colors = [false, false, false, false];

  List<String> routes = [
    ChampionsScreen.route,
    MatchHistoryScreen.route,
    LootScreen.route,
    StoreScreen.route,
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          // topRight: Radius.circular(28),
          //topLeft: Radius.circular(28),
          ),
      child: Material(
        color: bottomAppBarColor,
        child: SizedBox(
          height: 56,
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: routes.map((route) {
                return TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStatePropertyAll(
                      Colors.blueGrey[300]!,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, route);
                  },
                  onHover: (selected) {
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
