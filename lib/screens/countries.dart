import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/data/country_virus_data.dart';

import 'charts.dart';

class CountriesInfoScreen extends StatefulWidget {
  static const routeName = '/countries-info-screen';

  final countryVirusData;
  CountriesInfoScreen({this.countryVirusData});
  @override
  CountriesInfoScreenState createState() => CountriesInfoScreenState();
}

class CountriesInfoScreenState extends State<CountriesInfoScreen> {
  CountryVirusData locationData;
  List<CountryVirusData> countriesData = [];
  List<CountryVirusData> countriesForDisplay = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    updateCountriesUI(widget.countryVirusData);
    super.initState();
  }

  void updateCountriesUI(dynamic virusData) {
    setState(() {
      if (virusData == null) {
        locationData = CountryVirusData(
          country: 'none',
          confirmedCases: 0,
          recovered: 0,
          deaths: 0,
        );
        print('error Null data obtained');
        return;
      }
      for (var eachData in virusData) {
        final countryData = CountryVirusData(
          country: eachData['country'] ?? 'None',
          confirmedCases: eachData['cases'] ?? 0,
          recovered: eachData['recovered'] ?? 0,
          deaths: eachData['deaths'] ?? 0,
          flagUrl: eachData['countryInfo']['flag'] ?? ">>",
        );
        countriesData.add(countryData);
      }
      countriesForDisplay = countriesData;
    });
  }

  Widget buildList() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 1.0),
        itemCount: countriesForDisplay.length,
        itemBuilder: (ctx, index) => buildCard(index),
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: 'Search Countries',
          hintText: 'Type India',
        ),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            countriesForDisplay = countriesData.where((c) {
              var cName = c.country.toLowerCase();
              return cName.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  Widget buildCard(int index) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChartsScreen(
            countryName: '${countriesForDisplay[index].country}',
            cases: double.parse('${countriesForDisplay[index].confirmedCases}'),
            deaths: double.parse('${countriesForDisplay[index].deaths}'),
            recovered: double.parse('${countriesForDisplay[index].recovered}'),
          ),
        ),
      ),
      child: Card(
        elevation: 2,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Cases: ${countriesForDisplay[index].confirmedCases}"),
                Container(
                  child: Image.network(countriesForDisplay[index].flagUrl),
                  height: yMargin(5),
                ),
                Text(
                  "${index + 1}.  ${countriesForDisplay[index].country}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontFamily: "Titillium"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("All Countries"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(
                  'Data Source: https://www.worldometers.info/coronavirus/',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
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
