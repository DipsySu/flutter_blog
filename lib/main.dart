import 'package:flutter/material.dart';
import 'package:flutter_blog/2023_03/gradient_view.dart';
import 'package:flutter_blog/2023_03/leaf_fall_anim.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  FallingLeavesAnimation()
    );
  }
}

