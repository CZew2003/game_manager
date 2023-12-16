import 'package:flutter/material.dart';
import 'package:game_manager/models/client_model.dart';
import 'package:game_manager/widgets/bottom_navigation.dart';
import 'package:provider/provider.dart';

class LootScreen extends StatefulWidget {
  static const route = '/Loot-Screen';

  const LootScreen({super.key});

  @override
  State<LootScreen> createState() => _LootScreenState();
}

class _LootScreenState extends State<LootScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(),
      body: Text(context.watch<ClientModel>().getUsername),
    );
  }
}
