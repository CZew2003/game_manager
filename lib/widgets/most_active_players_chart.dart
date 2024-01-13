import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../services/sql_data_retriever_admin.dart';

class _BarChart extends StatelessWidget {
  const _BarChart({
    required this.players,
  });
  final List<Map<String, dynamic>> players;

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
                return Center(
                  child: Text(
                    players[value.toInt()]['name'] as String,
                    style: TextStyle(color: Colors.grey[700]),
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
        barGroups: List<BarChartGroupData>.generate(players.length, (int index) {
          return BarChartGroupData(
            x: index,
            barsSpace: 100,
            barRods: <BarChartRodData>[
              BarChartRodData(
                toY: players[index]['matches'] as double,
                gradient: _barsGradient,
              )
            ],
            showingTooltipIndicators: <int>[0],
          );
        }),
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: (players[0]['maxim'] as double) * 1.2,
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

class MostActivePlayersChart extends StatefulWidget {
  const MostActivePlayersChart({super.key, required this.rebuild});

  final bool rebuild;

  @override
  State<StatefulWidget> createState() => MostActivePlayersChartState();
}

class MostActivePlayersChartState extends State<MostActivePlayersChart> {
  SqlDataRetrieverAdmin sqlDataRetrieverAdmin = SqlDataRetrieverAdmin();
  late List<Map<String, dynamic>> players;
  bool loading = true;

  Future<void> fetchData() async {
    players = await sqlDataRetrieverAdmin.getMostActivePlayers();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    //fetchData();
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
          players: players,
        ),
      );
    });
  }
}
