import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:long_shadow/long_shadow.dart';
import 'dart:math';

class FullscreenLongShadow extends StatefulWidget {
  final Text text;
  final Color color;
  final bool motionEnabled;

  const FullscreenLongShadow({Key key, this.text, this.color, this.motionEnabled}) : super(key: key);

  @override
  _FullscreenLongShadowState createState() => _FullscreenLongShadowState();
}

class _FullscreenLongShadowState extends State<FullscreenLongShadow> {
  double _normalizedAngle = -1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Hero(
        tag: 'long-shadow2',
        child: Container(
          color: Colors.green,
          child: SafeArea(
            child: Container(
//              decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.red)),
              child: LongShadow(
                text: this.widget.text,
                color: this.widget.color,
                angle: _normalizedAngle,
              ),
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
      if (!this.widget.motionEnabled) {
        return;
      }

      // dead space
      if (event.y.abs() < 0.2) {
        return;
      }

      // rotation is measured in radians per second
      var normalizedSpeed = event.y / 10;
      var newValue = max(min(1, normalizedSpeed + _normalizedAngle), -1);

      setState(() {
        _normalizedAngle = newValue;
      });
    });
  }
}
