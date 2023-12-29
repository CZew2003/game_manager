import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/client_model.dart';
import '../widgets/bottom_navigation.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});
  static const String route = '/Store-Screen';

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(),
      body: Text(context.watch<ClientModel>().user),
    );
  }
}
