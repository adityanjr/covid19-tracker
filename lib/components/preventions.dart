import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/preventionCard.dart';

import '../constants.dart';

class Preventions extends StatelessWidget {
  const Preventions({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.safeBlockHorizontal * 6,
              bottom: SizeConfig.safeBlockHorizontal * 4,
              top: SizeConfig.safeBlockHorizontal * 2),
          child: Text(
            "Preventions >",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Titillium",
                fontSize: SizeConfig.safeBlockVertical * 3),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.safeBlockHorizontal * 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              PreventionCard(
                srcAsset: "assets/icons/hand_wash.svg",
                title: "Wash Hands",
              ),
              PreventionCard(
                srcAsset: "assets/icons/use_mask.svg",
                title: "Use Mask",
              ),
              PreventionCard(
                srcAsset: "assets/icons/Clean_Disinfect.svg",
                title: "Distancing",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
