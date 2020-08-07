import 'package:flutter/cupertino.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CityModel extends ChangeNotifier {
  CityModel(this._city);

  String _city;
  String _latCity;
  String _lngCity;
  String _latUser;
  String _lngUser;

  String get city => _city;
  String get latCity => _latCity;
  String get lngCity => _lngCity;
  String get latUser => _latUser;
  String get lngUser => _lngUser;

  updateCity(String city, String lat, String lng) async {
    _city = city;
    _latCity = lat;
    _lngCity = lng;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('city', city);
    await prefs.setString('latCity', lat);
    await prefs.setString('lngCity', lng);
    notifyListeners();
  }

  updateUserLoc(String lat, String lng) async {
    _latUser = lat;
    _lngUser = lng;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('latUser', lat);
    await prefs.setString('lngUser', lng);
    notifyListeners();
  }
}
