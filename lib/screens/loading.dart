import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/HomePage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
          transitionDuration: Duration(milliseconds: 1500),
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

  final spinKit1 = SpinKitPulse(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.blue,
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('COVID-19 TRACKER'),
          Text('v1.0'),
          SizedBox(height: 20),
          Text(
            'fetching data, please wait...\n',
          ),
          spinKit1
        ],
      )),
    );
  }
}
