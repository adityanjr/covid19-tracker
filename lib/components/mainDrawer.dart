import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/screens/HomePage.dart';
import 'package:flutter_app/screens/about.dart';
import 'package:flutter_app/screens/countries.dart';
import '../main.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(size.width * 0.75, 0);
    path.quadraticBezierTo(
        280, size.height * 0.5, size.width * 0.7, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

Drawer buildDrawer(context, darkThemeEnabled) {
  navigateToCountry() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorldClass()));
  }

  return Drawer(
    elevation: 3,
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            darkThemeEnabled
                ? "assets/covid_white.png"
                : "assets/covid_black.png",
            width: SizeConfig.safeBlockHorizontal * 50,
          ),
          Column(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(darkThemeEnabled)),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.home),
                    SizedBox(
                      width: 10,
                    ),
                    Text("HomePage")
                  ],
                ),
              ),
              FlatButton(
                onPressed: () => navigateToCountry(),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.map),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Countries")
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutPage(),
                      ));
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.info),
                    SizedBox(
                      width: 10,
                    ),
                    Text("About")
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal * 5),
                    child: Text("Dark"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Switch(
                    value: darkThemeEnabled,
                    onChanged: bloc.changeTheme,
                  ),
                ],
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text("Covid Tracker"),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 2,
                height: 25,
                color: Colors.grey,
              ),
              SizedBox(
                width: 5,
              ),
              Text("© Aditya Singh")
            ],
          )
        ],
      ),
    ),
  );
}
