import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skintel/config.dart';
import 'package:skintel/src/app.dart';
import 'package:skintel/src/data/article.dart';
import 'package:skintel/src/data/city_model.dart';
import 'package:skintel/src/data/skin_model.dart';
import 'package:skintel/src/data/user_model.dart';
import 'package:skintel/src/data/uv_model.dart';
import 'package:syncfusion_flutter_core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String city = await getSavedCity();
  int skinColorIndex = await getSavedSkinColor();
  int skinTypeIndex = await getSavedSkinType() ?? 0;
  SyncfusionLicense.registerLicense(
      'NT8mJyc2IWhia31hfWN9Z2doYmF8YGJ8ampqanNiYmlmamlmanMDHmgjMiE4ICAyEyY1P302NyY=');
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => CityModel(city),
      child: ChangeNotifierProvider(
          create: (BuildContext context) =>
              SkinColorModel(skinColorIndex, skinTypeIndex),
          child: ChangeNotifierProvider(
              create: (BuildContext context) => UVModel(),
              child: ChangeNotifierProvider(
                  create: (context) => ArticlesModel(),
                  child: ChangeNotifierProvider(
                      create: (_) => UserModel(),
                      child: MyApp(_ProdConfig())))))));
}

getSavedCity() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('city') ?? null;
}

getSavedSkinColorIndex() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('skinColorIndex');
}

getSavedSkinColor() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('skinColorIndex') ?? null;
}

getSavedSkinType() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('skinTypeIndex') ?? null;
}

class _ProdConfig extends Config {
  @override
  String get openUVAPIKey => "f2c20f763e6ce7ca714fcade6588ab68";
  @override
  String get placesAPIKey => 'AIzaSyClRg3sNZj5GSbsnOiZ11Qz7-faFrNTKNA';
}
