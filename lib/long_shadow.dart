import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class LongShadow extends StatefulWidget {
  final Text text;
  final Color color;
  final double angle;

  const LongShadow({Key key, this.text, this.color, this.angle}) : super(key: key);

  @override
  _LongShadowState createState() => _LongShadowState();
}

class _LongShadowState extends State<LongShadow> {
  GlobalKey _key = GlobalKey();
  TextPainter _painter;
  ui.Image _mask;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => updateMask());

    super.initState();

    _painter = TextPainter(
      text: TextSpan(
        text: this.widget.text.data,
        style: TextStyle(
          fontSize: this.widget.text.style.fontSize,
          fontWeight: this.widget.text.style.fontWeight,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    _painter.layout();
  }

  @override
  void didUpdateWidget(LongShadow w) {
    super.didUpdateWidget(w);
    updateMask();
  }

  void updateMask() async {
    var cc = _key.currentContext;
    if (cc == null || cc.findRenderObject() == null) {
      return;
    }

    RenderBox box = cc.findRenderObject();
    var image = await _maskImage(context, box.size);
    setState(() {
      _mask = image;
    });
  }

  Future<ui.Image> _maskImage(BuildContext context, Size size) {
    var offset = Offset((size.width - _painter.width) / 2, (size.height - _painter.height) / 2);

    var recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);

    double length = size.height * .75;
    for (double i = 0; i < length; i++) {
      var x = i * (this.widget.angle * -.5);
      _painter.paint(canvas, offset + Offset(x, i));
    }

    return recorder.endRecording().toImage(size.width.toInt(), size.height.toInt());
  }

  @override
  Widget build(BuildContext context) {
    if (_mask == null) {
      return Container(key: _key);
    }
    var w = this.widget;
    return Material(
      color: Colors.transparent,
      key: _key,
      child: Stack(
        children: <Widget>[
          ShaderMask(
            shaderCallback: (_) {
              return ImageShader(_mask, TileMode.clamp, TileMode.clamp, Matrix4.identity().storage);
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [w.color, w.color.withOpacity(0.0), w.color.withOpacity(0.0)],
                  stops: [0, 1.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
          ),
          Center(child: w.text),
        ],
      ),
    );
  }
}
