import 'package:flutter/material.dart';

class NeonTextView extends StatefulWidget {
  const NeonTextView({Key? key}) : super(key: key);

  @override
  _NeonTextViewState createState() => _NeonTextViewState();
}

class _NeonTextViewState extends State<NeonTextView> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 10.0).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'FLUTTER\nNEON',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 40,
        color: Colors.blue,
        shadows: [
          BoxShadow(
            color: Colors.blue.withAlpha(_animation!.value.toInt() * 25),
            blurRadius: _animation!.value,
            spreadRadius: _animation!.value,
          ),
        ],
      ),
    );
  }
}