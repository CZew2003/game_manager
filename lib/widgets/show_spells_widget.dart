import 'package:flutter/material.dart';
import '../models/champion_info_model.dart';
import 'spell_widget.dart';

class ShowSpellsWidget extends StatelessWidget {
  const ShowSpellsWidget({super.key, required this.championInfoModel});
  final ChampionInfoModel championInfoModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Spells',
            style: TextStyle(fontSize: 32),
          ),
          const Divider(
            color: Colors.black38,
            thickness: 1.5,
          ),
          GridView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 0.25,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemCount: championInfoModel.spells.length,
            itemBuilder: (BuildContext context, int index) {
              return SpellWidget(
                champion: championInfoModel.name,
                spell: championInfoModel.spells[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
