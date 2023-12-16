import 'package:flutter/material.dart';
import 'package:game_manager/models/client_model.dart';
import 'package:game_manager/widgets/bottom_navigation.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatefulWidget {
  static const route = '/Store-Screen';

  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigation(),
      body: Text(context.watch<ClientModel>().getUsername),
    );
  }
}
