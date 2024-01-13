import 'package:flutter/material.dart';
import 'ranking_chart.dart';

class RanksWidget extends StatelessWidget {
  const RanksWidget({super.key, required this.rebuild});
  final bool rebuild;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.blue[100],
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text(
                  'Ranks',
                  style: TextStyle(fontSize: 32),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: RanksChart(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
