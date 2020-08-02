import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/countries.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';

class WorldCard extends StatelessWidget {
  final bool isLight;
  final widget;
  final cases;
  final deaths;
  const WorldCard({Key key, this.widget, this.cases, this.deaths, this.isLight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) =>
                CountriesInfoScreen(
              countryVirusData: widget.countriesData,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeScaleTransition(animation: animation, child: child);
            },
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: xMargin(5), vertical: yMargin(2)),
          width: double.infinity,
          child: Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(
                    left: xMargin(35),
                    top: yMargin(1.5),
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: isLight
                            ? [Colors.grey[100], Colors.grey[300]]
                            : [Colors.grey[600], Colors.grey[900]]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "WorldWide Scenario",
                        style: TextStyle(
                          fontSize: yMargin(2.5),
                          color: isLight
                              ? Colors.black.withOpacity(.5)
                              : Colors.white.withOpacity(.6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: yMargin(1),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: xMargin(7)),
                        child: Text(
                          "Cases: $cases\nDeaths: $deaths",
                          style: TextStyle(
                              fontSize: yMargin(1.8),
                              fontFamily: "Kayak",
                              color: isLight ? Colors.black : Colors.white),
                        ),
                      )
                    ],
                  )),
              Positioned(
                top: yMargin(3),
                left: xMargin(5),
                child: SvgPicture.asset(
                  "assets/icons/globe.svg",
                  height: yMargin(13),
                ),
              ),
              Positioned(
                top: yMargin(7),
                right: xMargin(4.5),
                child: SvgPicture.asset(
                  "assets/icons/patient.svg",
                  height: yMargin(5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
