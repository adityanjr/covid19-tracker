import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

AppBar buildAppBar(_scaffoldKey, darkThemeEnabled) {
  return AppBar(
    backgroundColor: kPrimaryColor.withOpacity(.07),
    elevation: 0,
    leading: IconButton(
        icon: SvgPicture.asset(
          "assets/icons/menu.svg",
          color: kPrimaryColor,
        ),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
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
          color: darkThemeEnabled ? Colors.white : Colors.black,
          fontFamily: 'Titillium',
          fontWeight: FontWeight.bold,
          fontSize: SizeConfig.safeBlockVertical * 3),
    ),
    iconTheme: IconThemeData(color: Colors.blue),
  );
}
