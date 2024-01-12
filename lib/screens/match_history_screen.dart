import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../models/client_model.dart';
import '../models/match_preview_model.dart';
import '../models/player_preview_model.dart';
import '../services/sql_data_retriever_matches.dart';
import '../widgets/appbar_navigation.dart';
import '../widgets/match_preview_widget.dart';

class MatchHistoryScreen extends StatefulWidget {
  const MatchHistoryScreen({super.key});
  static const String route = '/Match-History-Screen';

  @override
  State<MatchHistoryScreen> createState() => _MatchHistoryScreenState();
}

class _MatchHistoryScreenState extends State<MatchHistoryScreen> {
  bool loading = true;
  SqlDataRetrieverMatches sqlDataRetrieverMatches = SqlDataRetrieverMatches();
  late List<MatchPreviewModel> matches;

  Future<void> fetchData() async {
    setState(() {
      loading = true;
    });
    matches = await sqlDataRetrieverMatches.getAllMatchesPreview(context.read<ClientModel>().user);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

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
            if (loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: matches.length,
              itemBuilder: (BuildContext context, int index) {
                return MatchPreviewWidget(
                  match: matches[index],
                  player: matches[index].players.firstWhere((PlayerPreviewModel element) {
                    return element.username == context.watch<ClientModel>().user;
                  }),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
