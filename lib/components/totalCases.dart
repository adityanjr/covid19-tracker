class TotalCases {
  var cases;
  var deaths;
  var recovered;
  var active;

  TotalCases({this.cases, this.deaths, this.recovered, this.active});

  factory TotalCases.fromJson(final json) {
    return TotalCases(
        cases: json["cases"],
        deaths: json["deaths"],
        recovered: json["recovered"],
        active: json["active"]);
  }
}

class WeeklyCases {
  var cases;
  var deaths;
  var recovered;
  var active;

  WeeklyCases({this.cases, this.deaths, this.recovered, this.active});

  factory WeeklyCases.fromJson(final json) {
    return WeeklyCases(
        cases: json["cases"],
        deaths: json["deaths"],
        recovered: json["recovered"],
        active: json["active"]);
  }
}
