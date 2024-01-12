import 'package:flutter/material.dart';

import '../models/client_model.dart';
import '../models/match_preview_model.dart';
import '../models/player_preview_model.dart';
import 'items_list_widget.dart';
import 'show_runes.dart';

class PlayerPreviewWidget extends StatelessWidget {
  const PlayerPreviewWidget({
    super.key,
    required this.playerPreviewModel,
    required this.user,
  });

  final PlayerPreviewModel playerPreviewModel;
  final String user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/positions/${playerPreviewModel.position}.png',
                      height: 50,
                      width: 50,
                    ),
                    Image.asset(
                      'assets/ranks/${playerPreviewModel.rank}.png',
                      height: 100,
                      width: 100,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/skins/${playerPreviewModel.championName}_${playerPreviewModel.personalSkinId}.jpg',
                        height: 120,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      '${playerPreviewModel.username} - ${playerPreviewModel.championName}',
                      style: TextStyle(
                        fontSize: 20,
                        color: user == playerPreviewModel.username ? Colors.yellowAccent : Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 150,
                  width: 60,
                  child: VerticalDivider(
                    color: Colors.black54,
                    thickness: 1.5,
                  ),
                ),
                ItemsListWidget(
                  items: playerPreviewModel.items,
                  fontSize: 36,
                  dimension: 50,
                ),
                const SizedBox(
                  height: 150,
                  width: 60,
                  child: VerticalDivider(
                    color: Colors.black54,
                    thickness: 1.5,
                  ),
                ),
                Column(
                  children: <Widget>[
                    ShowRunes(
                      primaryRunes: playerPreviewModel.primaryRunes,
                      secondaryRunes: playerPreviewModel.secondaryRunes,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Damage dealt: ${playerPreviewModel.damageDealt}',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(
            thickness: 1.5,
            color: playerPreviewModel.team == Team.blue ? Colors.blue : Colors.red,
          ),
        ],
      ),
    );
  }
}
