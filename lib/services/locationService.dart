import 'dart:html';

import 'package:geocode/geocode.dart';
import 'package:geolocation_flutter/geolocation_flutter..dart';
import 'package:geolocation_flutter/models/models.dart';
import 'package:location/location.dart';

class locationService {
  GeoCode geoCode = GeoCode();
  late double latitude;
  late double longitude;
  late String cityName;

  // LOCATION (LATITUDE LONGITUDE FINDER)
  Future<LocationData> getCurrentLocation() async {
    Location location = Location();
    LocationData locationData;

    if (await location.serviceEnabled() == false) {
      // if service is unavailable
      await location.requestService(); // try to request service again
      if (await location.serviceEnabled() == false) {
        // re-request for service failed
      }
    }

    if (await location.hasPermission() == PermissionStatus.denied) {
      // if no permission
      await location.requestPermission(); // re-request permission
      if (await location.hasPermission() == false) {
        // if re-request for permission failed
      }
    }

    // IF SERVICE IS ENABLED AND PERMISSION GRANTED
    locationData = await location.getLocation();
    return locationData;
  }

  // GEOCODE
  Future<String?> getCurrentCity(double latitude, double longitude) async {
    try {
      Address address = await geoCode.reverseGeocoding(
          latitude: latitude, longitude: longitude);
      return address.city;
    } catch (e) {
      print(e);
    }
  }

  // GEOLOCATION
  Future<void> getCurrentCityName(double latitude, double longitude) async {
    //await getCurrentLocation();
    GeoLocationData data = await getGeoLocationData(
        latLng: GeoLocationLatLng(latitude, longitude));
    print("${latitude} ${longitude}");
    //print(data.country);
    print(data.city);
  }
}

