import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class TextPaint {
  final String text;
  final TextStyle textStyle;

  TextPaint({required this.text, required this.textStyle});

  void paint(Canvas canvas, Offset offset) {
    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: double.infinity);
    textPainter.paint(canvas, offset);
  }
}
class TornTextPainter extends CustomPainter {
  final TextPaint textPaint;

  TornTextPainter({required this.textPaint});

  @override
  void paint(Canvas canvas, Size size) {
    final text = textPaint.text;
    final textStyle = textPaint.textStyle;

    // 分割文本
    final splitText = text.split('');

    double xOffset = 0;
    for (final part in splitText) {
      final textSpan = TextSpan(text: part, style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(minWidth: 0, maxWidth: double.infinity);
      final offset = Offset(xOffset, Random().nextDouble() * 5);
      textPainter.paint(canvas, offset);
      xOffset += textPainter.width;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}




class NeonText extends StatefulWidget {
  final String text;

  NeonText({required this.text});

  @override
  _NeonTextState createState() => _NeonTextState();
}

class _NeonTextState extends State<NeonText> {
  bool _isGlowing = true;
  bool _isFlickering = false;
  late Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _isGlowing = !_isGlowing;
        _isFlickering = !_isFlickering;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AnimatedDefaultTextStyle(
      duration: Duration(milliseconds: 500),
      style: _isGlowing
          ? textTheme.headline4!.copyWith(color: Colors.cyan.shade200)
          : textTheme.headline4!.copyWith(color: Colors.cyan.shade900),
      child: Transform.translate(
        offset: _isFlickering ? Offset(Random().nextDouble() * 2 - 1, Random().nextDouble() * 2 - 1) : Offset(0, 0),
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
