import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:location/location.dart' hide LocationAccuracy;
import 'dart:io';

class MyLocationData {
  double latitude = 0.0;
  double longitude = 0.0;
  String country = '';

  Future<void> getLocationData() async {
    try {
      // requesting location
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

      //* Many More to do, Contribution required
      country == 'United States' ? country = 'USA' : country = country;
      country == 'United Kingdom' ? country = 'UK' : country = country;
      print(country);
    } catch (e) {
      // return 'Error in getting info of your country';
      print(e.toString());
    }
  }
}
