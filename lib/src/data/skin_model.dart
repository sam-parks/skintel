import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SkinColorModel extends ChangeNotifier {
  SkinColorModel(this._skinColorIndex, this._skinTypeIndex);

  int _skinColorIndex;
  int _skinTypeIndex;
  int _hoursOutdoors;

  int get skinColorIndex => _skinColorIndex;
  int get skinTypeIndex => _skinTypeIndex;
  int get hoursOutdoors => _hoursOutdoors;

  updateSkinColorIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('skinColorIndex', index);
    _skinColorIndex = index;
    notifyListeners();
  }

  updateSkinTypeIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('skinTypeIndex', index);
    _skinTypeIndex = index;
    notifyListeners();
  }

  updateHoursOutdoors(int hours) {
    _hoursOutdoors = hours;
    notifyListeners();
  }
}
