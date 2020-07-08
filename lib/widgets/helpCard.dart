import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class HelpCard extends StatelessWidget {
  const HelpCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.safeBlockHorizontal * 5.5,
            vertical: SizeConfig.safeBlockVertical * 3),
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.4,
                top: SizeConfig.safeBlockHorizontal * 4,
              ),
              height: SizeConfig.safeBlockVertical * 16,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue[200], Colors.blue[600]]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Dial 999 for \nMedical Help!\n",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.white,
                          fontFamily: "Moderne",
                          fontSize: SizeConfig.safeBlockVertical * 2.5)),
                  TextSpan(
                      text: "If any symptoms appear",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.3),
                          fontFamily: "Kayak"))
                ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.safeBlockHorizontal,
                  bottom: SizeConfig.safeBlockVertical),
              child: SvgPicture.asset("assets/icons/nurse.svg"),
            ),
            Positioned(
              top: SizeConfig.safeBlockVertical * 4,
              right: SizeConfig.safeBlockHorizontal * 3,
              child: SvgPicture.asset("assets/icons/virus.svg"),
            )
          ],
        ),
      ),
    );
  }
}
