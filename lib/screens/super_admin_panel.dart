import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/snack_bar.dart';
import '../models/match_preview_model.dart';
import '../services/sql_data_retriever_admin.dart';
import '../widgets/appbar_navigation.dart';
import '../widgets/display_money_generate_match.dart';
import '../widgets/employee_panel.dart';
import '../widgets/most_active_players_chart.dart';
import '../widgets/ranks_widget.dart';
import '../widgets/regions_widget.dart';
import 'match_screen.dart';

class SuperAdminPanel extends StatefulWidget {
  const SuperAdminPanel({super.key});
  static const String route = 'Super-Admin-Panel';

  @override
  State<SuperAdminPanel> createState() => _SuperAdminPanelState();
}

class _SuperAdminPanelState extends State<SuperAdminPanel> {
  SqlDataRetrieverAdmin sqlDataRetrieverAdmin = SqlDataRetrieverAdmin();
  bool rebuild = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNavigation(
        toggleOnTap: () {
          Navigator.pop(context);
        },
        showStats: false,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: 600,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.blue[100],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: EmployeePanel(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.blue[100],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  const Center(
                                    child: Text(
                                      'Most Active Players',
                                      style: TextStyle(fontSize: 32),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Expanded(
                                    child: MostActivePlayersChart(rebuild: rebuild),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              DisplayMoneyGenerateMatch(
                                sqlDataRetrieverAdmin: sqlDataRetrieverAdmin,
                                onPressed: () async {
                                  await sqlDataRetrieverAdmin
                                      .generateMatch()
                                      .then(
                                        (_) => showSnackBar(context, 'Match Generated'),
                                      )
                                      .then(
                                    (_) async {
                                      await sqlDataRetrieverAdmin.getLastMatchPreview().then(
                                        (MatchPreviewModel match) async {
                                          await Navigator.pushNamed(
                                            context,
                                            MatchScreen.route,
                                            arguments: match,
                                          );
                                        },
                                      );
                                      print('da');
                                      setState(() {
                                        rebuild = !rebuild;
                                      });
                                    },
                                  );
                                },
                              ),
                              const RegionsWidget(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        RanksWidget(rebuild: rebuild),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
