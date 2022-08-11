import 'package:flutter/material.dart';

class Scanframe extends StatelessWidget {
  const Scanframe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width * 0.5,
          MediaQuery.of(context).size.width * 0.5),
      painter: ScanFramePainter(),
    );
  }
}

class ScanFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.white;
    //左上框。
    canvas.drawLine(const Offset(0, 0), const Offset(48, 0), paint);
    canvas.drawLine(const Offset(0, 0), const Offset(0, 48), paint);
    //右上框。
    canvas.drawLine(Offset(size.width, 0), Offset(size.width - 48, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, 48), paint);
    //左下框。
    canvas.drawLine(Offset(0, size.height), Offset(0, size.height - 48), paint);
    canvas.drawLine(Offset(0, size.height), Offset(48, size.height), paint);
    //右下框。
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width - 48, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width, size.height - 48), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
