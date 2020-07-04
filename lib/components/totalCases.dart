class TotalCases {
  var cases;
  var deaths;
  var recovered;

  TotalCases({this.cases, this.deaths, this.recovered});

  factory TotalCases.fromJson(final json) {
    return TotalCases(
      cases: json["data"]["summary"]["total"],
      deaths: json["data"]["summary"]["deaths"],
      recovered: json["data"]["summary"]["discharged"],
    );
  }
}
