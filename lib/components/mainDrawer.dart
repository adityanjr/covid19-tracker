import 'package:flutter/material.dart';
import '../main.dart';

Drawer buildDrawer(darkThemeEnabled) {
  return Drawer(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("Dark"),
            Switch(
              value: darkThemeEnabled,
              onChanged: bloc.changeTheme,
            ),
          ],
        )
      ],
    ),
  );
}
