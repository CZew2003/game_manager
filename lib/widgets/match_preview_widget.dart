import 'package:flutter/material.dart';

import '../models/match_preview_model.dart';
import '../models/player_preview_model.dart';
import '../screens/match_screen.dart';
import 'items_list_widget.dart';
import 'show_runes.dart';

class MatchPreviewWidget extends StatelessWidget {
  const MatchPreviewWidget({
    super.key,
    required this.match,
    required this.player,
  });

  final MatchPreviewModel match;
  final PlayerPreviewModel player;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            MatchScreen.route,
            arguments: match,
          );
        },
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:
                    match.winner == player.team ? Colors.lightBlue.withOpacity(0.7) : Colors.redAccent.withOpacity(0.7),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/skins/${player.championName}_${player.personalSkinId}.jpg',
                      height: 120,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        match.winner == player.team ? 'Victory' : 'Defeat',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        'assets/positions/${player.position}.png',
                        width: 50,
                        height: 50,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const SizedBox(
                    height: 100,
                    child: VerticalDivider(
                      color: Colors.black54,
                      thickness: 1.5,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ItemsListWidget(
                    items: player.items,
                    dimension: 50,
                    fontSize: 32,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const SizedBox(
                    height: 100,
                    child: VerticalDivider(
                      color: Colors.black54,
                      thickness: 1.5,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Duration: ${match.duration} min',
                        style: const TextStyle(fontSize: 32),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ShowRunes(
                        primaryRunes: player.primaryRunes,
                        secondaryRunes: player.secondaryRunes,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
