import 'package:flutter/material.dart';
import '../models/spell_model.dart';
import 'stats_widget.dart';

class SpellWidget extends StatelessWidget {
  const SpellWidget({
    super.key,
    required this.champion,
    required this.spell,
  });

  final String champion;
  final SpellModel spell;
  static const Map<int, String> dict = <int, String>{
    1: 'Spell Q',
    2: 'Spell W',
    3: 'Spell E',
    4: 'Spell R',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Spell ${spell.position}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        'assets/spells/$champion${spell.position}.jpg',
                        height: 64,
                        width: 64,
                      ),
                    ),
                    Text(spell.name),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          StatsWidget(
                            statName: 'Description',
                            statValue: spell.description.replaceAll('\n', 'da'),
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ),
                    if (spell.position != 1)
                      const SizedBox(
                        height: 10,
                      ),
                    StatsWidget(
                      statName: 'Cooldown',
                      statValue: spell.cooldown.toString(),
                      fontSize: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
