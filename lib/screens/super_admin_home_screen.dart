import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../widgets/appbar_navigation.dart';
import 'admin_home_screen.dart';
import 'super_admin_panel.dart';

class SuperAdminHomeScreen extends StatelessWidget {
  const SuperAdminHomeScreen({super.key});
  static const String route = '/Super-Admin-Home-Screen';

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
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FilledButton(
                onPressed: () {
                  Navigator.pushNamed(context, SuperAdminPanel.route);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
                  child: Text(
                    'Go to Super Admin Panel',
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pushNamed(context, AdminHomeScreen.route);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
                  child: Text(
                    'Go to Admin Panel',
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
