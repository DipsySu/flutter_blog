import 'package:flutter/material.dart';
import 'package:flutter_blog/2023_03/gradient_view.dart';
import 'package:flutter_blog/2023_03/leaf_fall_anim.dart';
import 'package:flutter_blog/2023_04/anim_text.dart';
import 'package:flutter_blog/func_test_page.dart';
import 'package:test_package/test_package.dart';

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
      home:  SizedBox(
        height: 200,
        width: 200,
        child: Center(
          child: TextButton(
            onPressed: () {
              Snowflake sf = Snowflake(1, 1);
              print(sf.nextId());

            },
            child: Text('点我'),
          )
        )
      )
    );
  }
}


