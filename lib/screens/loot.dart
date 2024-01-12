import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../constants/snack_bar.dart';
import '../models/champion_loot_model.dart';
import '../models/client_model.dart';
import '../models/skin_loot_model.dart';
import '../services/sql_data_retriever_loot.dart';
import '../widgets/appbar_navigation.dart';
import '../widgets/buy_loot_dialog.dart';

class LootScreen extends StatefulWidget {
  const LootScreen({super.key});
  static const String route = '/Loot-Screen';

  @override
  State<LootScreen> createState() => _LootScreenState();
}

class _LootScreenState extends State<LootScreen> {
  late List<ChampionLootModel> champions;
  late List<SkinLootChampion> skins;
  SqlDataRetrieverLoot sqlDataRetrieverLoot = SqlDataRetrieverLoot();
  bool isLoading = true;

  Future<void> fetchData() async {
    setState(() => isLoading = true);
    await sqlDataRetrieverLoot.getChampionLoot(context.read<ClientModel>().user).then(
      (List<ChampionLootModel> value) async {
        champions = value;
        skins = await sqlDataRetrieverLoot.getSkinsLoot(context.read<ClientModel>().user);
      },
    );
    setState(() => isLoading = false);
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              appBarColor,
              bottomAppBarColor,
            ],
          ),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Builder(
            builder: (BuildContext context) {
              if (isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Champions - ${champions.length}',
                        style: const TextStyle(fontSize: 32),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GridView(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1.3,
                        ),
                        children: champions.map(
                          (ChampionLootModel champion) {
                            return GestureDetector(
                              onTap: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BuyLootDialog(
                                      shardPrice: champion.shardPrice,
                                      disenchantPrice: champion.disenchantPrice,
                                      imagePath: '${champion.name}_0.jpg',
                                      name: champion.name,
                                      buy: () async {
                                        await sqlDataRetrieverLoot.buyChampion(champion.id).then((bool result) {
                                          if (!result) {
                                            showSnackBar(context, 'Something went wrong');
                                          } else {
                                            context.read<ClientModel>().blueEssence =
                                                context.read<ClientModel>().blueEssence - champion.shardPrice;
                                            setState(() {
                                              champions.remove(champion);
                                            });
                                          }
                                        });
                                      },
                                      disenchant: () async {
                                        await sqlDataRetrieverLoot
                                            .disenchantChampion(
                                          context.read<ClientModel>().user,
                                          champion.id,
                                        )
                                            .then(
                                          (bool result) {
                                            if (!result) {
                                              showSnackBar(context, 'Something went wrong');
                                            } else {
                                              context.read<ClientModel>().blueEssence =
                                                  context.read<ClientModel>().blueEssence + champion.disenchantPrice;
                                              setState(
                                                () {
                                                  champions.remove(champion);
                                                },
                                              );
                                            }
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: Column(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset('assets/skins/${champion.name}_0.jpg'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    champion.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ).toList(),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Divider(
                        thickness: 1.5,
                        color: Colors.black54,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Skins - ${skins.length}',
                        style: const TextStyle(fontSize: 32),
                      ),
                      GridView(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1.3,
                        ),
                        children: skins.map(
                          (SkinLootChampion skin) {
                            return GestureDetector(
                              onTap: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BuyLootDialog(
                                      shardPrice: skin.shardPrice,
                                      disenchantPrice: skin.disenchantPrice,
                                      imagePath: '${skin.championName}_${skin.personalId}.jpg',
                                      name: skin.skinName,
                                      buy: () async {
                                        print(skin.id);
                                        await sqlDataRetrieverLoot
                                            .buySkinShard(
                                          context.read<ClientModel>().user,
                                          skin.id,
                                        )
                                            .then((bool result) {
                                          if (!result) {
                                            showSnackBar(context, 'Something went wrong');
                                          } else {
                                            context.read<ClientModel>().orangeEssence =
                                                context.read<ClientModel>().orangeEssence - skin.shardPrice;
                                            setState(() {
                                              skins.remove(skin);
                                            });
                                          }
                                        });
                                      },
                                      disenchant: () async {
                                        await sqlDataRetrieverLoot
                                            .disenchantSkin(
                                          context.read<ClientModel>().user,
                                          skin.id,
                                        )
                                            .then((bool result) {
                                          if (!result) {
                                            showSnackBar(context, 'Something went wrong');
                                          } else {
                                            context.read<ClientModel>().orangeEssence =
                                                context.read<ClientModel>().orangeEssence + skin.disenchantPrice;
                                            setState(() {
                                              skins.remove(skin);
                                            });
                                          }
                                        });
                                      },
                                    );
                                  },
                                );
                              },
                              child: Column(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset('assets/skins/${skin.championName}_${skin.personalId}.jpg'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    skin.skinName,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
