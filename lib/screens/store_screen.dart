import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../constants/snack_bar.dart';
import '../models/client_model.dart';
import '../services/sql_dta_retriever_store.dart';
import '../widgets/appbar_navigation.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});
  static const String route = '/Store-Screen';

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  // Sample product list (you can replace it with your actual product data)
  final List<Product> productList = <Product>[
    Product(name: 'Riot Points', price: 10, imagePath: 'assets/currencies/riotPoints.png', cantity: 250),
    Product(name: 'Riot Points', price: 25, imagePath: 'assets/currencies/riotPoints.png', cantity: 625),
    Product(name: 'Riot Points', price: 50, imagePath: 'assets/currencies/riotPoints.png', cantity: 1250),
    Product(name: 'Riot Points', price: 100, imagePath: 'assets/currencies/riotPoints.png', cantity: 2500),
    Product(name: 'Riot Points', price: 200, imagePath: 'assets/currencies/riotPoints.png', cantity: 5000),
    Product(name: 'Riot Points', price: 430, imagePath: 'assets/currencies/riotPoints.png', cantity: 10750),
  ];

  final List<Converter> converter = <Converter>[
    Converter(
      title: 'Blue Essence',
      subtitle: '1RP -> 10 BE',
      imagePath: 'assets/currencies/blueEssence.png',
      price: 1,
      functionType: 1,
    ),
    Converter(
      title: 'Blue Essence',
      subtitle: '100RP -> 1000 BE',
      imagePath: 'assets/currencies/blueEssence.png',
      price: 100,
      functionType: 1,
    ),
    Converter(
      title: 'Orange Essence',
      subtitle: '1RP -> 2 OE',
      imagePath: 'assets/currencies/orangeEssence.png',
      price: 1,
      functionType: 2,
    ),
    Converter(
      title: 'Orange Essence',
      subtitle: '100RP -> 200 OE',
      imagePath: 'assets/currencies/orangeEssence.png',
      price: 100,
      functionType: 2,
    ),
    Converter(
      title: 'Champion Shard',
      subtitle: '10RP -> 1 Champion Shard',
      imagePath: 'assets/currencies/riotPoints.png',
      functionType: 3,
    ),
    Converter(
      title: 'Skin Shard',
      subtitle: '100RP -> 1 Skin Shard',
      imagePath: 'assets/currencies/riotPoints.png',
      functionType: 4,
    ),
  ];
  SqlDataRetrieverStore sqlDataRetrieverStore = SqlDataRetrieverStore();

  Future<void> buySkinShard() async {
    await sqlDataRetrieverStore
        .buySkinShard(context.read<ClientModel>().user)
        .then((_) => showSnackBar(context, 'You have got a random skin shard'))
        .then((_) {
      context.read<ClientModel>().riotPoints = context.read<ClientModel>().riotPoints - 100;
    });
  }

  Future<void> buyChampShard() async {
    await sqlDataRetrieverStore
        .buyChampShard(context.read<ClientModel>().user)
        .then((_) => showSnackBar(context, 'You have got a random champion shard'))
        .then((_) {
      context.read<ClientModel>().riotPoints = context.read<ClientModel>().riotPoints - 10;
    });
  }

  Future<void> buyRP(int price, int rp) async {
    await sqlDataRetrieverStore
        .buyRp(context.read<ClientModel>().user, price)
        .then((_) => showSnackBar(context, 'Payment Acquired'))
        .then((_) {
      context.read<ClientModel>().riotPoints = context.read<ClientModel>().riotPoints + rp;
    });
  }

  Future<void> buyOrangeEssence(int price) async {
    await sqlDataRetrieverStore
        .buyOrangeEssence(context.read<ClientModel>().user, price)
        .then((_) => showSnackBar(context, 'Payment Acquired'))
        .then((_) {
      context.read<ClientModel>().riotPoints = context.read<ClientModel>().riotPoints - price;
      context.read<ClientModel>().orangeEssence = context.read<ClientModel>().orangeEssence + price * 2;
    });
  }

  Future<void> buyBlueEssence(int price) async {
    await sqlDataRetrieverStore
        .buyOrangeEssence(context.read<ClientModel>().user, price)
        .then((_) => showSnackBar(context, 'Payment Acquired'))
        .then((_) {
      context.read<ClientModel>().riotPoints = context.read<ClientModel>().riotPoints - price;
      context.read<ClientModel>().blueEssence = context.read<ClientModel>().blueEssence + price * 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNavigation(toggleOnTap: () {
        Navigator.pop(context);
      }).build(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              appBarColor,
              bottomAppBarColor,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 250,
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Buy RP',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 100,
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: productList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: SizedBox(
                              width: 200,
                              child: Card(
                                // Add border to each product
                                elevation: 3.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        productList[index].imagePath,
                                        height: 80.0, // Adjust the height as needed
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        '${productList[index].name}:  ${productList[index].cantity}',
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text('\$${productList[index].price}'),
                                      const SizedBox(height: 8.0),
                                      ElevatedButton(
                                        onPressed: () {
                                          buyRP(productList[index].price.toInt(), productList[index].cantity);
                                        },
                                        child: const Text('Buy'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 250,
                child: Column(
                  children: <Widget>[
                    const Text(
                      'RP SHOP',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 100,
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: converter.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: SizedBox(
                              width: 200,
                              child: Card(
                                // Add border to each product
                                elevation: 3.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        converter[index].imagePath,
                                        height: 80.0, // Adjust the height as needed
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        converter[index].title,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(converter[index].subtitle),
                                      const SizedBox(height: 8.0),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Show a confirmation dialog when the "Buy" button is pressed
                                          if (converter[index].functionType == 1) {
                                            buyBlueEssence(converter[index].price!);
                                          } else if (converter[index].functionType == 2) {
                                            buyOrangeEssence(converter[index].price!);
                                          } else if (converter[index].functionType == 3) {
                                            buyChampShard();
                                          } else if (index == 4) {
                                            buySkinShard();
                                          }
                                        },
                                        child: const Text('Buy'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Converter {
  Converter({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.functionType,
    this.price,
  });

  final String title;
  final String subtitle;
  final String imagePath;
  final int functionType;
  final int? price;
}

class Product {
  Product({required this.name, required this.price, required this.imagePath, required this.cantity});

  final String name;
  final double price;
  final String imagePath;
  final int cantity;
}
