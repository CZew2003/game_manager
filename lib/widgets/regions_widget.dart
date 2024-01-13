import 'package:flutter/material.dart';
import 'region_chart.dart';

class RegionsWidget extends StatelessWidget {
  const RegionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
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
                  'Regions',
                  style: TextStyle(fontSize: 32),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: RegionChart(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
