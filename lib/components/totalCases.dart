class TotalCases {
  var cases;
  var deaths;
  var recovered;

  TotalCases({this.cases, this.deaths, this.recovered});

  factory TotalCases.fromJson(final json) {
    return TotalCases(
      cases: json["cases"],
      deaths: json["deaths"],
      recovered: json["recovered"],
    );
  }
}
