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
          builder: (BuildContext context, SnapShot) {
            if(SnapShot.hasData){
              return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 10,childAspectRatio: 1.0), itemBuilder: (BuildContext context,index)=>SizedBox(
                height: 50,width: 50,child: GestureDetector(onTap: (){},child: Card(child: Container(),),),
              ))
            }
          },
        ),
      ),
    );
  }
}
