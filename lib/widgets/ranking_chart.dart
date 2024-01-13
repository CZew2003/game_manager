import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../services/sql_data_retriever_admin.dart';

class _BarChart extends StatelessWidget {
  const _BarChart({
    required this.ranks,
  });
  final List<Map<String, dynamic>> ranks;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Tooltip(
                  message: ranks[value.toInt()]['name'] as String,
                  child: Image.asset(
                    'assets/ranks/${ranks[value.toInt()]['name']}.png',
                    /*style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),*/
                    height: 50,
                    width: 50,
                  ),
                );
              },
            ),
          ),
          leftTitles: const AxisTitles(),
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
        ),
        borderData: borderData,
        barGroups: List<BarChartGroupData>.generate(ranks.length, (int index) {
          return BarChartGroupData(
            x: index,
            barsSpace: 100,
            barRods: <BarChartRodData>[
              BarChartRodData(
                toY: ranks[index]['players'] as double,
                gradient: _barsGradient,
              )
            ],
            showingTooltipIndicators: <int>[0],
          );
        }),
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: (ranks[0]['maxim'] as double) * 1.2,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: <Color>[
          Colors.blue,
          Colors.cyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
}

class RanksChart extends StatefulWidget {
  const RanksChart({super.key});

  @override
  State<StatefulWidget> createState() => RanksChartState();
}

class RanksChartState extends State<RanksChart> {
  SqlDataRetrieverAdmin sqlDataRetrieverAdmin = SqlDataRetrieverAdmin();
  late List<Map<String, dynamic>> ranks;
  bool loading = true;

  Future<void> fetchData() async {
    ranks = await sqlDataRetrieverAdmin.getRanksData();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fetchData();
    return Builder(builder: (BuildContext context) {
      if (loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return AspectRatio(
        aspectRatio: 2.5,
        child: _BarChart(
          ranks: ranks,
        ),
      );
    });
  }
}
