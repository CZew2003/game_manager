import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../services/sql_data_retriever_admin.dart';
import '../widgets/appbar_navigation.dart';
import '../widgets/display_money_generate_match.dart';
import '../widgets/employee_panel.dart';
import '../widgets/most_active_players_chart.dart';
import '../widgets/ranks_widget.dart';
import '../widgets/regions_widget.dart';

class SuperAdminPanel extends StatefulWidget {
  SuperAdminPanel({super.key});
  static const String route = 'Super-Admin-Panel';

  @override
  State<SuperAdminPanel> createState() => _SuperAdminPanelState();
}

class _SuperAdminPanelState extends State<SuperAdminPanel> {
  SqlDataRetrieverAdmin sqlDataRetrieverAdmin = SqlDataRetrieverAdmin();

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
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      'Most Active Players',
                                      style: TextStyle(fontSize: 32),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Expanded(
                                    child: MostActivePlayersChart(),
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
                              ),
                              const RegionsWidget(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const RanksWidget(),
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
