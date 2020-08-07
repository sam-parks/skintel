import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

Widget _home;

String _imagePath;
int _duration;

enum AnimatedSplashType { StaticDuration, BackgroundProcess }

class AnimatedSplash extends StatefulWidget {
  AnimatedSplash({
    @required String imagePath,
    @required Widget home,
    int duration,
  }) {
    assert(duration != null);
    assert(home != null);
    assert(imagePath != null);

    _home = home;
    _duration = duration;
    _imagePath = imagePath;
  }

  @override
  _AnimatedSplashState createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<AnimatedSplash>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    if (_duration < 1000) _duration = 2000;
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCirc));
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.reset();
  }

  navigator(home) {
    Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (BuildContext context) => home));
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: _duration)).then((value) {
      Navigator.of(context).pushReplacement(PageTransition(
        duration: Duration(milliseconds: 1000),
        type: PageTransitionType.fade,
        child: _home,
      ));
    });

    return Scaffold(
        backgroundColor: Color.fromRGBO(251, 227, 183, 1),
        body: FadeTransition(
            opacity: _animation,
            child: Image.asset(
              _imagePath,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            )));
  }
}
