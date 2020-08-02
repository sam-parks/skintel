import 'package:flutter/cupertino.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CityModel extends ChangeNotifier {
  CityModel(this._city);

  String _city;
  String _lat;
  String _lng;
  String get city => _city;
  String get lat => _lat;
  String get lng => _lng;

  updateCity(String city, String lat, String lng) async {
    _city = city;
    _lat = lat;
    _lng = lng;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('city', city);
    await prefs.setString('lat', lat);
    await prefs.setString('lng', lng);
    notifyListeners();
  }
}
