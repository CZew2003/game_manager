import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../constants/snack_bar.dart';
import '../models/champion_info_model.dart';
import '../models/client_model.dart';
import '../services/sql_data_retriver_champions.dart';
import '../widgets/appbar_navigation.dart';
import '../widgets/carousel_slide_show.dart';
import '../widgets/show_champions_stats.dart';
import '../widgets/show_spells_widget.dart';

class ChampionInfoScreen extends StatefulWidget {
  const ChampionInfoScreen({super.key, required this.championName});
  static const String route = '/Champion-Info-Screen';

  final String championName;

  @override
  State<ChampionInfoScreen> createState() => _ChampionInfoScreenState();
}

class _ChampionInfoScreenState extends State<ChampionInfoScreen> {
  SqlDataRetriverChampions sqlDataRetriverChampions = SqlDataRetriverChampions();
  bool isLoading = true;
  late ChampionInfoModel championInfoModel;
  CarouselController controllerSkins = CarouselController();
  int currentIndexSkin = 0;
  bool insuffiecientBE = false;

  Future<void> fetchChampionData() async {
    championInfoModel = await sqlDataRetriverChampions.getChampionInfoFromClient(
      context.read<ClientModel>().user,
      widget.championName,
    );
    setState(() => isLoading = false);
  }

  Future<void> buySkin(int skinIndex) async {
    await sqlDataRetriverChampions
        .buySkinWithRp(context.read<ClientModel>().user, championInfoModel.skins[skinIndex].name)
        .then((bool result) {
      if (result) {
        championInfoModel.skins[skinIndex] = championInfoModel.skins[skinIndex].acquireSkin();
        context.read<ClientModel>().riotPoints -= championInfoModel.skins[skinIndex].price;
      } else {
        showSnackBar(context, 'Insuficient RP');
      }
    });
  }

  Future<void> buyChampion() async {
    await sqlDataRetriverChampions
        .buyChampion(
      context.read<ClientModel>().user,
      championInfoModel.name,
    )
        .then(
      (bool result) async {
        if (result) {
          championInfoModel = championInfoModel.acquireChampion();
          context.read<ClientModel>().blueEssence -= championInfoModel.fullPrice;
        } else {
          showSnackBar(context, 'Insuficient BE');
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchChampionData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNavigation(
        toggleOnTap: () {
          Navigator.pop(context, championInfoModel.acquired);
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
            return CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: ShowChampionsStats(
                    championInfoModel: championInfoModel,
                    toggleUnlock: buyChampion,
                  ),
                ),
                SliverToBoxAdapter(
                  child: ShowSpellsWidget(
                    championInfoModel: championInfoModel,
                  ),
                ),
                SliverToBoxAdapter(
                  child: CarouselSlideShow(
                    controller: controllerSkins,
                    onPageChanged: (int index, CarouselPageChangedReason reason) {
                      setState(() {
                        currentIndexSkin = index;
                      });
                    },
                    championInfoModel: championInfoModel,
                    currentIndex: currentIndexSkin,
                    toggleOnPressed: buySkin,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 50,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
