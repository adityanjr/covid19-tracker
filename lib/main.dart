import 'package:flutter/material.dart';
import 'package:flutter_app/screens/MainDrawer.dart';
import 'screens/HomePage.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DrawerScreen(),
          HomePage(),
        ],
      ),
    );
  }
}
