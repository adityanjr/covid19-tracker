import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class WidgetCard extends StatelessWidget {
  final String srcAsset;
  final String title;
  const WidgetCard({Key key, this.srcAsset, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: <Widget>[
        SvgPicture.asset(
          srcAsset,
          height: yMargin(8),
        ),
        Text(
          title,
          style: TextStyle(
              color: kPrimaryColor,
              fontFamily: "Titillium",
              fontSize: yMargin(2)),
        )
      ],
    );
  }
}
