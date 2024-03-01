import 'package:flutter/material.dart';
import 'dart:math' as math;
class AnimatedConicBorderWidget extends StatefulWidget {
  @override
  _AnimatedConicBorderWidgetState createState() => _AnimatedConicBorderWidgetState();
}

class _AnimatedConicBorderWidgetState extends State<AnimatedConicBorderWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        // 使用_value确保动画循环无缝连接
        double _value = _controller.value;
        // 调整stops参数，使动画在循环中平滑过渡
        double start = (_value - 0.1).clamp(0.0, 1.0);
        double middle = _value;
        double end = (_value + 0.1).clamp(0.0, 1.0);

        return CustomPaint(
          painter: AnimatedConicBorderPainter(start, middle, end),
          child: Container(
            width: 400,
            height: 300,
          ),
        );
      },
    );
  }
}

class AnimatedConicBorderPainter extends CustomPainter {
  final double start;
  final double middle;
  final double end;

  AnimatedConicBorderPainter(this.start, this.middle, this.end);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final gradient = SweepGradient(
      startAngle: 0.0,
      endAngle: math.pi * 2,
      colors: [
        Colors.transparent,
        Colors.blue,
        Colors.transparent,
      ],
      // 通过动态调整stops，确保动画的无缝循环
      stops: [start, middle, end],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(10)));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}