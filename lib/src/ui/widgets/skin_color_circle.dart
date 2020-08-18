import 'package:flutter/material.dart';

class SkinColorCircle extends StatefulWidget {
  SkinColorCircle(
      {Key key,
      this.skinColorIndex,
      this.selected,
      this.updateSkinColorForParent})
      : super(key: key);
  final int skinColorIndex;
  final bool selected;
  final Function updateSkinColorForParent;
  @override
  _SkinColorCircleState createState() => _SkinColorCircleState();
}

class _SkinColorCircleState extends State<SkinColorCircle> {
  double _radius;

  @override
  Widget build(BuildContext context) {
    _radius = widget.selected ? 16.0 : 8.0;
    return GestureDetector(
      onTap: () {
        widget.updateSkinColorForParent();
        setState(() {
          _radius = 16.0;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        child: CircleAvatar(
          radius: _radius,
          // backgroundColor: determineSkinColor(widget.skinColorIndex),
        ),
      ),
    );
  }
}
