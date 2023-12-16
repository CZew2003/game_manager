import 'package:flutter/material.dart';
import 'package:game_manager/models/client_model.dart';
import 'package:game_manager/widgets/bottom_navigation.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/Home-Screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigation(),
      body: Column(
        children: [
          Text(context.watch<ClientModel>().getUsername),
          Text(context.watch<ClientModel>().getRiotPoint.toString()),
          Text(context.watch<ClientModel>().getBlueEssence.toString()),
          Text(context.watch<ClientModel>().getOrangeEssence.toString()),
        ],
      ),
    );
  }
}
