import 'package:flutter/material.dart';
import 'package:flutter_app/components/totalCases.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://corona.lmao.ninja/v2/all";
  Future<TotalCases> getJsonData() async {
    var response = http.get(Uri.encodeFull(url));
    if (response.statusCode == 200) {
      final convertDataJson = jsonDecode(response.body);
      return TotalCases.fromJson(convertDataJson);
    } else {
      throw Exception("Reload Kr!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
