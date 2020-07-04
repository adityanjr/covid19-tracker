import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class WorldClass extends StatefulWidget {
  @override
  _WorldClassState createState() => _WorldClassState();
}

class _WorldClassState extends State<WorldClass> {
  final String url = " https://corona.lmao.ninja/v2/countries";
  Future<List> datas;
  Future<List> getData() async {
    var response = await Dio().get(url);
    return response.data;
  }

  @override
  void initState() {
    super.initState();
    datas = getData();
  }

  Future showCard(String cases, todayDeath, death, recovered) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Total Cases: $cases"),
                  Text("Today's Death: $cases"),
                  Text("Total Deaths: $cases"),
                  Text("Total Recovered: $cases"),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Affected Countries"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future: datas,
          builder: (BuildContext context, snapShot) {
            if (snapShot.hasData) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.0),
                itemCount: 207,
                itemBuilder: (BuildContext context, index) => SizedBox(
                  height: 50,
                  width: 50,
                  child: GestureDetector(
                    onTap: () => showCard(
                      snapShot.data[index]['cases'].toString(),
                      snapShot.data[index]['todayDeaths'].toString(),
                      snapShot.data[index]['deaths'].toString(),
                      snapShot.data[index]['recovered'].toString(),
                    ),
                    child: Card(
                      child: Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  "Total Cases: ${snapShot.data[index]['cases'].toString()}"),
                              Text(
                                snapShot.data[index]['country'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
