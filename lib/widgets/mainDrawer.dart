import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/screens/aboutCovid.dart';
import 'package:flutter_app/screens/countries.dart';
import 'package:flutter_app/screens/states.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

Drawer buildDrawer(context, isLight, widget) {
  return Drawer(
    elevation: 3,
    child: Container(
      color: Colors.grey[300],
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
            child: Image.asset(
              isLight ? "assets/covid_black.png" : "assets/covid_white.png",
              width: xMargin(40),
            ),
          ),
          Column(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.home),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "HomePage",
                      style: TextStyle(fontSize: yMargin(2.5)),
                    )
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 800),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          CountriesInfoScreen(
                        countryVirusData: widget.countriesData,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeScaleTransition(
                            animation: animation, child: child);
                      },
                    ),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.flag),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Countries",
                      style: TextStyle(fontSize: yMargin(2.5)),
                    )
                  ],
                ),
              ),
              FlatButton(
                onPressed: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 800),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        StatesInfoScreen(stateVirusData: widget.statesData),
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
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/icons/india.svg",
                      height: yMargin(4.5),
                      color: isLight ? Colors.black : Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Indian States",
                      style: TextStyle(fontSize: yMargin(2.5)),
                    )
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AboutCovid()));
                },
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/icons/virus.svg",
                      height: yMargin(3.3),
                      color: isLight ? Colors.black : Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "About Covid-19",
                      style: TextStyle(fontSize: yMargin(2.5)),
                    )
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  Phoenix.rebirth(context);
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.refresh),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Refresh Data",
                      style: TextStyle(fontSize: yMargin(2.5)),
                    )
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  showAboutDialog(
                      context: context,
                      applicationIcon: SvgPicture.asset(
                        "assets/icons/virus.svg",
                        height: 40,
                      ),
                      applicationName: "Covid Tracker\n",
                      applicationVersion: 'v1.0.0',
                      applicationLegalese:
                          "This app tracks number of cases of corona across your Location and other countries worldwide.\n\nRepo: github.com/adityanjr");
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.info),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "About",
                      style: TextStyle(fontSize: yMargin(2.5)),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: xMargin(5)),
                child: Text(
                  "Covid Tracker",
                  style: TextStyle(
                      fontFamily: "Kayak",
                      fontSize: yMargin(2),
                      color: Colors.blue),
                ),
              ),
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
              Text(
                "© Aditya Singh",
                style: TextStyle(fontFamily: "Kayak", fontSize: yMargin(2)),
              )
            ],
          )
        ],
      ),
    ),
  );
}
