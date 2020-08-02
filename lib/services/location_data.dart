import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:location/location.dart' hide LocationAccuracy;
import 'dart:io';

class MyLocationData {
  double latitude = 0.0;
  double longitude = 0.0;
  String country = 'India';

  Future<void> getLocationData() async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        Position position = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        latitude = position.latitude;
        longitude = position.longitude;
      } else if (kIsWeb) {
        Location location = Location();

        bool _serviceEnabled;
        PermissionStatus _permissionGranted;
        LocationData _locationData;

        _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          if (!_serviceEnabled) {
            return;
          }
        }
        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            return;
          }
        }

        _locationData = await location.getLocation();

        latitude = _locationData.latitude;
        longitude = _locationData.longitude;
      }

      List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
          latitude, longitude,
          localeIdentifier: 'en_US');
      country = placemark[0].country;

      country == 'United States' ? country = 'USA' : country = country;
      country == 'United Kingdom' ? country = 'UK' : country = country;
      country == 'India' ? country = 'IND' : country = country;
      country == 'Bangladesh' ? country = 'BGD' : country = country;
      country == 'Brazil' ? country = 'BRA' : country = country;
      country == 'Canada' ? country = 'CAN' : country = country;
      country == 'China' ? country = 'CHN' : country = country;
      country == 'France' ? country = 'FRA' : country = country;
      country == 'Germany' ? country = 'DEU' : country = country;
      country == 'Italy' ? country = 'ITA' : country = country;
      country == 'Nepal' ? country = 'NPL' : country = country;
      country == 'Pakistan' ? country = 'PAK' : country = country;
      country == 'Singapore' ? country = 'SGP' : country = country;

      print(country);
    } catch (e) {
      print(e.toString());
    }
  }
}
