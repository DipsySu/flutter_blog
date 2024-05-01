import 'dart:math';

import 'package:flutter/material.dart';

class JellyAnimation extends StatefulWidget {
  @override
  _JellyAnimationState createState() => _JellyAnimationState();
}

class _JellyAnimationState extends State<JellyAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jelly Animation')),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: JellyPainter(_controller.value),
              child: Container(
                width: 200,
                height: 200,
              ),
            );
          },
        ),
      ),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class JellyPainter extends CustomPainter {
  final double value;

  JellyPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    double midWidth = size.width / 2;
    double midHeight = size.height / 2;
    double maxRadius = min(midWidth, midHeight);

    double offsetX = maxRadius * 0.1 * sin(value * 2 * pi);
    double offsetY = maxRadius * 0.1 * cos(value * 2 * pi);

    final path = Path()
      ..moveTo(midWidth + offsetX, midHeight + offsetY)
      ..arcTo(
        Rect.fromCircle(center: Offset(midWidth, midHeight), radius: maxRadius),
        value * 2 * pi,
        (1 - value) * 2 * pi,
        false,
      );

    final paint = Paint()..color = Colors.blue;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}