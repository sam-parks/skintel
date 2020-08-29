import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:skintel/config.dart';
import 'package:skintel/src/data/city_model.dart';
import 'package:skintel/src/data/skin_model.dart';
import 'package:skintel/src/locator.dart';
import 'package:skintel/src/services/uv_service.dart';
import 'package:skintel/src/ui/pages/articles_page.dart';
import 'package:skintel/src/ui/pages/uv_page.dart';
import 'package:skintel/src/ui/style.dart';
import 'package:skintel/src/ui/widgets/animated_splash.dart';
import 'package:skintel/src/ui/widgets/skin_color_circle.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class MyApp extends StatefulWidget {
  MyApp(this.config);
  final Config config;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UVService _uvService;

  @override
  void initState() {
    super.initState();
    locator.registerSingleton<Config>(widget.config);
    registerLocatorItems(locator.get<Config>().openUVAPIKey);
    _uvService = locator.get();
    _getUsersLocation();
  }

  _getUsersLocation() async {
    LocationData locationData = await _uvService.getCurrentLocation();
    if (locationData.latitude == null) {
      return;
    }
    CityModel _cityModel = Provider.of<CityModel>(context, listen: false);
    _cityModel.updateUserLoc(
        locationData.latitude.toString(), locationData.longitude.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnimatedSplash(
        imagePath: 'assets/images/sun_loading.gif',
        home: MyHomePage(),
        duration: 6500,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [UVPage(), ArticlesPage()];

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
            floatingActionButton: _selectedIndex == 0
                ? SpeedDial(
                    marginRight: 18,
                    marginBottom: 20,
                    animatedIcon: AnimatedIcons.menu_close,
                    animatedIconTheme: IconThemeData(size: 22.0),
                    closeManually: false,
                    curve: Curves.bounceIn,
                    overlayColor: Colors.black,
                    overlayOpacity: 0.5,
                    onOpen: () => print('OPENING DIAL'),
                    onClose: () => print('DIAL CLOSED'),
                    tooltip: 'Speed Dial',
                    heroTag: 'speed-dial-hero-tag',
                    backgroundColor:
                        determineSkinColor(_skinColorModel.skinColorIndex),
                    foregroundColor: Colors.transparent,
                    elevation: 8.0,
                    shape: CircleBorder(),
                    children: [
                      SpeedDialChild(
                          backgroundColor: AppColors.skin0,
                          onTap: () => _skinColorModel.updateSkinColorIndex(0)),
                      SpeedDialChild(
                        backgroundColor: AppColors.skin1,
                        onTap: () => _skinColorModel.updateSkinColorIndex(1),
                      ),
                      SpeedDialChild(
                        backgroundColor: AppColors.skin2,
                        onTap: () => _skinColorModel.updateSkinColorIndex(2),
                      ),
                      SpeedDialChild(
                        backgroundColor: AppColors.skin3,
                        onTap: () => _skinColorModel.updateSkinColorIndex(3),
                      ),
                      SpeedDialChild(
                        backgroundColor: AppColors.skin4,
                        onTap: () => _skinColorModel.updateSkinColorIndex(4),
                      ),
                    ],
                  )
                : Container(),
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
  int skinColorIndexSelected = 0;

  @override
  Widget build(BuildContext context) {
    SkinColorModel _skinColorModel = Provider.of<SkinColorModel>(context);
    return Scaffold(
      body: Column(
        children: [
          ClipOval(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .5,
              color: determineSkinColor(skinColorIndexSelected),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Skin Tone",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 34,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
            child: Text(
              "Please select a skin tone that best represents you.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
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
              padding: const EdgeInsets.only(bottom: 30),
              width: MediaQuery.of(context).size.width * .7,
              height: 40,
              child: Text("Select skin color"),
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
      return AppColors.skin0;
  }
}
