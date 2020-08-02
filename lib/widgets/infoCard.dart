import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final int effectedNum;
  final Color color;
  final String spot;
  const InfoCard({
    Key key,
    this.title,
    this.effectedNum,
    this.color,
    this.spot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: yMargin(2)),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: xMargin(5), vertical: yMargin(1)),
                width: xMargin(35),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: yMargin(2),
                  ),
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: xMargin(3)),
                    child: Text(
                      "$effectedNum",
                      style: TextStyle(fontSize: yMargin(4)),
                    )),
                Container(
                    margin: EdgeInsets.only(left: xMargin(18), top: yMargin(5)),
                    height: yMargin(6),
                    child: AspectRatio(
                      aspectRatio: 2.2,
                      child: LineChart(LineChartData(
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: spot == 'death'
                                  ? getSpotsDeath()
                                  : getSpotsConfirmed(),
                              isCurved: true,
                              dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(show: false),
                              colors: [color],
                              barWidth: 3.5,
                            )
                          ])),
                    ))
              ],
            )
          ],
        );
      },
    );
  }
}

List<FlSpot> getSpotsConfirmed() {
  return [
    FlSpot(2, .1),
    FlSpot(3, .7),
    FlSpot(4, .2),
    FlSpot(5, 1.5),
    FlSpot(6, 1.2),
    FlSpot(7, 1.3),
    FlSpot(8, 1),
    FlSpot(9, 2.8),
    FlSpot(10, 2.5),
    FlSpot(11, 2.65),
  ];
}

List<FlSpot> getSpotsDeath() {
  return [
    FlSpot(2, .2),
    FlSpot(3, .4),
    FlSpot(4, .3),
    FlSpot(5, 0.5),
    FlSpot(6, 0.6),
    FlSpot(7, 0.7),
    FlSpot(8, 0.6),
  ];
}
