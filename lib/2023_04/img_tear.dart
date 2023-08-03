import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TornImageWidget extends StatefulWidget {
  final String imagePath = 'assets/images/img_tear.png';


  @override
  _TornImageWidgetState createState() => _TornImageWidgetState();
}

class _TornImageWidgetState extends State<TornImageWidget> {
   late ui.Image _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {

    final ByteData imageData = await rootBundle.load('assets/bit_im.jpg');
    final Uint8List bytes = Uint8List.view(imageData.buffer);
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    setState(() {
      _image = frameInfo.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_image == null) {
      return Center(child: CircularProgressIndicator());
    }


    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: TornImagePainter(image: _image),
      ),
    );
  }
}

class TornImagePainter extends CustomPainter {
  final ui.Image image;

  TornImagePainter({required this.image});

  @override
  void paint(Canvas canvas, Size size) {
    // 计算图片的缩放比例以适应容器
    double scaleX = size.width / image.width;
    double scaleY = size.height / image.height;
    double scale = scaleX < scaleY ? scaleX : scaleY;

    // 定义撕裂的路径
    Path tornPath = Path();
    tornPath.moveTo(0, 0);
    tornPath.lineTo(size.width, 0);

    // 在此处添加撕裂效果的点
    tornPath.lineTo(size.width, size.height * 0.4);
    tornPath.lineTo(0, size.height * 0.6);

    // 完成路径
    tornPath.lineTo(0, size.height);

    // 裁剪路径
    canvas.clipPath(tornPath);

    // 绘制图片
    canvas.drawImageRect(
      image,
      Rect.fromLTRB(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTRB(0, 0, size.width, size.height),
      Paint(),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

