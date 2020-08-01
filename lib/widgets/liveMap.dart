import 'package:flutter/material.dart';
import 'package:flutter_app/screens/liveMap.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';

class LiveMapCard extends StatelessWidget {
  final int index;
  const LiveMapCard({
    Key key,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MapsScreen(
              index: index,
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: xMargin(5), vertical: yMargin(3)),
          width: double.infinity,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(
                    left: xMargin(38),
                    top: yMargin(3),
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue[200], Colors.blue[600]]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Live Map Tracker",
                        style: TextStyle(
                            fontSize: yMargin(4.5),
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Yanone"),
                      ),
                      SizedBox(
                        height: yMargin(1.5),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: xMargin(8)),
                        child: Text(
                          "Better Insights!",
                          style: TextStyle(
                              fontFamily: "Kayak",
                              color: Colors.white.withOpacity(.5)),
                        ),
                      )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(bottom: yMargin(1)),
                child: SvgPicture.asset("assets/icons/nurse.svg"),
              ),
              Positioned(
                top: yMargin(9),
                right: xMargin(4.5),
                child: SvgPicture.asset("assets/icons/virus.svg"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
