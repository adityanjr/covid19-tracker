import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';
import 'lineCharts.dart';

class InfoCard extends StatelessWidget {
  final Function press;
  final String title;
  final int effectedNum;
  final Color color;
  const InfoCard({
    Key key,
    this.title,
    this.effectedNum,
    this.color,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: press,
          child: Container(
            width: constraints.maxWidth / 2 - 10,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3),
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: SizeConfig.safeBlockHorizontal * 8,
                        width: SizeConfig.safeBlockVertical * 5,
                        decoration: BoxDecoration(
                            color: color.withOpacity(.2),
                            shape: BoxShape.circle),
                        child: SvgPicture.asset(
                          "assets/icons/running.svg",
                          height: SizeConfig.safeBlockHorizontal * 5,
                          color: color,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.safeBlockHorizontal * 2),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontFamily: "Kayak",
                            fontSize: SizeConfig.safeBlockHorizontal * 4,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.safeBlockHorizontal * 3),
                        child: Text(
                          "$effectedNum\n",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Titillium",
                              fontSize: SizeConfig.safeBlockHorizontal * 7),
                        )),
                    Expanded(
                      child: LineReportChart(
                        chartColor: color,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
