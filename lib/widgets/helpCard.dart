import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HelpCard extends StatelessWidget {
  const HelpCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.4,
                top: 15,
                right: 20),
            height: 125,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.lightBlueAccent, Colors.lightBlue]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "Dial 999 for \nMedical Help!\n",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white)),
                TextSpan(
                    text: "If any symptoms appear",
                    style: TextStyle(color: Colors.white.withOpacity(0.3)))
              ]),
            ),
          ),
          SvgPicture.asset("assets/icons/nurse.svg"),
          Positioned(
            top: 35,
            right: 15,
            child: SvgPicture.asset("assets/icons/virus.svg"),
          )
        ],
      ),
    );
  }
}
