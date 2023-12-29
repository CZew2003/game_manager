import 'package:flutter/material.dart';

import '../models/champion_info_model.dart';
import 'champion_stats.dart';

class ShowChampionsStats extends StatefulWidget {
  const ShowChampionsStats({
    super.key,
    required this.championInfoModel,
    required this.toggleUnlock,
  });

  final ChampionInfoModel championInfoModel;
  final void Function() toggleUnlock;

  @override
  State<ShowChampionsStats> createState() => _ShowChampionsStatsState();
}

class _ShowChampionsStatsState extends State<ShowChampionsStats> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Champion stats',
            style: TextStyle(fontSize: 32),
          ),
          const Divider(
            color: Colors.black38,
            thickness: 1.5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      ChampionStats(
                        statName: 'Health: ',
                        statValue: widget.championInfoModel.health.toString(),
                        fontSize: 18,
                      ),
                      ChampionStats(
                        statName: 'Mana: ',
                        statValue: widget.championInfoModel.mana.toString(),
                        fontSize: 18,
                      ),
                      ChampionStats(
                        statName: 'Mana Type: ',
                        statValue: widget.championInfoModel.manaType,
                        fontSize: 18,
                      ),
                      ChampionStats(
                        statName: 'Armor: ',
                        statValue: widget.championInfoModel.armor.toString(),
                        fontSize: 18,
                      ),
                      ChampionStats(
                        statName: 'Magic Resist: ',
                        statValue: widget.championInfoModel.magicResist.toString(),
                        fontSize: 18,
                      ),
                      ChampionStats(
                        statName: 'Speed: ',
                        statValue: widget.championInfoModel.movementSpeed.toString(),
                        fontSize: 18,
                      ),
                      ChampionStats(
                        statName: 'Regen: ',
                        statValue: widget.championInfoModel.healthRegen.toString(),
                        fontSize: 18,
                      ),
                      ChampionStats(
                        statName: 'Damage: ',
                        statValue: widget.championInfoModel.damage.toString(),
                        fontSize: 18,
                      ),
                      ChampionStats(
                        statName: 'Attack Speed: ',
                        statValue: widget.championInfoModel.attackSpeed.toStringAsFixed(2),
                        fontSize: 18,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/skins/${widget.championInfoModel.name}_0.jpg',
                      width: 607,
                      height: 358,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (widget.championInfoModel.acquired)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Unlocked',
                        style: TextStyle(fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
                      ),
                    )
                  else
                    TextButton(
                      onPressed: widget.toggleUnlock,
                      child: Text(
                        '${widget.championInfoModel.fullPrice} BE',
                      ),
                    ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
