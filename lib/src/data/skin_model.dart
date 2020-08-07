import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SkinColorModel extends ChangeNotifier {
  SkinColorModel(this._skinColorIndex);

  int _skinColorIndex;

  int get skinColorIndex => _skinColorIndex;

  updateSkinColorIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('skinColorIndex', index);
    _skinColorIndex = index;
    notifyListeners();
  }
}
