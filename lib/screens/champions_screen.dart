import 'package:flutter/material.dart';
import 'package:game_manager/models/client_model.dart';
import 'package:game_manager/widgets/appbar_navigation.dart';
import 'package:game_manager/widgets/bottom_navigation.dart';
import 'package:game_manager/widgets/champion_widget.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../models/champion_model.dart';

class ChampionsScreen extends StatefulWidget {
  static const route = '/Champions-Screen';

  const ChampionsScreen({super.key});

  @override
  State<ChampionsScreen> createState() => _ChampionsScreenState();
}

class _ChampionsScreenState extends State<ChampionsScreen> {
  List<ChampionModel> champions = [
    ChampionModel(name: 'Irelia', acquired: false),
    ChampionModel(name: 'Irelia', acquired: false),
    ChampionModel(name: 'Irelia', acquired: true),
    ChampionModel(name: 'Irelia', acquired: true),
    ChampionModel(name: 'Irelia', acquired: true),
    ChampionModel(name: 'Irelia', acquired: true),
    ChampionModel(name: 'Irelia', acquired: true),
    ChampionModel(name: 'Irelia', acquired: true),
    ChampionModel(name: 'Irelia', acquired: true),
    ChampionModel(name: 'Irelia', acquired: false),
    ChampionModel(name: 'Irelia', acquired: false),
    ChampionModel(name: 'Irelia', acquired: false),
    ChampionModel(name: 'Irelia', acquired: false),
    ChampionModel(name: 'Irelia', acquired: false),
    ChampionModel(name: 'Irelia', acquired: false),
    ChampionModel(name: 'Irelia', acquired: false),
    ChampionModel(name: 'Irelia', acquired: false),
    ChampionModel(name: 'Irelia', acquired: false),
    ChampionModel(name: 'Irelia', acquired: false),
    ChampionModel(name: 'Irelia', acquired: false),
    ChampionModel(name: 'Irelia', acquired: false),
    ChampionModel(name: 'Irelia', acquired: false),
    ChampionModel(name: 'Irelia', acquired: false),
    ChampionModel(name: 'Irelia', acquired: false),
    ChampionModel(name: 'Irelia', acquired: false),
    ChampionModel(name: 'Irelia', acquired: false),
    ChampionModel(name: 'Irelia', acquired: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarNavigation(
          toggleOnTap: () {
            Navigator.pop(context);
          },
        ).build(context),
        // bottomNavigationBar: const BottomNavigation(
        //   selectedValue: ChampionsScreen.route,
        // ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                appBarColor,
                bottomAppBarColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: GridView.count(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            mainAxisSpacing: 4,
            crossAxisSpacing: 8,
            childAspectRatio: (1 / 0.85),
            shrinkWrap: true,
            crossAxisCount: 6,
            children: champions
                .map(
                  (champion) => ChampionWidget(champion: champion),
                )
                .toList(),
          ),
        ));
  }
}
