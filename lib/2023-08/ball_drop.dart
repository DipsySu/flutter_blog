import 'package:flutter/material.dart';

class BallDropScreen extends StatefulWidget {
  @override
  _BallDropScreenState createState() => _BallDropScreenState();
}

class _BallDropScreenState extends State<BallDropScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double ballY = 0;  // 球的垂直位置
  double ballVelocity = 0;  // 球的速度
  double gravity = 0.5;  // 重力
  double bounceFactor = -0.7;  // 反弹系数

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _controller.addListener(() {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      double screenHeight = height - 80;
      double ballSize = 50;  // 小球的大小

      ballVelocity += gravity;  // 加速度
      ballY += ballVelocity;

      // 如果球碰到屏幕底部
      if (ballY + ballSize > screenHeight) {
        ballY = screenHeight - ballSize;
        ballVelocity *= bounceFactor;  // 反弹
      }

      setState(() {});

      if (ballY + ballSize >= screenHeight && ballVelocity.abs() < 1) {
        _controller.stop();
      } else {
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 50,
            top: ballY,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}