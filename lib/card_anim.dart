import 'package:flutter/material.dart';

class CardAnim extends StatefulWidget {
  @override
  _CardAnimState createState() => _CardAnimState();
}

class _CardAnimState extends State<CardAnim>
    with SingleTickerProviderStateMixin {
  double top = 0;
  double left = 0;
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 3.14159265).animate(
        CurvedAnimation(parent: _rotationController, curve: WindBlownCurve()))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: testGestureDetector(),
    );
  }

  testGestureDetector(){
    return  Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: GestureDetector(
            onTap: () {
              print("点击了蓝色方块");
              if (_rotationController!.isAnimating) {
                _rotationController!.stop();
              } else {
                _rotationController!.forward(from: 0);
              }
            },
            onPanUpdate: (details) {
              setState(() {
                left += details.delta.dx;
                top += details.delta.dy;
              });
            },
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // perspective
                ..rotateY(_rotationAnimation!.value),
              child: Container(
                color: Colors.blue,
                width: 50,
                height: 50,
              ),
            ),
          ),
        ),


      ],
    );
  }

  Color caughtColor = Colors.grey;
  testDragTarget(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Draggable<Color>(
          data: Colors.blue,
          child: SizedBox(
            width: 100,
            height: 100,
            child: Material(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 3,
              child: Center(
                child: Text('Drag Me'),
              ),
            ),
          ),
          feedback: SizedBox(
            width: 100,
            height: 100,
            child: Material(
              color: Colors.blue.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text('Dragging...'),
              ),
            ),
          ),
        ),
        DragTarget<Color>(
          builder: (BuildContext context, List<Color?> candidateData, List<dynamic> rejectedData) {
            return Container(
              width: 150,
              height: 150,
              color: caughtColor,
              child: Center(
                child: Text('Drop Here!'),
              ),
            );
          },
          onWillAccept: (data) => data == Colors.blue,
          onAccept: (data) {
            setState(() {
              caughtColor = data!;
            });
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    _rotationController!.dispose();
    super.dispose();
  }
}
class WindBlownCurve extends Curve {
  @override
  double transform(double t) {
    if (t < 0.5 / 3) {
      // 0 - 0.5s: 范围从 0 到 0.1，用二次函数模拟慢速增长
      return 0.2 * t / (0.5 / 3);
    } else if (t < 2.5 / 3) {
      // 0.5 - 2.5s: 范围从 0.1 到 0.9，线性增长
      return 0.2 + 0.6 * (t - (0.5 / 3)) / (2 / 3);
    } else {
      // 2.5 - 3s: 范围从 0.9 到 1，用二次函数模拟慢速增长
      return 0.8 + 0.2 * (t - (2.5 / 3)) / (0.5 / 3);
    }
  }
}