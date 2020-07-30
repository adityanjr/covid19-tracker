class CountryHistoricalData {
  String country = '';
  String date = '';
  int cases = 0;
  int deaths = 0;
  int recovered = 0;
}

class HistoricalData {
  String date = '';
  int cases = 0;
  int deaths = 0;
  int recovered = 0;

  HistoricalData({this.cases, this.date, this.deaths, this.recovered});
}
