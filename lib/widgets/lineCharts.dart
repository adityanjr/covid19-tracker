import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineReportChart extends StatelessWidget {
  final Color chartColor;

  const LineReportChart({Key key, this.chartColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.5,
      child: LineChart(LineChartData(
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: getSpots(),
              isCurved: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              colors: [chartColor],
              barWidth: 3,
            )
          ])),
    );
  }
}

List<FlSpot> getSpots() {
  return [
    FlSpot(0, .01),
    FlSpot(1, .5),
    FlSpot(2, .1),
    FlSpot(3, .7),
    FlSpot(4, .2),
    FlSpot(5, 2),
    FlSpot(6, 1.5),
    FlSpot(7, 1.7),
    FlSpot(8, 1),
    FlSpot(9, 2.8),
    FlSpot(10, 2.5),
    FlSpot(11, 2.65),
  ];
}
