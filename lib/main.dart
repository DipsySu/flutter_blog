import 'package:flutter/material.dart';

import '2023-08/2023_08_barrel.dart';

import '2024-02/2024_02_barrel.dart';
import '2023_03/2023_03_barrel.dart';
import '2023_04/2023_04_barrel.dart';
import '2024-05/2024_05_barrel.dart';



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
          child: TiltCard(),
        )
    ),
    );
  }
}




