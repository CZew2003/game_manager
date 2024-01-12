import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../models/champion_model.dart';
import '../models/client_model.dart';
import '../services/sql_data_retriever_champions.dart';
import '../widgets/appbar_navigation.dart';
import '../widgets/champion_widget.dart';
import 'champion_info_screen.dart';

class ChampionsScreen extends StatefulWidget {
  const ChampionsScreen({super.key});
  static const String route = '/Champions-Screen';

  @override
  State<ChampionsScreen> createState() => _ChampionsScreenState();
}

class _ChampionsScreenState extends State<ChampionsScreen> {
  List<ChampionModel> champions = <ChampionModel>[];
  SqlDataRetriverChampions sqlDataRetriverChampions = SqlDataRetriverChampions();
  bool isLoading = true;

  Future<void> fetchData() async {
    champions = await sqlDataRetriverChampions.getChampionsFromClient(
      context.read<ClientModel>().user,
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarNavigation(
          toggleOnTap: () {
            Navigator.pop(context);
          },
        ).build(context),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                appBarColor,
                bottomAppBarColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Builder(
            builder: (BuildContext context) {
              if (isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GridView.count(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                mainAxisSpacing: 4,
                crossAxisSpacing: 8,
                childAspectRatio: 1 / 0.85,
                shrinkWrap: true,
                crossAxisCount: 6,
                children: champions
                    .map(
                      (ChampionModel champion) => ChampionWidget(
                        champion: champion,
                        toggleOnPressed: () async {
                          final bool result = (await Navigator.pushNamed(
                            context,
                            ChampionInfoScreen.route,
                            arguments: champion.name,
                          ))! as bool;
                          setState(() {
                            champions[champions.indexOf(champion)].acquired = result;
                          });
                        },
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ));
  }
}
