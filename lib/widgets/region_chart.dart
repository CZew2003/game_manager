import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../services/sql_data_retriever_admin.dart';
import 'indicator.dart';

class RegionChart extends StatefulWidget {
  const RegionChart({super.key});

  @override
  State<StatefulWidget> createState() => RegionChartState();
}

class RegionChartState extends State {
  SqlDataRetrieverAdmin sqlDataRetrieverAdmin = SqlDataRetrieverAdmin();
  int touchedIndex = -1;
  late List<Map<String, dynamic>> regions;
  bool loading = true;

  Future<void> fetchData() async {
    regions = await sqlDataRetrieverAdmin.getRegionData();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      if (loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return AspectRatio(
        aspectRatio: 1.3,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, PieTouchResponse? pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: regions
                  .map(
                    (Map<String, dynamic> region) => Column(
                      children: <Widget>[
                        Indicator(
                          color: region['color'] as Color,
                          text: region['name'] as String,
                          isSquare: false,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      );
    });
  }

  List<PieChartSectionData> showingSections() {
    return List<PieChartSectionData>.generate(
      regions.length,
      (int i) {
        final bool isTouched = i == touchedIndex;
        final double fontSize = isTouched ? 25.0 : 16.0;
        final double radius = isTouched ? 60.0 : 50.0;
        const List<Shadow> shadows = <Shadow>[Shadow(blurRadius: 2)];
        return PieChartSectionData(
          color: regions[i]['color'] as Color,
          value: regions[i]['ratio'] as double,
          title: regions[i]['players'].toString(),
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      },
    );
  }
}
