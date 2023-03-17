import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FallingLeavesAnimation extends StatefulWidget {
  @override
  _FallingLeavesAnimationState createState() => _FallingLeavesAnimationState();
}

class _FallingLeavesAnimationState extends State<FallingLeavesAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final _leaves = List.generate(20, (index) => Leaf());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('樱花落下动画'),
      ),
      body: Stack(
        children: [
          for (final leaf in _leaves)
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final progress = _controller.value;
                final screenWidth = MediaQuery.of(context).size.width;
                final screenHeight = MediaQuery.of(context).size.height;
                final breeze = 50 * sin(2 * pi * progress);
                final leafX = leaf.startX + leaf.speedX * progress + breeze;
                final leafY = leaf.startY +
                    leaf.speedY * progress +
                    0.5 * 9.8 * pow(progress, 2);
                final rotation = leaf.rotation * progress;
                final opacity = (1 - progress) * (1 - progress);
                return Positioned(
                  left: leafX,
                  top: leafY % screenHeight,
                  child: Transform.rotate(
                    angle: rotation,
                    child: Opacity(
                      opacity: opacity,
                      child: SvgPicture.asset(
                        'assets/cherry_blossom.svg',
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class Leaf {
  final double startX;
  final double startY;
  final double speedX;
  final double speedY;
  final double rotation;

  Leaf()
      : startX = Random().nextDouble() * 300,
        startY = -Random().nextDouble() * 300,
        speedX = 20 + Random().nextDouble() * 50,
        speedY = 50 + Random().nextDouble() * 100,
        rotation = Random().nextDouble() * 4 * pi;
}
