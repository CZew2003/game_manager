import 'package:flutter/material.dart';
import 'package:game_manager/models/client_model.dart';
import 'package:game_manager/widgets/bottom_navigation.dart';
import 'package:provider/provider.dart';

class MatchHistoryScreen extends StatefulWidget {
  static const route = '/Match-History-Screen';

  const MatchHistoryScreen({super.key});

  @override
  State<MatchHistoryScreen> createState() => _MatchHistoryScreenState();
}

class _MatchHistoryScreenState extends State<MatchHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigation(
      //   selectedValue: MatchHistoryScreen.route,
      // ),
      body: Text(context.watch<ClientModel>().getUsername),
    );
  }
}
