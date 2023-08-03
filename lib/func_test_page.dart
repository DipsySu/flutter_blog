import 'dart:ffi';
import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';

import 'package:flutter/material.dart';
import 'package:flutter_blog/2023_03/filter_coefficients.dart';



class FunctionTestPage extends StatelessWidget {

  static int MODEL = 10;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          // define funciton
        },
        child: const Icon(Icons.arrow_back),
      ),
      appBar: AppBar(
        title: const Text('Function Test Page'),
      ),
      body: const Center(
        child: Text('Function Test Page'),
      ),
    );
  }


}
