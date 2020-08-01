import 'package:animations/animations.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/mainDrawer.dart';
import 'package:flutter_app/data/country_virus_data.dart';
import 'package:flutter_app/data/virus_data.dart';
import 'package:flutter_app/screens/prevention.dart';
import 'package:flutter_app/screens/states.dart';
import 'package:flutter_app/widgets/liveMap.dart';
import 'package:flutter_app/widgets/infoCard.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/widgets/preventionCard.dart';

import 'countries.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homepage';
  HomePage(
      {this.locationVirusData,
      this.virusData,
      this.countriesData,
      this.statesData});
  final virusData;
  final locationVirusData;
  final countriesData;
  final statesData;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VirusData data;
  CountryVirusData locationData;
  int index = 0;
  List<CountryVirusData> countriesData = [];
  bool isLight;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    updateUI(widget.virusData);

    updateLocationUI(widget.locationVirusData);
    updateCountriesUI(widget.countriesData);
    super.initState();
  }

  void updateUI(dynamic virusData) {
    setState(() {
      if (virusData == null) {
        data = VirusData(
          confirmedCases: 0,
          recovered: 0,
          deaths: 0,
        );
        return;
      }

      data = VirusData(
          confirmedCases: virusData['cases'],
          recovered: virusData['recovered'],
          deaths: virusData['deaths'],
          active: virusData['active']);
    });
  }

  void updateCountriesUI(dynamic virusData) {
    setState(() {
      if (virusData == null) {
        locationData = CountryVirusData(
          country: 'none',
          confirmedCases: 0,
          recovered: 0,
          deaths: 0,
        );
        print('error Null data obtained');
        return;
      }
      for (var eachData in virusData) {
        final countryData = CountryVirusData(
            country: eachData['country'],
            confirmedCases: eachData['cases'],
            recovered: eachData['recovered'],
            deaths: eachData['deaths'],
            flagUrl: eachData['countryInfo']['flag'],
            active: eachData['active']);
        countriesData.add(countryData);
      }
    });
  }

  void updateLocationUI(dynamic virusData) {
    setState(() {
      if (virusData == null) {
        locationData = CountryVirusData(
          country: 'none',
          confirmedCases: 0,
          recovered: 0,
          deaths: 0,
          active: 0,
        );
        return;
      }

      locationData = CountryVirusData(
          country: virusData['country'],
          confirmedCases: virusData['cases'],
          recovered: virusData['recovered'],
          deaths: virusData['deaths'],
          active: virusData['active']);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    isLight = DynamicTheme.of(context).brightness == Brightness.light;
    return Scaffold(
        appBar: AppBar(
          key: _scaffoldKey,
          backgroundColor: kPrimaryColor.withOpacity(.07),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.blue),
          title: Text(
            "Covid Tracker",
            style: TextStyle(color: isLight ? Colors.black : Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.lightbulb_outline),
              onPressed: () => setState(
                () {
                  if (isLight) {
                    // brightness = Brightness.dark;
                    isLight = !isLight;
                    DynamicTheme.of(context).setBrightness(Brightness.dark);
                  } else if (!isLight) {
                    isLight = !isLight;
                    // brightness = Brightness.light;
                    DynamicTheme.of(context).setBrightness(Brightness.light);
                  } else {
                    isLight =
                        DynamicThemeState().brightness == Brightness.light;
                    // brightness = Brightness.dark;
                    DynamicTheme.of(context).setBrightness(Brightness.dark);
                  }
                },
              ),
            )
          ],
        ),
        drawer: ClipPath(
          clipper: MyCustomClipper(),
          child: buildDrawer(context, isLight, widget),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: xMargin(2),
                right: xMargin(2),
                top: yMargin(1),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(.07),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
              ),
              child: Wrap(
                runSpacing: yMargin(1),
                spacing: xMargin(2),
                children: <Widget>[
                  InfoCard(
                    title: "Confirmed",
                    color: Colors.red,
                    effectedNum: locationData.confirmedCases,
                  ),
                  InfoCard(
                    title: "Deaths",
                    color: Colors.grey,
                    effectedNum: locationData.deaths,
                  ),
                  InfoCard(
                    title: "Recovered",
                    color: Colors.green,
                    effectedNum: locationData.recovered,
                  ),
                  InfoCard(
                    title: "Active",
                    color: Colors.blue,
                    effectedNum: locationData.active,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 15, bottom: 15),
                        child: Text(
                          "Last updated: ${DateTime.now().toString().substring(0, 10)}",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            CountriesInfoScreen(
                          countryVirusData: widget.countriesData,
                        ),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeScaleTransition(
                              animation: animation, child: child);
                        },
                      )),
                  child: PreventionCard(
                    srcAsset: "assets/icons/world.svg",
                    title: "Countries",
                    color: isLight ? Colors.black : Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    return Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 800),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            PreventionScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SharedAxisTransition(
                            child: child,
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.scaled,
                          );
                        },
                      ),
                    );
                  },
                  child: PreventionCard(
                      srcAsset: "assets/icons/Clean_Disinfect.svg",
                      title: "Preventions"),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 800),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          StatesInfoScreen(
                        stateVirusData: widget.statesData,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SharedAxisTransition(
                          child: child,
                          animation: animation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.scaled,
                        );
                      },
                    ),
                  ),
                  child: PreventionCard(
                    srcAsset: "assets/icons/india.svg",
                    title: "India",
                    color: isLight ? Colors.black : Colors.white,
                  ),
                ),
              ],
            ),
            LiveMapCard(
              index: index,
            )
          ],
        ));
  }
}
