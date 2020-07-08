import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class PreventionCard extends StatelessWidget {
  final String srcAsset;
  final String title;
  const PreventionCard({
    Key key,
    this.srcAsset,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset(
          srcAsset,
          height: SizeConfig.safeBlockVertical * 9,
        ),
        Padding(
          padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: kPrimaryColor,
                fontFamily: "Titillium",
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.safeBlockVertical * 2.2),
          ),
        )
      ],
    );
  }
}
