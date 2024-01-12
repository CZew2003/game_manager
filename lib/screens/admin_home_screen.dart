import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../widgets/appbar_navigation.dart';
import '../widgets/client_panel.dart';
import '../widgets/update_panel.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});
  static const String route = '/Admin-Home-Screen';

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  bool firstContainerSelected = true;

  @override
  void initState() {
    super.initState();
  }

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
            colors: <Color>[appBarColor, bottomAppBarColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ClientPanel(
                selected: firstContainerSelected,
                onTap: () {
                  setState(() {
                    firstContainerSelected = true;
                  });
                },
              ),
              const SizedBox(
                width: 100,
              ),
              UpdatePanel(
                  selected: !firstContainerSelected,
                  onTap: () {
                    setState(() {
                      firstContainerSelected = false;
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
