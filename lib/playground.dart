import 'dart:math';

import 'package:flutter/material.dart';
import 'package:long_shadow/fullscreen.dart';
import 'package:long_shadow/long_shadow.dart';
import 'package:sensors/sensors.dart';

class LongShadowPlayground extends StatefulWidget {
  @override
  _LongShadowPlaygroundState createState() => _LongShadowPlaygroundState();
}

class _LongShadowPlaygroundState extends State<LongShadowPlayground> {
  double _normalizedAngle = -1;
  bool _motionEnabled = true;
  double _fontSize = 100;
  double _shadowOpacity = 0.3;
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController(text: 'S');
    _textController.addListener(() {
      setState(() {});
    });

    gyroscopeEvents.listen((GyroscopeEvent event) {
      if (!_motionEnabled) {
        return;
      }

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: TextField(
            controller: _textController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(prefixText: "Text:"),
          ),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return Scaffold(
                        body: FullscreenLongShadow(
                          text: Text(
                            _textController.text,
                            style: TextStyle(
                              fontSize: _fontSize,
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.black.withOpacity(_shadowOpacity),
                        ),
                      );
                    },
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Hero(
                tag: 'long-shadow',
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  child: Center(
                    child: LongShadow(
                      text: Text(
                        _textController.text,
                        style: TextStyle(
                          fontSize: _fontSize,
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.black.withOpacity(_shadowOpacity),
                      angle: _normalizedAngle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Motion Enabled: "),
              Switch(
                value: _motionEnabled,
                onChanged: (newValue) {
                  setState(() {
                    _motionEnabled = newValue;
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Shadow angle: "),
              Slider(
                value: _normalizedAngle,
                min: -1,
                max: 1,
                onChanged: (newValue) {
                  setState(() {
                    _normalizedAngle = newValue;
                  });
                },
              ),
              Text("${_normalizedAngle.toStringAsFixed(1).toString()}")
            ],
          ),
        ),
        Container(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Font size: "),
              Slider(
                value: _fontSize,
                min: 50,
                max: 150,
                onChanged: (newValue) {
                  setState(() {
                    _fontSize = newValue;
                  });
                },
              ),
              Text("${_fontSize.floor().toString()}")
            ],
          ),
        ),
        Container(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Shadow opacity: "),
              Slider(
                value: _shadowOpacity,
                min: 0,
                max: 1,
                onChanged: (newValue) {
                  setState(() {
                    _shadowOpacity = newValue;
                  });
                },
              ),
              Text("${_shadowOpacity.toStringAsFixed(1).toString()}")
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }
}
