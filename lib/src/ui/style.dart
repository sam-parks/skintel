import 'package:flutter/material.dart';

ThemeData kAppTheme = ThemeData();

const String kDefaultFontFamily = "ProductSans";

class TextStyles {
  static final TextStyle kDefaultTextStyle = TextStyle(
    fontFamily: 'ProductSans',
    fontSize: 16,
    letterSpacing: 1.2,
  );
}

class AppColors {
  AppColors._();

  static const Color skin0 = Color.fromRGBO(253, 219, 167, 1);
  static const Color skin1 = Color.fromRGBO(224, 182, 132, 1);
  static const Color skin2 = Color.fromRGBO(184, 128, 79, 1);
  static const Color skin3 = Color.fromRGBO(147, 86, 41, 1);
  static const Color skin4 = Color.fromRGBO(75, 53, 43, 1);
}
