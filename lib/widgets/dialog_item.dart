import 'package:flutter/material.dart';
import 'package:game_manager/widgets/stats_widget.dart';

import '../models/item_model.dart';

class DialogItem extends StatelessWidget {
  const DialogItem({
    super.key,
    required this.item,
  });

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StatsWidget(statName: 'Name', statValue: item.name, fontSize: 16),
              StatsWidget(statName: 'Description', statValue: item.description, fontSize: 16),
              StatsWidget(statName: 'Attack Damage', statValue: item.attackDamage.toString(), fontSize: 16),
              StatsWidget(statName: 'Ability Power', statValue: item.abilityPower.toString(), fontSize: 16),
              StatsWidget(statName: 'Armor', statValue: item.armor.toString(), fontSize: 16),
              StatsWidget(statName: 'Magic Resist', statValue: item.magicResist.toString(), fontSize: 16),
              StatsWidget(statName: 'Critical Strike', statValue: item.criticalStrike.toString(), fontSize: 16),
              StatsWidget(statName: 'Health', statValue: item.health.toString(), fontSize: 16),
              StatsWidget(statName: 'Price', statValue: item.price.toString(), fontSize: 16),
            ],
          ),
        ),
      ),
    );
  }
}
