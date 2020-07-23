import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class HelpCard extends StatelessWidget {
  const HelpCard({
    Key key,
  }) : super(key: key);

  navigateToUrl(urlString) async {
    if (await canLaunch(urlString)) {
      await launch(urlString);
    } else {
      Center(
        child: Text("Error 404"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => navigateToUrl(
            "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public"),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.safeBlockHorizontal * 5.5,
              vertical: SizeConfig.safeBlockVertical * 3.5),
          width: double.infinity,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.4,
                    top: SizeConfig.safeBlockHorizontal * 4,
                  ),
                  height: SizeConfig.safeBlockVertical * 17,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue[200], Colors.blue[600]]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.safeBlockVertical * 0.5),
                        child: Text(
                          "WHO - Advice for Public",
                          style: TextStyle(
                              fontSize: SizeConfig.safeBlockVertical * 3.8,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Yanone"),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 1.5,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.safeBlockHorizontal * 12),
                        child: Text(
                          "Be Aware!",
                          style: TextStyle(
                              fontFamily: "Kayak",
                              color: Colors.white.withOpacity(.5)),
                        ),
                      )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.safeBlockHorizontal,
                    bottom: SizeConfig.safeBlockVertical),
                child: SvgPicture.asset("assets/icons/nurse.svg"),
              ),
              Positioned(
                top: SizeConfig.safeBlockVertical * 15,
                right: SizeConfig.safeBlockHorizontal * 4.5,
                child: SvgPicture.asset("assets/icons/virus.svg"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
