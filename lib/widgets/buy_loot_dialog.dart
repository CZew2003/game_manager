import 'package:flutter/material.dart';

class BuyLootDialog extends StatelessWidget {
  const BuyLootDialog({
    super.key,
    required this.shardPrice,
    required this.disenchantPrice,
    required this.imagePath,
    required this.name,
    required this.buy,
    required this.disenchant,
  });

  final int shardPrice;
  final int disenchantPrice;
  final String imagePath;
  final String name;
  final void Function() buy;
  final void Function() disenchant;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/skins/$imagePath',
                height: 300,
                width: 500,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Text(
                      'Buy shard',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.lightBlue,
                      ),
                      onPressed: () {
                        buy();
                        Navigator.pop(context);
                      },
                      child: Text(
                        shardPrice.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 150,
                ),
                Column(
                  children: <Widget>[
                    const Text(
                      'Disenchant shard',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        surfaceTintColor: Colors.transparent,
                        foregroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        disenchant();
                        Navigator.pop(context);
                      },
                      child: Text(
                        disenchantPrice.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
