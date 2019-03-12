import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:long_shadow/long_shadow.dart';
import 'dart:math';

class FullscreenLongShadow extends StatefulWidget {
  final Text text;
  final Color shadowColor;
  final Color backgroundColor;
  final bool motionEnabled;
  final double angle;

  const FullscreenLongShadow({
    Key key,
    @required this.text,
    this.angle = -1,
    this.shadowColor = Colors.black38,
    this.motionEnabled = true,
    this.backgroundColor = Colors.green,
  }) : super(key: key);

  @override
  _FullscreenLongShadowState createState() => _FullscreenLongShadowState();
}

class _FullscreenLongShadowState extends State<FullscreenLongShadow> {
  double _angle;

  @override
  void initState() {
    super.initState();
    _angle = this.widget.angle;

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Stack(
        children: <Widget>[
          Positioned.fill(
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
          ),
          Positioned.fill(
            child: Center(
              child: Transform.rotate(
                angle: _angle * (pi / 8),
                child: AspectRatio(
                  aspectRatio: .75,
                  child: Container(
//                    decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.yellow,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
