import 'package:flutter/material.dart';
import 'package:flutter_app/components/totalCases.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://api.rootnet.in/covid19-in/stats/latest";
  Future<TotalCases> getJsonData() async {
    var response = http.get(Uri.encodeFull(url));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid Tracker"),
      ),
      body: FutureBuilder<TotalCases>(
        future: getJsonData(),
        builder: (BuildContext context, Snapshot) {
          if (Snapshot.hasData) {
            final covid = Snapshot.data;
            return Column(
              children: <Widget>[], //access data with "${covid.cases}"
            );
          } else if (Snapshot.hasError) {
            return Text(Snapshot.error.toString());
          } else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}
