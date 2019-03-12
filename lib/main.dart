import 'package:flutter/material.dart';
import 'package:long_shadow/playground.dart';

void main() => runApp(FlutterSampleApp());

class FlutterSampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: LongShadowPlayground(),
        ),
      ),
    );
  }
}
