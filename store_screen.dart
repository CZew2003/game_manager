import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/client_model.dart';
import '../widgets/bottom_navigation.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);
  static const String route = '/Store-Screen';

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  // Sample product list (you can replace it with your actual product data)
  final List<Product> productList = [
    Product(name: 'Blue Essence', price: 19.99, imagePath: 'assets/currencies/blueEssence.png'),
    Product(name: 'Orange Essence', price: 29.99, imagePath: 'assets/currencies/orangeEssence.png'),
    Product(name: 'Riot Points', price: 39.99, imagePath: 'assets/currencies/riotPoints.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Store'),
      ),
      bottomNavigationBar: const BottomNavigation(),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Two products per row
          crossAxisSpacing: 8.0, // Spacing between products horizontally
          mainAxisSpacing: 8.0, // Spacing between products vertically
        ),
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return Card(
            // Add border to each product
            elevation: 3.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    productList[index].imagePath,
                    height: 80.0, // Adjust the height as needed
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    productList[index].name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text('\$${productList[index].price.toString()}'),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      // Show a confirmation dialog when the "Buy" button is pressed
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirmation'),
                            content: Text('Do you want to buy ${productList[index].name}?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  //////////////////////////////////////////////////////
                                  print('Buy button pressed for ${productList[index].name}');
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: Text('Buy'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Buy'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  final String imagePath;

  Product({required this.name, required this.price, required this.imagePath});
}