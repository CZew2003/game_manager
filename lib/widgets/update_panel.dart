import 'package:flutter/material.dart';

import '../constants/snack_bar.dart';
import '../models/champion_panel_model.dart';
import '../models/skins_panel_model.dart';
import '../services/sql_data_retriever_admin.dart';
import '../services/utils.dart';
import 'champion_panel.dart';
import 'skin_panel.dart';
import 'text_field_login.dart';

class UpdatePanel extends StatefulWidget {
  const UpdatePanel({super.key, required this.selected, required this.onTap});
  final bool selected;
  final void Function() onTap;

  @override
  State<UpdatePanel> createState() => _UpdatePanelState();
}

class _UpdatePanelState extends State<UpdatePanel> {
  PanelType panelType = PanelType.champion;
  bool isLoading = true;
  List<ChampionPanelModel> champions = <ChampionPanelModel>[];
  List<SkinPanelModel> skins = <SkinPanelModel>[];
  SqlDataRetrieverAdmin sqlDataRetrieverAdmin = SqlDataRetrieverAdmin();
  TextEditingController controller = TextEditingController();

  Future<void> fetchChampionData() async {
    skins.clear();
    setState(() => isLoading = true);
    await sqlDataRetrieverAdmin.getChampionPanel().then((List<ChampionPanelModel> value) {
      champions = value
          .where((ChampionPanelModel element) => element.name.toLowerCase().contains(controller.text.toLowerCase()))
          .toList()
          .take(50)
          .toList();
    });
    setState(() => isLoading = false);
  }

  Future<void> fetchSkinsData() async {
    champions.clear();
    setState(() => isLoading = true);
    await sqlDataRetrieverAdmin.getSkinPanel().then((List<SkinPanelModel> value) {
      skins = value
          .where((SkinPanelModel element) => element.championName.toLowerCase().contains(controller.text.toLowerCase()))
          .toList()
          .take(50)
          .toList();
      ;
    });
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    fetchChampionData();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.selected) {
      controller.clear();
    }
    return Flexible(
      flex: widget.selected ? 4 : 1,
      child: GestureDetector(
        onTap: widget.onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: AnimatedContainer(
            color: widget.selected ? Colors.blue[100] : Colors.transparent,
            duration: const Duration(
              milliseconds: 500,
            ),
            child: Builder(
              builder: (BuildContext context) {
                if (!widget.selected) {
                  return const Center(child: Text('Click to open Update menu'));
                }
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FilledButton.tonal(
                            onPressed: () {
                              controller.clear();
                              setState(() => panelType = PanelType.champion);
                              fetchChampionData();
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Text('Champions'),
                            ),
                          ),
                          FilledButton.tonal(
                            onPressed: () {
                              controller.clear();
                              setState(() => panelType = PanelType.skin);
                              fetchSkinsData();
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Text('Skins'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            width: 400,
                            child: TextFieldLogin(
                                controller: controller, hintText: 'Search for a champion', hideText: false),
                          ),
                          FilledButton.tonal(
                            onPressed: () {
                              if (panelType == PanelType.champion) {
                                fetchChampionData();
                              } else {
                                fetchSkinsData();
                              }
                            },
                            child: const Text('Search'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Builder(builder: (BuildContext context) {
                          if (isLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (panelType == PanelType.champion) {
                            return ChampionPanel(
                              champions: champions,
                              changeState: (double? value, int index, ChampionPanelModel champion) {
                                setState(
                                  () {
                                    final int index = champions.indexOf(champion);
                                    champions[champions.indexOf(champion)] = champion.copyWith(
                                      health: index == 1 ? value!.toInt() : champion.health,
                                      mana: index == 2 ? value!.toInt() : champion.mana,
                                      armor: index == 4 ? value!.toInt() : champion.armor,
                                      magicResist: index == 5 ? value!.toInt() : champion.magicResist,
                                      movementSpeed: index == 6 ? value!.toInt() : champion.movementSpeed,
                                      healthRegen: index == 7 ? value!.toInt() : champion.healthRegen,
                                      damage: index == 8 ? value!.toInt() : champion.damage,
                                      attackSpeed: index == 9 ? value : champion.attackSpeed,
                                      fullPrice: index == 10 ? value!.toInt() : champion.fullPrice,
                                      shardPrice: index == 11 ? value!.toInt() : champion.shardPrice,
                                      disenchantPrice: index == 12 ? value!.toInt() : champion.disenchantPrice,
                                    );
                                  },
                                );
                              },
                            );
                          }
                          return SkinPanel(
                            skins: skins,
                            changeState: (double? value, int index, SkinPanelModel skin) async {
                              final int skinIndex = skins.indexOf(skin);
                              setState(
                                () {
                                  skins[skins.indexOf(skin)] = skin.copyWith(
                                    fullPrice: index == 2 ? value!.toInt() : skin.fullPrice,
                                    shardPrice: index == 3 ? value!.toInt() : skin.shardPrice,
                                    disenchantPrice: index == 4 ? value!.toInt() : skin.disenchantPrice,
                                  );
                                },
                              );
                              await sqlDataRetrieverAdmin
                                  .updateSkin(
                                    skins[skinIndex].skinName,
                                    skins[skinIndex].fullPrice,
                                    skins[skinIndex].shardPrice,
                                    skins[skinIndex].disenchantPrice,
                                  )
                                  .then(
                                    (_) => showSnackBar(context, 'Update has been registered'),
                                  );
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
