import 'package:flutter/material.dart';
import 'package:long_shadow/long_shadow.dart';
import 'package:sensors/sensors.dart';
import 'dart:math';

void main() => runApp(FlutterSampleApp());

class FlutterSampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        body: FullscreenLongShadow(),
      ),
    );
  }
}

class FullscreenLongShadow extends StatefulWidget {
  @override
  _FullscreenLongShadowState createState() => _FullscreenLongShadowState();
}

class _FullscreenLongShadowState extends State<FullscreenLongShadow> {
  double _angle = -1;

  @override
  void initState() {
    super.initState();

    gyroscopeEvents.listen((GyroscopeEvent e) {
      if (e.y.abs() < 0.2) {
        return;
      }

      var speed = e.y / 30;
      var newValue = max(min(1, speed + _angle), -1).toDouble();

      setState(() {
        _angle = newValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: LongShadow(
        text: Text('S', style: TextStyle(fontSize: 200, color: Colors.white)),
        color: Colors.black38,
        angle: _angle,
      ),
    );
  }
}
