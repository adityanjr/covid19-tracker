import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'lineCharts.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final int effectedNum;
  final Color color;
  const InfoCard({
    Key key,
    this.title,
    this.effectedNum,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth / 2 - 10,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: color.withOpacity(.2), shape: BoxShape.circle),
                      child: SvgPicture.asset(
                        "assets/icons/running.svg",
                        height: 12,
                        width: 12,
                        color: color,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "$effectedNum\n",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "People",
                            style: TextStyle(
                                fontSize: 12, height: 2, color: Colors.black),
                          ),
                        ]),
                      ),
                    ),
                    Expanded(
                      child: LineReportChart(),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
