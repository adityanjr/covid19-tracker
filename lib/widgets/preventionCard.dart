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
          height: 60,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: kPrimaryColor),
          ),
        )
      ],
    );
  }
}
