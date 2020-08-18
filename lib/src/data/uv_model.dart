import 'package:flutter/material.dart';

class UVModel extends ChangeNotifier {
  double _currentUV;
  double _maxUV;

  double get currentUV => _currentUV;
  double get maxUV => _maxUV;

  updateUVData(double currentUV, double maxUV) async {
    _currentUV = currentUV;
    _maxUV = maxUV;
    notifyListeners();
  }
}
