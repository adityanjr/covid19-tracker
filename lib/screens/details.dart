import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/widgets/weeklyChart.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kPrimaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "New Cases",
                        style: TextStyle(fontSize: 20),
                      ),
                      IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 180,
                                child: Text("HOLA"),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        '547 ',
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(color: kPrimaryColor),
                      ),
                      Text(
                        "5.9%",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      SvgPicture.asset(
                        "assets/icons/increase.svg",
                        color: kPrimaryColor,
                      )
                    ],
                  ),
                  Text(
                    "From Health Centre",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: kTextMediumColor,
                        fontSize: 16),
                  ),
                  WeeklyChart(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      PreviousPercentage(
                          percent: 6.43, title: "From Last Week"),
                      PreviousPercentage(
                        percent: 9.43,
                        title: "Recovery Rate",
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PreviousPercentage extends StatelessWidget {
  final double percent;
  final String title;
  const PreviousPercentage({
    Key key,
    this.percent,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: "$percent%\n",
          style: TextStyle(fontSize: 20, color: kPrimaryColor),
        ),
        TextSpan(
          text: "$title",
        ),
      ]),
    );
  }
}
