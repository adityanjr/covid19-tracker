import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/prevention.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';

class PreventionCard extends StatelessWidget {
  final bool isLight;
  const PreventionCard({
    Key key,
    this.isLight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          return Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 600),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  PreventionScreen(),
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
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: xMargin(5), vertical: yMargin(2.5)),
          width: double.infinity,
          child: Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(
                    left: xMargin(33),
                    top: yMargin(2),
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: isLight
                            ? [Colors.grey[300], Colors.green[400]]
                            : [Colors.grey[600], Colors.green[900]]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Preventions",
                        style: TextStyle(
                          fontSize: yMargin(3),
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: yMargin(1),
                      ),
                      Text(
                        "Keep Yourself & Others Safe !!",
                        style: TextStyle(
                            fontFamily: "Kayak",
                            color: Colors.white.withOpacity(.6)),
                      )
                    ],
                  )),
              Positioned(
                top: yMargin(1),
                left: xMargin(5),
                child: SvgPicture.asset(
                  "assets/icons/nurse.svg",
                  height: yMargin(12),
                ),
              ),
              Positioned(
                top: yMargin(2),
                right: xMargin(15),
                child: SvgPicture.asset(
                  "assets/icons/hand-wash.svg",
                  height: yMargin(3.5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
