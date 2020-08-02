import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/data/state_virus_data.dart';

class StatesInfoScreen extends StatefulWidget {
  final stateVirusData;
  StatesInfoScreen({this.stateVirusData});
  @override
  _StatesInfoScreenState createState() => _StatesInfoScreenState();
}

class _StatesInfoScreenState extends State<StatesInfoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    updateStatesUI(widget.stateVirusData['data']['regional']);
    super.initState();
  }

  StateVirusData locationData;
  List<StateVirusData> statesData = [];
  List<StateVirusData> statesForDisplay = [];

  Card buildCard(int index) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(xMargin(3)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "${statesForDisplay[index].stateName}",
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: yMargin(2.5), fontFamily: "Titillium"),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Cases: ${statesForDisplay[index].confirmedCases}",
                      style: TextStyle(color: Colors.red),
                    ),
                    Text(
                      "Recovered: ${statesForDisplay[index].recovered}",
                      style: TextStyle(color: Colors.green),
                    ),
                    Text(
                      "Death: ${statesForDisplay[index].deaths}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateStatesUI(dynamic virusData) {
    setState(() {
      if (virusData == null) {
        locationData = StateVirusData(
          confirmedCases: 0,
          deaths: 0,
          recovered: 0,
          stateName: 'None',
        );
        return;
      }
      for (var eachData in virusData) {
        locationData = StateVirusData(
          confirmedCases: eachData['totalConfirmed'] ?? '',
          deaths: eachData['deaths'] ?? '',
          recovered: eachData['discharged'] ?? '',
          stateName: eachData['loc'] ?? '',
        );
        statesData.add(locationData);
      }
      statesForDisplay = statesData;
    });
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.only(
          left: xMargin(3), right: xMargin(3), bottom: yMargin(2)),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: 'Search States',
          hintText: 'Type Delhi',
        ),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            statesForDisplay = statesData.where((state) {
              var sName = state.stateName.toLowerCase();
              return sName.startsWith(text) || sName.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  Widget buildList() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 1.0),
        itemCount: statesForDisplay.length,
        itemBuilder: (ctx, index) => buildCard(index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("States of INDIA"),
      ),
      body: Padding(
        padding: EdgeInsets.all(yMargin(2)),
        child: Column(
          children: <Widget>[
            _searchBar(),
            buildList(),
          ],
        ),
      ),
    );
  }
}
