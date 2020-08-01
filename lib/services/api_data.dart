import '../services/location_data.dart';
import '../services/network_api.dart';

class ApiData {
  Future<dynamic> getVirusData() async {
    //fetching data from API
    NetworkAPI networkAPI = NetworkAPI('https://corona.lmao.ninja/v2/all');
    var virusData = networkAPI.getData();
    print(virusData.toString());
    return virusData;
  }

  Future<dynamic> getLocationVirusData() async {
    //getting location
    MyLocationData location = MyLocationData();
    await location.getLocationData();
    String country = location.country;
    //fetching data from API
    NetworkAPI networkAPI = NetworkAPI(
        'https://corona.lmao.ninja/v2/countries/${country.toLowerCase()}');
    var locationVirusData = networkAPI.getData();
    // print(locationVirusData.toString());
    return locationVirusData;
  }

  Future<dynamic> getCountriesVirusData() async {
    //fetching data from API
    NetworkAPI networkAPI = NetworkAPI(
        'https://corona.lmao.ninja/v2/countries?yesterday=false&sort=cases');
    var countriesVirusData = networkAPI.getData();
    // print(countriesVirusData.toString());
    return countriesVirusData;
  }

  Future<dynamic> getCountryHistoricalData(String country) async {
    //fetching data from API
    NetworkAPI networkAPI =
        NetworkAPI('https://corona.lmao.ninja/v2/historical/$country');
    var indiaHistoricalData = networkAPI.getData();
    // print(indiaHistoricalData.toString());
    return indiaHistoricalData;
  }

  Future<dynamic> getWorldHistoricalData() async {
    //fetching data from API
    NetworkAPI networkAPI =
        NetworkAPI('https://corona.lmao.ninja/v2/historical/all');
    var allHistoricalData = networkAPI.getData();
    // print(allHistoricalData.toString());
    return allHistoricalData;
  }

  Future<dynamic> getStatesData() async {
    //fetching data from API
    NetworkAPI networkAPI =
        NetworkAPI('https://api.rootnet.in/covid19-in/stats/latest');
    var allHistoricalData = networkAPI.getData();
    // print(allHistoricalData.toString());
    return allHistoricalData;
  }
}
