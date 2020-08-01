import 'package:flutter/material.dart';
import 'package:flutter_app/screens/loading.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() => runApp(Phoenix(child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        primarySwatch: Colors.blue,
        brightness: brightness,
        fontFamily: 'google',
      ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: 'COVID-19 Tracker',
          theme: theme,
          //  don't forget to uncomment the following line.
          home: LoadingScreen(),
          routes: {},
          // home: ChartsScreen(),
        );
      },
    );
  }
}
