import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:skintel/config.dart';
import 'package:skintel/src/data/article.dart';
import 'package:skintel/src/data/city_model.dart';
import 'package:skintel/src/data/skin_model.dart';
import 'package:skintel/src/locator.dart';
import 'package:skintel/src/services/article_service.dart';
import 'package:skintel/src/services/uv_service.dart';
import 'package:skintel/src/ui/pages/articles_page.dart';
import 'package:skintel/src/ui/pages/settings_page.dart';
import 'package:skintel/src/ui/pages/uv_page.dart';
import 'package:skintel/src/ui/style.dart';
import 'package:skintel/src/ui/widgets/animated_splash.dart';
import 'package:skintel/src/ui/widgets/dialogs.dart';
import 'package:skintel/src/ui/widgets/skin_color_circle.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class MyApp extends StatefulWidget {
  MyApp(this.config);
  final Config config;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CityModel _cityModel;
  ArticlesModel _articlesModel;
  UVService _uvService;
  ArticleService _articleService;

  @override
  void initState() {
    super.initState();
    locator.registerSingleton<Config>(widget.config);
    registerLocatorItems(locator.get<Config>().openUVAPIKey);
    _uvService = locator.get();
    _articleService = locator.get();

    _cityModel = Provider.of<CityModel>(context, listen: false);
    _articlesModel = Provider.of<ArticlesModel>(context, listen: false);
    _getUsersLocation();
    _getArticles();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnimatedSplash(
        imagePath: 'assets/images/sun_loading.gif',
        home: MyHomePage(),
        duration: 5500,
      ),
    );
  }

  _getUsersLocation() async {
    LocationData locationData = await _uvService.getCurrentLocation();
    if (locationData.latitude == null) {
      return;
    }

    _cityModel.updateUserLoc(
        locationData.latitude.toString(), locationData.longitude.toString());
  }

  _getArticles() async {
    List<Article> articles = await _articleService.getArticles();

    int index = Random().nextInt(articles.length - 1);
    Article dailyArticle = articles[index];
    articles.remove(index);

    _articlesModel.updateArticles(articles, dailyArticle);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [UVPage(), ArticlesPage(), SettingsPage()];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("Disclaimer");
      disclaimerDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    SkinColorModel _skinColorModel = Provider.of<SkinColorModel>(context);
    return _skinColorModel.skinColorIndex == null
        ? SkinColorSelectionPage()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: _pages.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: SnakeNavigationBar(
                selectedItemColor: Colors.amber,
                currentIndex: _selectedIndex,
                onPositionChanged: (i) async {
                  setState(() {
                    _selectedIndex = i;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      label: "UV", icon: Icon(Icons.wb_sunny)),
                  BottomNavigationBarItem(
                      label: "Articles", icon: Icon(Icons.article)),
                  BottomNavigationBarItem(
                      label: "Settings", icon: Icon(Icons.settings)),
                ]),
          );
  }
}

class SkinColorSelectionPage extends StatefulWidget {
  SkinColorSelectionPage({Key key}) : super(key: key);

  @override
  _SkinColorSelectionPageState createState() => _SkinColorSelectionPageState();
}

class _SkinColorSelectionPageState extends State<SkinColorSelectionPage> {
  int skinColorIndexSelected;

  @override
  Widget build(BuildContext context) {
    SkinColorModel _skinColorModel = Provider.of<SkinColorModel>(context);
    return Scaffold(
      body: Column(
        children: [
          ClipRRect(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: determineSkinColor(skinColorIndexSelected),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              determineSkinText(skinColorIndexSelected),
              style: TextStyle(
                  fontFamily: kFontFamilyBold,
                  color: Colors.black,
                  fontSize: 34,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
            child: Text(
              determineSkinDescription(skinColorIndexSelected),
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.black, fontFamily: kFontFamilyNormal),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30),
            width: MediaQuery.of(context).size.width * .5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SkinColorCircle(
                  skinColorIndex: 0,
                  selected: skinColorIndexSelected == 0,
                  updateSkinColorForParent: () {
                    setState(() {
                      skinColorIndexSelected = 0;
                    });
                  },
                ),
                SkinColorCircle(
                  skinColorIndex: 1,
                  selected: skinColorIndexSelected == 1,
                  updateSkinColorForParent: () {
                    setState(() {
                      skinColorIndexSelected = 1;
                    });
                  },
                ),
                SkinColorCircle(
                  skinColorIndex: 2,
                  selected: skinColorIndexSelected == 2,
                  updateSkinColorForParent: () {
                    setState(() {
                      skinColorIndexSelected = 2;
                    });
                  },
                ),
                SkinColorCircle(
                  skinColorIndex: 3,
                  selected: skinColorIndexSelected == 3,
                  updateSkinColorForParent: () {
                    setState(() {
                      skinColorIndexSelected = 3;
                    });
                  },
                ),
                SkinColorCircle(
                  skinColorIndex: 4,
                  selected: skinColorIndexSelected == 4,
                  updateSkinColorForParent: () {
                    setState(() {
                      skinColorIndexSelected = 4;
                    });
                  },
                ),
              ],
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              _skinColorModel.updateSkinColorIndex(skinColorIndexSelected);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 30),
              width: MediaQuery.of(context).size.width * .7,
              height: 50,
              child: Center(
                  child: Text(
                "Continue",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: kFontFamilyNormal),
              )),
              decoration: BoxDecoration(
                  color: determineSkinColor(skinColorIndexSelected),
                  borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}

String determineSkinText(int index) {
  switch (index) {
    case 0:
      return "Very Fair";
      break;
    case 1:
      return "Fair";
      break;

    case 2:
      return "Medium";
      break;
    case 3:
      return "Olive";
      break;
    case 4:
      return "Dark";
      break;
    default:
      return "Skin Tone";
  }
}

String determineSkinDescription(int index) {
  switch (index) {
    case 0:
      return "Always burns, never tans";
      break;
    case 1:
      return "Sometimes mild burn, tans uniformly";
      break;

    case 2:
      return "Burns minimally, always tans well";
      break;
    case 3:
      return "Very rarely burns, tans very easily";
      break;
    case 4:
      return "Rarely burns or never burns";
      break;
    default:
      return "Please select a skin tone that best represents you.";
  }
}

Color determineSkinColor(int index) {
  switch (index) {
    case 0:
      return AppColors.skin0;
      break;
    case 1:
      return AppColors.skin1;
      break;

    case 2:
      return AppColors.skin2;
      break;
    case 3:
      return AppColors.skin3;
      break;
    case 4:
      return AppColors.skin4;
      break;
    default:
      return Colors.grey[200];
  }
}
