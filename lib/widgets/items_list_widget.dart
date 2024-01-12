import 'package:flutter/material.dart';

class ItemsListWidget extends StatelessWidget {
  const ItemsListWidget({
    super.key,
    required this.items,
    required this.dimension,
    required this.fontSize,
  });

  final List<int> items;
  final double dimension;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Items',
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: items
              .map(
                (int item) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Image.asset(
                    'assets/items/$item.jpg',
                    height: dimension,
                    width: dimension,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
