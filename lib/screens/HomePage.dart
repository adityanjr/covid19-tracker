import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/totalCases.dart';
import 'package:flutter_app/components/worldCases.dart';
import 'package:flutter_app/widgets/infoCard.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://api.rootnet.in/covid19-in/stats/latest";
  Future<TotalCases> getJsonData() async {
    var response = await http.get(Uri.encodeFull(url));
    if (response.statusCode == 200) {
      final convertDataJson = jsonDecode(response.body);
      return TotalCases.fromJson(convertDataJson);
    } else {
      throw Exception("Reload Kr!");
    }
  }

  @override //this loads data when app opens
  void initState() {
    super.initState();
    this.getJsonData();
  }

  navigateToCountry() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorldClass()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: FutureBuilder<TotalCases>(
        future: getJsonData(),
        builder: (BuildContext context, snapShot) {
          if (snapShot.hasData) {
            final covid = snapShot.data;
            return Container(
              padding:
                  EdgeInsets.only(top: 20, left: 20, bottom: 40, right: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(.03),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
              ),
              child: Wrap(
                runSpacing: 20,
                children: <Widget>[
                  InfoCard(
                    title: "Confirmed Cases",
                    color: Colors.orange,
                    effectedNum: covid.cases,
                  ),
                  InfoCard(
                    title: "Deaths",
                    color: Colors.red,
                    effectedNum: covid.deaths,
                  ),
                ],
              ),
            );
          } else if (snapShot.hasError) {
            return Text(snapShot.error.toString());
          } else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}
