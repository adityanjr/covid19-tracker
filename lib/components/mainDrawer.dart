import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/screens/HomePage.dart';
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
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
            child: Image.asset(
              darkThemeEnabled
                  ? "assets/covid_white.png"
                  : "assets/covid_black.png",
              width: SizeConfig.safeBlockHorizontal * 50,
            ),
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
                    Text(
                      "HomePage",
                      style: TextStyle(
                          fontFamily: "Titillium",
                          fontSize: SizeConfig.safeBlockVertical * 3),
                    )
                  ],
                ),
              ),
              FlatButton(
                onPressed: () => navigateToCountry(),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.flag),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Countries",
                      style: TextStyle(
                          fontFamily: "Titillium",
                          fontSize: SizeConfig.safeBlockVertical * 3),
                    )
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  showAboutDialog(
                      context: context,
                      applicationIcon: Icon(Icons.flash_on),
                      applicationName: "Covid Tracker",
                      applicationVersion: 'v1.0',
                      applicationLegalese:
                          "This app tracks number of cases of corona across India and other countries.");
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.info),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "About",
                      style: TextStyle(
                          fontFamily: "Titillium",
                          fontSize: SizeConfig.safeBlockVertical * 3),
                    )
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal * 6),
                    child: Text(
                      "Dark",
                      style: TextStyle(
                          fontFamily: "Titillium",
                          fontSize: SizeConfig.safeBlockVertical * 4),
                    ),
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
              Text(
                "Covid Tracker",
                style: TextStyle(
                    fontFamily: "Yanone",
                    fontSize: SizeConfig.blockSizeVertical * 2.5,
                    color: Colors.blue),
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
                style: TextStyle(
                    fontFamily: "Yanone",
                    fontSize: SizeConfig.blockSizeVertical * 2.5),
              )
            ],
          )
        ],
      ),
    ),
  );
}
