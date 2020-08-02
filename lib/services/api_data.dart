import '../services/location_data.dart';
import '../services/network_api.dart';

class ApiData {
  Future<dynamic> getVirusData() async {
    NetworkAPI networkAPI = NetworkAPI('https://corona.lmao.ninja/v2/all');
    var virusData = networkAPI.getData();
    print(virusData.toString());
    return virusData;
  }

  Future<dynamic> getLocationVirusData() async {
    MyLocationData location = MyLocationData();
    await location.getLocationData();
    String country = location.country;
    NetworkAPI networkAPI = NetworkAPI(
        'https://corona.lmao.ninja/v2/countries/${country.toLowerCase()}');
    var locationVirusData = networkAPI.getData();
    return locationVirusData;
  }

  Future<dynamic> getCountriesVirusData() async {
    NetworkAPI networkAPI = NetworkAPI(
        'https://corona.lmao.ninja/v2/countries?yesterday=false&sort=cases');
    var countriesVirusData = networkAPI.getData();
    return countriesVirusData;
  }

  Future<dynamic> getCountryHistoricalData(String country) async {
    NetworkAPI networkAPI =
        NetworkAPI('https://corona.lmao.ninja/v2/historical/$country');
    var countryHistoricalData = networkAPI.getData();
    return countryHistoricalData;
  }

  Future<dynamic> getWorldHistoricalData() async {
    NetworkAPI networkAPI =
        NetworkAPI('https://corona.lmao.ninja/v2/historical/all');
    var allHistoricalData = networkAPI.getData();
    return allHistoricalData;
  }

  Future<dynamic> getStatesData() async {
    NetworkAPI networkAPI =
        NetworkAPI('https://api.rootnet.in/covid19-in/stats/latest');
    var statesData = networkAPI.getData();
    return statesData;
  }
}
