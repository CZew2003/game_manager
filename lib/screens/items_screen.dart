import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../models/item_model.dart';
import '../services/sql_data_retriever_items.dart';
import '../widgets/appbar_navigation.dart';
import '../widgets/dialog_item.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});
  static const String route = '/Items-Screen';

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  List<ItemModel> items = <ItemModel>[];
  bool isLoading = true;
  SqlDataRetriverItems sqlDataRetriverItems = SqlDataRetriverItems();

  Future<void> fetchData() async {
    items = await sqlDataRetriverItems.getAllItems();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNavigation(
        toggleOnTap: () {
          Navigator.pop(context);
        },
      ).build(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              appBarColor,
              Colors.black12,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Builder(
          builder: (BuildContext context) {
            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return GridView.count(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              mainAxisSpacing: 4,
              crossAxisSpacing: 8,
              childAspectRatio: 1 / 0.85,
              shrinkWrap: true,
              crossAxisCount: 10,
              children: items.map((ItemModel item) {
                return GestureDetector(
                  onTap: () {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          return DialogItem(item: item);
                        });
                  },
                  child: Image.asset(
                    'assets/items/${item.id}.jpg',
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
