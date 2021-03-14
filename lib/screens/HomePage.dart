import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/country_virus_data.dart';
import 'package:flutter_app/data/virus_data.dart';
import 'package:flutter_app/screens/aboutCovid.dart';
import 'package:flutter_app/screens/charts.dart';
import 'package:flutter_app/screens/liveMap.dart';
import 'package:flutter_app/screens/states.dart';
import 'package:flutter_app/widgets/mainDrawer.dart';
import 'package:flutter_app/widgets/preventionCard.dart';
import 'package:flutter_app/widgets/infoCard.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/widgets/widgetCard.dart';
import 'package:flutter_app/widgets/worldCard.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
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
  bool isLight = true;

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
        print('null');
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
    return Scaffold(
        appBar: AppBar(
          key: _scaffoldKey,
          backgroundColor: kPrimaryColor.withOpacity(.07),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.blue),
          title: Text(
            "Covid Tracker",
            style: TextStyle(
              color: isLight ? Colors.black : Colors.white,
              fontSize: yMargin(3.2),
              fontFamily: 'Titillium',
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.lightbulb_outline),
              onPressed: () {
                isLight ? AdaptiveTheme.of(context).setDark() : AdaptiveTheme.of(context).setLight();
                setState(() {
                  isLight = !isLight;
                });
              }
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
                top: yMargin(0.2),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(.07),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              child: Wrap(
                spacing: xMargin(3),
                alignment: WrapAlignment.spaceEvenly,
                runSpacing: yMargin(2),
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
                    spot: "death",
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: xMargin(4)),
                        child: TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChartsScreen(
                                countryName: '${locationData.country}',
                                cases: double.parse(
                                    '${locationData.confirmedCases}'),
                                deaths: double.parse('${locationData.deaths}'),
                                recovered:
                                    double.parse('${locationData.recovered}'),
                              ),
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Text("Infographs"),
                              SizedBox(
                                width: 3,
                              ),
                              SvgPicture.asset(
                                "assets/icons/increase.svg",
                                color: Colors.red,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: yMargin(1), right: xMargin(6)),
                        child: Text(
                          "Location: ${locationData.country}\nLast updated: ${DateTime.now().toString().substring(0, 10)}",
                          style: TextStyle(fontSize: yMargin(1.4)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            WorldCard(
              widget: widget,
              cases: data.confirmedCases,
              deaths: data.deaths,
              isLight: isLight,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: xMargin(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => AboutCovid()));
                    },
                    child: WidgetCard(
                      srcAsset: "assets/icons/virus.svg",
                      title: "COVID-19",
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 800),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
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
                      );
                    },
                    child: WidgetCard(
                      srcAsset: "assets/icons/india.svg",
                      title: "Indian States",
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapsScreen(),
                      ),
                    ),
                    child: WidgetCard(
                        srcAsset: "assets/icons/live-map.svg",
                        title: "Live Map"),
                  ),
                ],
              ),
            ),
            PreventionCard(
              isLight: isLight,
            )
          ],
        ));
  }
}
