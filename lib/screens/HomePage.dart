import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/appBar.dart';
import 'package:flutter_app/components/mainDrawer.dart';
import 'package:flutter_app/components/preventions.dart';
import 'package:flutter_app/components/totalCases.dart';
import 'package:flutter_app/widgets/helpCard.dart';
import 'package:flutter_app/widgets/infoCard.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/constants.dart';

class HomePage extends StatelessWidget {
  final bool darkThemeEnabled;
  HomePage(this.darkThemeEnabled);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final String url = "https://api.rootnet.in/covid19-in/stats/latest";
  Future<TotalCases> getJsonData() async {
    var response = await http.get(Uri.encodeFull(url));
    final convertDataJson = jsonDecode(response.body);
    return TotalCases.fromJson(convertDataJson);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: buildAppBar(_scaffoldKey, darkThemeEnabled),
        drawer: ClipPath(
          clipper: MyCustomClipper(),
          child: buildDrawer(darkThemeEnabled),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: SizeConfig.safeBlockHorizontal * 4,
                right: SizeConfig.safeBlockHorizontal * 2,
                bottom: SizeConfig.safeBlockVertical * 3.5,
                top: SizeConfig.safeBlockVertical,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(.07),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
              ),
              child: FutureBuilder<TotalCases>(
                  future: getJsonData(),
                  builder: (BuildContext context, snapShot) {
                    if (snapShot.hasData) {
                      final covid = snapShot.data;
                      return Wrap(
                        runSpacing: SizeConfig.safeBlockVertical * 2,
                        spacing: SizeConfig.safeBlockHorizontal * 3,
                        children: <Widget>[
                          InfoCard(
                            title: "Confirmed",
                            color: Colors.red,
                            effectedNum: covid.cases,
                          ),
                          InfoCard(
                            title: "Deaths",
                            color: Colors.grey,
                            effectedNum: covid.deaths,
                          ),
                          InfoCard(
                            title: "Recovered",
                            color: Colors.green,
                            effectedNum: covid.recovered,
                          ),
                          InfoCard(
                            title: "Active",
                            color: Colors.blue,
                            effectedNum: covid.cases - covid.recovered,
                          ),
                        ],
                      );
                    } else if (snapShot.hasError) {
                      return Container(
                          height: SizeConfig.safeBlockVertical * 39.2,
                          child: Center(
                              child: Text(
                                  "internet to ON krle\n   & Restart App")));
                    } else
                      return Container(
                        height: SizeConfig.safeBlockVertical * 39.2,
                      );
                  }),
            ),
            Preventions(),
            HelpCard()
          ],
        ));
  }
}
