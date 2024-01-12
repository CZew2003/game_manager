import 'package:flutter/material.dart';

import '../services/sql_data_retriever_admin.dart';

class MoneyWidget extends StatefulWidget {
  const MoneyWidget({super.key});

  @override
  State<MoneyWidget> createState() => _MoneyWidgetState();
}

class _MoneyWidgetState extends State<MoneyWidget> {
  SqlDataRetrieverAdmin sqlDataRetrieverAdmin = SqlDataRetrieverAdmin();

  Future<int> fetchData() async {
    return sqlDataRetrieverAdmin.getMoneyBank();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return Text(
            'Money: \n ${snapshot.data}\$',
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          );
        });
  }
}
