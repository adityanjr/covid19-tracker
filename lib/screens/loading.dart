import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/screens/HomePage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../services/api_data.dart';

class LoadingScreen extends StatefulWidget {
  static const routeName = '/loading';
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  ApiData apiData = ApiData();

  @override
  void initState() {
    super.initState();
    getAndSetData();
    HomePage();
  }

  void getAndSetData() async {
    var data = await apiData.getVirusData();
    var locationData = await apiData.getLocationVirusData();
    var countriesData = await apiData.getCountriesVirusData();
    var statesData = await apiData.getStatesData();
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => HomePage(
            countriesData: countriesData,
            locationVirusData: locationData,
            virusData: data,
            statesData: statesData,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeScaleTransition(animation: animation, child: child);
          },
        ));
  }

  final spinKit1 = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.red,
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SvgPicture.asset(
            "assets/icons/virus.svg",
            height: yMargin(22),
          ),
          Column(
            children: <Widget>[
              Text(
                'COVID-19 TRACKER',
                style: TextStyle(
                    fontSize: yMargin(4),
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              Text('v1.0.0'),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                'Fetching data, loading...\n',
                style: TextStyle(fontSize: yMargin(3)),
              ),
              spinKit1,
            ],
          ),
        ],
      ),
    );
  }
}
