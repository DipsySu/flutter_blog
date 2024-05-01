import 'package:flutter/material.dart';
import 'dart:math' as math;

class TiltCard extends StatefulWidget {
  @override
  _TiltCardState createState() => _TiltCardState();
}

class _TiltCardState extends State<TiltCard> {
  double tiltX = 0;
  double tiltY = 0;
  final double maxTilt = 20;

  // This will hold the current gradient depending on the tilt
  Gradient currentGradient = LinearGradient(
    colors: [
      Colors.white,
      Colors.white,
    ],
  );

  void updateGradient(double dx, double dy) {
    final List<Color> colors = [
      Colors.pink.shade300,
      Colors.orange.shade200,
      Colors.yellow.shade200,
      Colors.pink.shade200,
      Colors.purple.shade200,
    ];

    setState(() {
      currentGradient = LinearGradient(
        begin: Alignment.topLeft.add(Alignment(dx * 2, dy * 2)),
        end: Alignment.bottomRight.add(Alignment(dx * 2, dy * 2)),
        colors: colors,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        final dx = (details.localPosition.dx - 150) / 150;
        final dy = (details.localPosition.dy - 100) / 100;
        setState(() {
          tiltX = dy * maxTilt;
          tiltY = -dx * maxTilt;
          updateGradient(dx, dy);
        });
      },
      onPanEnd: (details) {
        setState(() {
          tiltX = 0;
          tiltY = 0;
          currentGradient = LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
            ],
          );
        });
      },
      child: Transform(
        transform: Matrix4.rotationX(tiltX * math.pi / 180)
          ..rotateY(tiltY * math.pi / 180),
        alignment: FractionalOffset.center,
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            gradient: currentGradient,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'this is line code',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}