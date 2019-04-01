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
        body: FullscreenLongShadow(
          text: Text('S', style: TextStyle(fontSize: 200, color: Colors.white)),
        ),
      ),
    );
  }
}

class FullscreenLongShadow extends StatefulWidget {
  final Text text;
  final Color backgroundColor;

  const FullscreenLongShadow({
    Key key,
    @required this.text,
    this.backgroundColor = Colors.green,
  }) : super(key: key);

  @override
  _FullscreenLongShadowState createState() => _FullscreenLongShadowState();
}

class _FullscreenLongShadowState extends State<FullscreenLongShadow> {
  double _angle = -1;

  @override
  void initState() {
    super.initState();

    gyroscopeEvents.listen((GyroscopeEvent event) {
      if (event.y.abs() < 0.2) {
        return;
      }

      var normalizedSpeed = event.y / 30;
      var newValue = max(min(1, normalizedSpeed + _angle), -1).toDouble();

      setState(() {
        _angle = newValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.widget.backgroundColor,
      child: LongShadow(
        text: this.widget.text,
        color: Colors.black38,
        angle: _angle,
      ),
    );
  }
}
