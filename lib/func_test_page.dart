
import 'package:flutter/material.dart';



class FunctionTestPage extends StatelessWidget {

  static int MODEL = 10;


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
