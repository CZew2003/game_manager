import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/client_model.dart';

class MatchHistoryScreen extends StatefulWidget {
  const MatchHistoryScreen({super.key});
  static const String route = '/Match-History-Screen';

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
      body: Text(context.watch<ClientModel>().user),
    );
  }
}
