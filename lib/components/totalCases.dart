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
  var cases1;
  var cases2;
  var cases3;
  var cases4;
  var cases5;
  var cases6;
  var cases7;
  WeeklyCases(
      {this.cases1,
      this.cases2,
      this.cases3,
      this.cases4,
      this.cases5,
      this.cases6,
      this.cases7});

  factory WeeklyCases.fromJson(final json) {
    var date = DateTime.now();
    return WeeklyCases(
        cases1: json["timeline"]["cases"]
            ["${date.month}/${date.day - 1}/${date.year - 2000}"],
        cases2: json["timeline"]["cases"]
            ["${date.month}/${date.day - 2}/${date.year - 2000}"],
        cases3: json["timeline"]["cases"]
            ["${date.month}/${date.day - 3}/${date.year - 2000}"],
        cases4: json["timeline"]["cases"]
            ["${date.month}/${date.day - 3}/${date.year - 2000}"],
        cases5: json["timeline"]["cases"]
            ["${date.month}/${date.day - 3}/${date.year - 2000}"],
        cases6: json["timeline"]["cases"]
            ["${date.month}/${date.day - 3}/${date.year - 2000}"],
        cases7: json["timeline"]["cases"]
            ["${date.month}/${date.day - 3}/${date.year - 2000}"]);
  }
}
