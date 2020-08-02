import 'package:flutter/material.dart';

ThemeData kAppTheme = ThemeData(
  primaryColor: AppColors.skyBlue,
  backgroundColor: AppColors.stone,
  primaryColorDark: AppColors.leather,
);

const String kDefaultFontFamily = "ProductSans";

class TextStyles {
  static final TextStyle kDefaultTextStyle = TextStyle(
    fontFamily: 'ProductSans',
    fontSize: 16,
    letterSpacing: 1.2,
  );

  static final TextStyle kDefaultSkyBlueTextStyle = TextStyle(
      fontFamily: 'ProductSans',
      fontSize: 16,
      letterSpacing: 1.2,
      color: AppColors.skyBlue);

  static final TextStyle kDefaultStoneTextStyle = TextStyle(
      fontFamily: 'ProductSans',
      fontSize: 16,
      letterSpacing: 1.2,
      color: AppColors.stone);

  static final TextStyle h3 = TextStyle(
    fontFamily: 'ProductSansBold',
    fontSize: 16,
    letterSpacing: 1.2,
  );

  static final TextStyle h2 = TextStyle(
    fontFamily: 'ProductSansBold',
    fontSize: 24,
    letterSpacing: 1.2,
  );
}

class AppColors {
  AppColors._();

  static const Color stone = Color.fromRGBO(189, 171, 160, 1);
  static const Color leather = Color.fromRGBO(112, 53, 41, 1);
  static const Color skyBlue = Color.fromRGBO(64, 139, 250, 1);
}
