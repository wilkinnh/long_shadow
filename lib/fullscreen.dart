import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:long_shadow/long_shadow.dart';
import 'dart:math';

class FullscreenLongShadow extends StatefulWidget {
  final Text text;
  final Color shadowColor;
  final Color backgroundColor;
  final bool motionEnabled;

  const FullscreenLongShadow(
      {Key key,
      @required this.text,
      this.shadowColor = Colors.black38,
      this.motionEnabled = true,
      this.backgroundColor = Colors.green})
      : super(key: key);

  @override
  _FullscreenLongShadowState createState() => _FullscreenLongShadowState();
}

class _FullscreenLongShadowState extends State<FullscreenLongShadow> {
  double _angle = -1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Hero(
        tag: 'long-shadow2',
        child: Container(
          color: this.widget.backgroundColor,
          child: SafeArea(
            child: LongShadow(
              text: this.widget.text,
              color: this.widget.shadowColor,
              angle: _angle,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    gyroscopeEvents.listen((GyroscopeEvent event) {
      if (!this.widget.motionEnabled || event.y.abs() < 0.2) {
        return;
      }

      // rotation is measured in radians per second
      var normalizedSpeed = event.y / 30;
      var newValue = max(min(1, normalizedSpeed + _angle), -1).toDouble();

      setState(() {
        _angle = newValue;
      });
    });
  }
}
