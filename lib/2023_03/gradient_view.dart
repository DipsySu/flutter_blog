import 'dart:math';

import 'package:flutter/material.dart';

class GradientView extends StatefulWidget {
  const GradientView({Key? key}) : super(key: key);

  @override
  State<GradientView> createState() => _GradientViewState();
}

class _GradientViewState extends State<GradientView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _colorfulText(),
      ),
    );
  }

  // LinearGradient
  _linear() {
    return Center(
      child: Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.blue, Colors.black38, Colors.green],
            ),
          ),
          child: Text("LinearGradient_渐变") // 在这里添加其他子组件
          ),
    );
  }

  _radial() {
    return Center(
      child: Container(
          height: 200,
          width: 100,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0.0, 0.0),
              radius: 0.8,
              colors: [Colors.red, Colors.yellow, Colors.green],
              stops: [0.0, 0.5, 1.0],
              tileMode: TileMode.repeated,
            ),
          ),
          child: Text("RadialGradient 渐变")),
    );
  }

  _sweepGradient() {
    return Center(
        child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              gradient: SweepGradient(
                center: Alignment.center,
                startAngle: 0.0,
                endAngle: 2 * pi,
                colors: [Colors.red, Colors.yellow, Colors.green],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            child: Text("SweepGradient 渐变")));
  }

  _colorfulText() {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: [Colors.blue, Colors.red],
          stops: [0.0, 1.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(bounds);
      },
      child: const Text(
        "this is way",
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
