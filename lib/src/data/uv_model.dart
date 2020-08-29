import 'package:flutter/material.dart';

class UVModel extends ChangeNotifier {
  double _currentUV;
  double _maxUV;

  DateTime _sunrise;
  DateTime _sunset;
  int _maxUVHour;

  double get currentUV => _currentUV;
  double get maxUV => _maxUV;

  DateTime get sunrise => _sunrise;
  DateTime get sunset => _sunset;
  int get maxUVHour => _maxUVHour;

  updateUVData(double currentUV, double maxUV, DateTime sunrise,
      DateTime sunset, int maxUVHour) async {
    _currentUV = currentUV;
    _maxUV = maxUV;
    _sunrise = sunrise;
    _sunset = sunset;
    _maxUVHour = maxUVHour;
    notifyListeners();
  }
}
