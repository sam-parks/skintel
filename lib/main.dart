import 'package:flutter/material.dart';
import 'package:skintel/config.dart';
import 'package:skintel/src/app.dart';

void main() {
  runApp(MyApp(_ProdConfig()));
}

class _ProdConfig extends Config {
  @override
  String get openUVAPIKey => "a0a2514b3b7d2ca6dd73ab2a7ed7473a";
}
