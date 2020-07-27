import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/totalCases.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/widgets/weeklyChart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class DetailsScreen extends StatelessWidget {
  final String weekCases =
      "https://disease.sh/v3/covid-19/historical/india?lastdays=7";
  Future<WeeklyCases> getWeeklyData() async {
    var response = await http.get(Uri.encodeFull(weekCases));
    final convertDataJson = jsonDecode(response.body);
    return WeeklyCases.fromJson(convertDataJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kPrimaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: kPrimaryColor.withOpacity(.2),
        elevation: 0,
      ),
      body: FutureBuilder<WeeklyCases>(
          future: getWeeklyData(),
          builder: (BuildContext context, snapShot) {
            if (snapShot.hasData) {
              final covid = snapShot.data;
              final incPercent =
                  (covid.cases2 - covid.cases3) / (covid.cases1 - covid.cases2);
              return Padding(
                padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 6),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "New Cases",
                                style: TextStyle(fontSize: 20),
                              ),
                              IconButton(
                                icon: Icon(Icons.more_vert),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 180,
                                        child: Text("HOLA"),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "${covid.cases1 - covid.cases2} ",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .copyWith(color: kPrimaryColor),
                              ),
                              Text(
                                "${incPercent.toStringAsFixed(2)}% ",
                                style: TextStyle(color: kPrimaryColor),
                              ),
                              SvgPicture.asset(
                                "assets/icons/increase.svg",
                                color: kPrimaryColor,
                              )
                            ],
                          ),
                          Text(
                            "From Health Centre",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: kTextMediumColor,
                                fontSize: 16),
                          ),
                          WeeklyChart(covid),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              PreviousPercentage(
                                  percent: 6.43, title: "From Last Week"),
                              PreviousPercentage(
                                percent: 9.43,
                                title: "Recovery Rate",
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else if (snapShot.hasError) {
              return Container(
                  height: SizeConfig.safeBlockVertical * 39.2,
                  child: Center(
                      child: Text("internet to ON krle\n   & Restart App")));
            } else
              return Container(
                height: SizeConfig.safeBlockVertical * 39.2,
              );
          }),
    );
  }
}

class PreviousPercentage extends StatelessWidget {
  final double percent;
  final String title;
  const PreviousPercentage({
    Key key,
    this.percent,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: "$percent%\n",
          style: TextStyle(fontSize: 20, color: kPrimaryColor),
        ),
        TextSpan(
          text: "$title",
          style: TextStyle(color: kTextMediumColor),
        ),
      ]),
    );
  }
}
