import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
class FlashlightEffect extends StatefulWidget {
  @override
  _FlashlightEffectState createState() => _FlashlightEffectState();
}

class _FlashlightEffectState extends State<FlashlightEffect> {
  Offset _lightPosition = Offset(200, 200); // 初始化光圈位置
  double _lightRadius = 100; // 初始化光圈大小

  // 更新光圈位置和大小的方法
  void _updateLight(Offset newPosition, double scale) {
    setState(() {
      _lightPosition = newPosition;
      _lightRadius = 100 * scale; // 根据缩放比例调整光圈大小
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 底层照片
        Positioned.fill(child: Image.asset('assets/bit_im.jpg', fit: BoxFit.cover)),
        // 夜幕遮罩层
        Positioned.fill(child: Container(color: Colors.black.withOpacity(0.9))),
        // 手电筒效果
        GestureDetector(
          onScaleUpdate: (ScaleUpdateDetails details) {
            _updateLight(details.localFocalPoint, details.scale);
          },
          child: CustomPaint(
            painter: FlashlightPainter(lightPosition: _lightPosition, lightRadius: _lightRadius),
            child: Container(
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ],
    );
  }
}

class FlashlightPainter extends CustomPainter {
  final Offset lightPosition;
  final double lightRadius;

  FlashlightPainter({required this.lightPosition, required this.lightRadius});

  @override
  void paint(Canvas canvas, Size size) {

    // 绘制背景
    // canvas.drawRect(
    //     Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = Colors.black.withOpacity(0.2));

    // 使用渐变模拟手电筒效果
    var paint = Paint()
      ..shader = ui.Gradient.radial(
        lightPosition,
        lightRadius,
        [Colors.white.withOpacity(0.2), Colors.black.withOpacity(0.3)],
        [0.0, 1.0],
      );

    canvas.drawCircle(lightPosition, lightRadius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}