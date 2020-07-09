import 'package:flutter/material.dart';
import 'package:flutter_app/components/drawerMenu.dart';
import 'package:flutter_app/constants.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue[600], Colors.blue[300]]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.safeBlockVertical * 10,
                bottom: SizeConfig.safeBlockVertical * 10,
                right: SizeConfig.safeBlockHorizontal),
            child: Image.asset("assets/covid_text.png"),
          ),
          Column(
            children: drawerItems
                .map(
                  (e) => Row(
                    children: <Widget>[Icon(e['icon']), Text(e['title'])],
                  ),
                )
                .toList(),
          ),
          Row(
            children: <Widget>[
              Text("Covid Tracker"),
              Container(
                width: 2,
                height: 20,
                color: Colors.white,
              ),
              Text("Copyright © Aditya Singh"),
            ],
          )
        ],
      ),
    );
  }
}
