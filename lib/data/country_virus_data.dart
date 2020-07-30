class CountryVirusData {
  String country = '';
  String flagUrl = '';
  int confirmedCases = 0;
  int deaths = 0;
  int recovered = 0;
  int active = 0;

  CountryVirusData(
      {this.confirmedCases,
      this.country,
      this.deaths,
      this.flagUrl,
      this.recovered,
      this.active});
}
