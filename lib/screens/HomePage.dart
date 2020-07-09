import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/totalCases.dart';
import 'package:flutter_app/components/worldCases.dart';
import 'package:flutter_app/widgets/helpCard.dart';
import 'package:flutter_app/widgets/infoCard.dart';
import 'package:flutter_app/widgets/preventionCard.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  final String url = "https://api.rootnet.in/covid19-in/stats/latest";
  Future<TotalCases> getJsonData() async {
    var response = await http.get(Uri.encodeFull(url));
    if (response.statusCode == 200) {
      final convertDataJson = jsonDecode(response.body);
      return TotalCases.fromJson(convertDataJson);
    } else {
      throw Exception("Reload Kr!");
    }
  }

  @override //this loads data when app opens
  void initState() {
    super.initState();
    this.getJsonData();
  }

  navigateToCountry() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorldClass()));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -.4 : 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor.withOpacity(.07),
          elevation: 0,
          leading: !isDrawerOpen
              ? IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/menu.svg",
                    color: kPrimaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      xOffset = SizeConfig.safeBlockHorizontal * 60;
                      yOffset = SizeConfig.safeBlockVertical * 22;
                      scaleFactor = .7;
                      isDrawerOpen = true;
                    });
                  })
              : IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      xOffset = 0;
                      yOffset = 0;
                      scaleFactor = 1;
                      isDrawerOpen = false;
                    });
                  }),
          actions: <Widget>[
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/search.svg",
                color: kPrimaryColor,
              ),
              onPressed: () {},
            )
          ],
          title: Text(
            "Covid Tracker",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Titillium',
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.safeBlockVertical * 3),
          ),
          iconTheme: IconThemeData(color: Colors.blue),
        ),
        body: FutureBuilder<TotalCases>(
          future: getJsonData(),
          builder: (BuildContext context, snapShot) {
            if (snapShot.hasData) {
              final covid = snapShot.data;
              return Column(
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
                    child: Wrap(
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
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.safeBlockHorizontal * 6,
                            bottom: SizeConfig.safeBlockHorizontal * 4,
                            top: SizeConfig.safeBlockHorizontal * 2),
                        child: Text(
                          "Preventions >",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Titillium",
                              fontSize: SizeConfig.safeBlockVertical * 3),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockHorizontal * 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            PreventionCard(
                              srcAsset: "assets/icons/hand_wash.svg",
                              title: "Wash Hands",
                            ),
                            PreventionCard(
                              srcAsset: "assets/icons/use_mask.svg",
                              title: "Use Mask",
                            ),
                            PreventionCard(
                              srcAsset: "assets/icons/Clean_Disinfect.svg",
                              title: "Distancing",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  HelpCard()
                ],
              );
            } else if (snapShot.hasError) {
              return Text("internet to ON krle");
            } else
              return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
