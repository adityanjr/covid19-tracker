import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PreventionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preventions"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(
              left: xMargin(5), right: xMargin(5), bottom: yMargin(5)),
          child: Column(
            children: <Widget>[
              headerTips("Know how COVID-19\nis Spread"),
              Text(
                  "• You can become infected by coming into close contact about 6 feet or two arm lengths with a person who has COVID-19. COVID-19 is primarily spread from person to person.\n• You can become infected from respiratory droplets when an infected person coughs, sneezes, or talks.\n • You may also be able to get it by touching a surface or object that has the virus on it, and then by touching your mouth, nose, or eyes"),
              headerTips("Protect yourself and\nothers from COVID-19"),
              Text(
                  "• There is currently no vaccine to protect against COVID-19. The best way to protect yourself is to avoid being exposed to the virus that causes COVID-19.\n• Stay home as much as possible and avoid close contact with others.\n• Wear a cloth face covering that covers your nose and mouth in public settings.\n• Clean and disinfect frequently touched surfaces.\n• Wash your hands often with soap and water for at least 20 seconds, or use an alcohol based hand sanitizer that contains at least 60% alcohol."),
              headerTips("Practice social\ndistancing"),
              Text(
                  "• Buy groceries and medicine, go to the doctor, and complete banking activities online when possible.\n• If you must go in person, stay at least 6 feet away from others and disinfect items you must touch.\n• Get deliveries and takeout, and limit in-person contact as much as possible."),
              headerTips(
                "Know your risk for\nsevere illness",
              ),
              Text(
                  "• Everyone is at risk of getting COVID-19.\n• Older adults and people of any age who have serious underlying medical conditions may be at higher risk for more severe illness. "),
            ],
          ),
        ),
      ),
    );
  }

  Row headerTips(heading) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(yMargin(1)),
          child: SvgPicture.asset(
            "assets/icons/virus.svg",
            height: yMargin(5),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(yMargin(3)),
          child: Text(
            heading,
            style: headingStyle(),
          ),
        )
      ],
    );
  }

  TextStyle headingStyle() =>
      TextStyle(fontSize: yMargin(3), color: Colors.green[600]);
}
