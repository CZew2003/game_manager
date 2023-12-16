import 'package:flutter/material.dart';
import 'package:game_manager/models/champion_model.dart';
import 'package:game_manager/screens/champion_info_screen.dart';

class ChampionWidget extends StatelessWidget {
  const ChampionWidget({super.key, required this.champion});

  final ChampionModel champion;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MaterialButton(
          padding: const EdgeInsets.all(0),
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () {
            Navigator.pushNamed(context, ChampionInfoScreen.route, arguments: champion.name);
          },
          child: Opacity(
            opacity: champion.acquired ? 1 : 0.7,
            child: AspectRatio(
              aspectRatio: 1215 / 717,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/skins/${champion.name}_0.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        ListTile(
          trailing: !champion.acquired ? const Icon(Icons.lock) : null,
          title: Text(champion.name),
        )
      ],
    );
  }
}
