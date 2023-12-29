import 'package:flutter/material.dart';
import '../models/champion_model.dart';

class ChampionWidget extends StatelessWidget {
  const ChampionWidget({super.key, required this.champion, required this.toggleOnPressed});

  final ChampionModel champion;
  final void Function() toggleOnPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        MaterialButton(
          padding: EdgeInsets.zero,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: toggleOnPressed,
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
