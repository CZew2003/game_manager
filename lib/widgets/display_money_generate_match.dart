import 'package:flutter/material.dart';

import '../services/sql_data_retriever_admin.dart';
import 'money_widget.dart';

class DisplayMoneyGenerateMatch extends StatelessWidget {
  const DisplayMoneyGenerateMatch({
    super.key,
    required this.sqlDataRetrieverAdmin,
    required this.onPressed,
  });

  final SqlDataRetrieverAdmin sqlDataRetrieverAdmin;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.blue[100],
                ),
                child: const Center(
                  child: MoneyWidget(),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              flex: 2,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                ),
                onPressed: onPressed,
                child: const Text(
                  'Generate Match',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
