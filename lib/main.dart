import 'package:flutter/material.dart';
import 'package:flutter_blog/2023-08/ball_drop.dart';
import 'package:flutter_blog/2023-08/formatter_NUM.dart';
import 'package:flutter_blog/2023-08/jelly.dart';
import 'package:flutter_blog/2023_03/gradient_view.dart';
import 'package:flutter_blog/2023_03/leaf_fall_anim.dart';
import 'package:flutter_blog/2024-02/anim_view.dart';
import 'package:flutter_blog/2024-02/light_view.dart';
import 'package:flutter_blog/2023_04/anim_text.dart';
import 'package:flutter_blog/2024-02/neon_text_view.dart';
import 'package:flutter_blog/card_anim.dart';
import 'package:flutter_blog/func_test_page.dart';
import 'package:test_package/test_package.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      color: Colors.white,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo'),
        ),
        body: Center(
          child: AnimatedConicBorderWidget(),
        )
    ),
    );
  }
}

String formatNumberWithChineseComma(int number) {
  String numStr = number.toString();
  StringBuffer sb = StringBuffer();
  int count = 0;

  for (int i = numStr.length - 1; i >= 0; i--) {
    sb.write(numStr[i]);
    count++;
    if (count == 3 && i != 0) {
      sb.write(',');
      count = 0;
    }
  }

  return sb.toString().split('').reversed.join('');
}


