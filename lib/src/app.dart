import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';
import 'package:skintel/config.dart';
import 'package:skintel/src/locator.dart';
import 'package:skintel/src/ui/pages/articles_page.dart';
import 'package:skintel/src/ui/pages/settings_page.dart';
import 'package:skintel/src/ui/pages/uv_page.dart';

class MyApp extends StatefulWidget {
  MyApp(this.config);
  final Config config;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<dynamic, Widget> returnValueAndHomeScreen = {
    1: MyHomePage(title: 'Flutter Demo Home Page')
  };

  @override
  void initState() {
    super.initState();
    locator.registerSingleton<Config>(widget.config);
    registerLocatorItems(locator.get<Config>().openUVAPIKey);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.yellowAccent,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnimatedSplash(
        imagePath: 'assets/images/sun_loading.gif',
        home: MyHomePage(title: 'Flutter Demo Home Page'),
        customFunction: () => true,
        duration: 6000,
        type: AnimatedSplashType.StaticDuration,
        outputAndHome: returnValueAndHomeScreen,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [UVPage(), ArticlesPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (i) async {
            setState(() {
              _selectedIndex = i;
            });
          },
          items: [
            BottomNavigationBarItem(
                title: Text("UV"), icon: Icon(Icons.wb_sunny)),
            BottomNavigationBarItem(
                title: Text("Articles"), icon: Icon(Icons.article)),
            BottomNavigationBarItem(
                title: Text("Settings"), icon: Icon(Icons.settings)),
          ]),
    );
  }
}
