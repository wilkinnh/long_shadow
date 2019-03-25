import 'package:flutter/material.dart';
import 'package:long_shadow/fullscreen.dart';

void main() => runApp(FlutterSampleApp());

class FlutterSampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Long Shadow Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        body: FullscreenLongShadow(
          text: Text(
            'S',
            style: TextStyle(
              fontSize: 200,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
