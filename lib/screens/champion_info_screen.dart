import 'package:flutter/material.dart';
import 'package:game_manager/models/client_model.dart';
import 'package:game_manager/widgets/appbar_navigation.dart';
import 'package:game_manager/widgets/bottom_navigation.dart';
import 'package:provider/provider.dart';

class ChampionInfoScreen extends StatefulWidget {
  static const route = '/Champion-Info-Screen';

  const ChampionInfoScreen({super.key, required this.championName});

  final String championName;

  @override
  State<ChampionInfoScreen> createState() => _ChampionInfoScreenState();
}

class _ChampionInfoScreenState extends State<ChampionInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNavigation(
        toggleOnTap: () {
          Navigator.pop(context);
        },
      ).build(context),
      body: Text(widget.championName),
    );
  }
}
