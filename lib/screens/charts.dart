import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';
import 'package:flutter_app/data/historical_data.dart';
import 'package:pie_chart/pie_chart.dart';

import '../services/api_data.dart';

class ChartsScreen extends StatefulWidget {
  static const routeName = '/charts';
  final String countryName;
  final double cases;
  final double deaths;
  final double recovered;
  ChartsScreen({this.countryName, this.cases, this.deaths, this.recovered});
  @override
  _ChartsScreenState createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  @override
  void initState() {
    getAndSetData();

    _dataMap.putIfAbsent('cases', () => widget.cases);
    _dataMap.putIfAbsent('deaths', () => widget.deaths);
    _dataMap.putIfAbsent('recovered', () => widget.recovered);
    super.initState();
  }

  ApiData apiData = ApiData();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<HistoricalData> countryData = [];
  List<charts.Series<HistoricalData, int>> _lineSeriesData = [];
  Map<String, double> _dataMap = Map();

  Map<String, dynamic> cases = Map();
  Map<String, dynamic> recovered = Map();
  Map<String, dynamic> deaths = Map();

  void getAndSetData() async {
    Map<String, dynamic> histData = widget.countryName == 'world'
        ? await apiData.getWorldHistoricalData()
        : await apiData.getCountryHistoricalData('${widget.countryName}');
    setState(() {
      if (histData == null || widget.cases == null) {
        print('null:data');
        return;
      }

      if (widget.countryName == 'world') {
        cases = histData['cases'];
        deaths = histData['deaths'];
        recovered = histData['recovered'];

        for (var i = 0; i < cases.length; i++) {
          final myData = HistoricalData(
            date: cases.keys.elementAt(i).toString(),
            cases: cases.values.elementAt(i),
            deaths: deaths.values.elementAt(i),
            recovered: recovered.values.elementAt(i),
          );
          countryData.add(myData);
        }
        return;
      }

      cases = histData['timeline']['cases'];
      deaths = histData['timeline']['deaths'];
      recovered = histData['timeline']['recovered'];

      for (var i = 0; i < cases.length; i++) {
        final myData = HistoricalData(
          date: cases.keys.elementAt(i).toString(),
          cases: cases.values.elementAt(i),
          deaths: deaths.values.elementAt(i),
          recovered: recovered.values.elementAt(i),
        );
        countryData.add(myData);
      }

      // for testing
      // for (var data in countryData) {
      //   print('${data.date} : ${data.cases},${data.deaths}');
      // }

      _lineSeriesData.add(charts.Series(
          colorFn: (HistoricalData data, _) =>
              charts.Color.fromHex(code: '#c31432'),
          data: countryData,
          domainFn: (HistoricalData data, _) => data.cases,
          measureFn: (HistoricalData data, _) => data.deaths,
          id: 'DEATHS'));

      _lineSeriesData.add(charts.Series(
          colorFn: (HistoricalData data, _) =>
              charts.Color.fromHex(code: '#0f9b0f'),
          data: countryData,
          domainFn: (HistoricalData data, _) => data.cases,
          measureFn: (HistoricalData data, _) => data.recovered,
          id: 'RECOVERED'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('InfoGraphs'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.pie_chart)),
              Tab(icon: Icon(Icons.show_chart)),
            ],
          ),
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
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      '${widget.countryName}',
                      style: TextStyle(
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent),
                    ),
                    Text(
                      'Cases: ${widget.cases.toStringAsFixed(0)}',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber),
                    ),
                    Text(
                      'Deaths: ${widget.deaths.toStringAsFixed(0)}',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    Text(
                      'Recovered: ${widget.recovered.toStringAsFixed(0)}',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    SizedBox(height: 30),
                    PieChart(
                      dataMap: _dataMap,
                      animationDuration: Duration(milliseconds: 500),
                      chartLegendSpacing: 30.0,
                      chartRadius: MediaQuery.of(context).size.width / 2,
                      showChartValuesInPercentage: true,
                      showChartValues: true,
                      showChartValuesOutside: true,
                      chartValueBackgroundColor: Colors.grey[200],
                      colorList: [Colors.amber, Colors.red, Colors.green],
                      showLegends: true,
                      legendPosition: LegendPosition.right,
                      decimalPlaces: 1,
                      showChartValueLabel: true,
                      initialAngle: 0,
                      chartType: ChartType.disc,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      '${widget.countryName}',
                      style: TextStyle(
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent),
                    ),
                    Expanded(
                      child: charts.LineChart(_lineSeriesData,
                          defaultRenderer: charts.LineRendererConfig(),
                          animate: false,
                          behaviors: [
                            charts.ChartTitle(
                              'Number of Cases',
                              titleStyleSpec: charts.TextStyleSpec(
                                fontFamily: 'google',
                                color: charts.Color.fromHex(code: '#f7aa0f'),
                              ),
                              behaviorPosition: charts.BehaviorPosition.bottom,
                              titleOutsideJustification:
                                  charts.OutsideJustification.middleDrawArea,
                            ),
                            charts.ChartTitle(
                              'Number of Deaths',
                              titleStyleSpec: charts.TextStyleSpec(
                                fontFamily: 'google',
                                color: charts.Color.fromHex(code: '#c31432'),
                              ),
                              behaviorPosition: charts.BehaviorPosition.end,
                              titleOutsideJustification:
                                  charts.OutsideJustification.middleDrawArea,
                            ),
                            charts.ChartTitle(
                              'Number of people recovered',
                              titleStyleSpec: charts.TextStyleSpec(
                                fontFamily: 'google',
                                color: charts.Color.fromHex(code: '#0f9b0f'),
                              ),
                              behaviorPosition: charts.BehaviorPosition.start,
                              titleOutsideJustification:
                                  charts.OutsideJustification.middleDrawArea,
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
