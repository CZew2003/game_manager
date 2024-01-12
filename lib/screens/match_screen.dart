import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_protocol_extension.dart';

import '../constants/color_constants.dart';
import '../models/client_model.dart';
import '../models/match_preview_model.dart';
import '../models/player_preview_model.dart';
import '../widgets/appbar_navigation.dart';
import '../widgets/player_preview_widget.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key, required this.matchPreviewModel});
  static const String route = '/Match-Screen';

  final MatchPreviewModel matchPreviewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNavigation(
        toggleOnTap: () {
          Navigator.pop(context);
        },
      ).build(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[appBarColor, bottomAppBarColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Victory: ${matchPreviewModel.winner == Team.blue ? 'Blue' : 'Red'} Team',
                          style: const TextStyle(fontSize: 40),
                        ),
                        Text(
                          'Duration: ${matchPreviewModel.duration} min',
                          style: const TextStyle(fontSize: 40),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Team Blue - ${matchPreviewModel.winner == Team.blue ? 'Winners' : 'Loser'}',
                    style: const TextStyle(fontSize: 32, color: Colors.blue),
                  ),
                  SizedBox(
                    width: matchPreviewModel.winner == Team.blue ? 300 : 250,
                    child: const Divider(
                      thickness: 2.5,
                      color: Colors.blue,
                    ),
                  ),
                  ...matchPreviewModel.players.where((PlayerPreviewModel element) => element.team == Team.blue).map(
                        (PlayerPreviewModel e) => PlayerPreviewWidget(
                          playerPreviewModel: e,
                          user: matchPreviewModel.user,
                        ),
                      ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Team Red - ${matchPreviewModel.winner == Team.red ? 'Winners' : 'Loser'}',
                    style: const TextStyle(fontSize: 32, color: Colors.red),
                  ),
                  SizedBox(
                    width: matchPreviewModel.winner == Team.red ? 300 : 250,
                    child: const Divider(
                      thickness: 2.5,
                      color: Colors.red,
                    ),
                  ),
                  ...matchPreviewModel.players.where((PlayerPreviewModel element) => element.team == Team.red).map(
                        (PlayerPreviewModel e) => PlayerPreviewWidget(
                          playerPreviewModel: e,
                          user: matchPreviewModel.user,
                        ),
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
