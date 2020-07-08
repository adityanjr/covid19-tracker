import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: kPrimaryColor.withOpacity(.07),
    elevation: 0,
    leading: IconButton(
      icon: SvgPicture.asset(
        "assets/icons/menu.svg",
        color: kPrimaryColor,
      ),
      onPressed: () {},
    ),
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
  );
}
