import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/client_model.dart';
import '../widgets/bottom_navigation.dart';

class LootScreen extends StatefulWidget {
  const LootScreen({super.key});
  static const String route = '/Loot-Screen';

  @override
  State<LootScreen> createState() => _LootScreenState();
}

class _LootScreenState extends State<LootScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(),
      body: Text(context.watch<ClientModel>().user),
    );
  }
}
