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
  TextPainter _textPainter;
  ui.Image _maskImage;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => updateMask());

    super.initState();

    _textPainter = TextPainter(
      text: TextSpan(
        text: this.widget.text.data,
        style: TextStyle(
          fontSize: this.widget.text.style.fontSize,
          fontWeight: this.widget.text.style.fontWeight,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    _textPainter.layout();
  }

  @override
  void didUpdateWidget(LongShadow oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateMask();
  }

  void updateMask() async {
    var state = _key.currentContext;
    if (state == null || state.findRenderObject() == null) {
      return;
    }

    RenderBox renderBox = state.findRenderObject();
    var mask = await generateMaskImage(context, renderBox.size);
    setState(() {
      _maskImage = mask;
    });
  }

  Future<ui.Image> generateMaskImage(BuildContext context, Size size) {
    var initialOffset = Offset((size.width - _textPainter.width) / 2, (size.height - _textPainter.height) / 2);

    var recorder = ui.PictureRecorder();
    Canvas shadowMask = Canvas(recorder);

    double length = size.height * .75;
    for (double i = 0; i < length; i++) {
      var xOffset = i * (this.widget.angle * -.5);
      _textPainter.paint(shadowMask, initialOffset + Offset(xOffset, i));
    }

    var picture = recorder.endRecording();
    return picture.toImage(size.width.toInt(), size.height.toInt());
  }

  @override
  Widget build(BuildContext context) {
    if (_maskImage == null) {
      return Container(key: _key);
    }
    return Material(
      color: Colors.transparent,
      key: _key,
      child: Stack(
        children: <Widget>[
          LayoutBuilder(builder: (context, constraints) {
            return ShaderMask(
              shaderCallback: (bounds) {
                return ImageShader(_maskImage, TileMode.clamp, TileMode.clamp, Matrix4.identity().storage);
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [this.widget.color, this.widget.color.withOpacity(0.0), this.widget.color.withOpacity(0.0)],
                    stops: [0, 1.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                ),
              ),
            );
          }),
          Center(child: this.widget.text),
        ],
      ),
    );
  }
}
