import 'dart:math';
import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 199, 234, 228)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.4428571);
    path_0.cubicTo(
        size.width * 0.2880571,
        size.height * 0.5070571,
        size.width * 0.1712286,
        size.height * 0.5990286,
        size.width * 0.3981429,
        size.height * 0.6013714);
    path_0.cubicTo(
        size.width * 0.6250286,
        size.height * 0.5953429,
        size.width * 0.8209429,
        size.height * 0.3210571,
        size.width * 0.9975143,
        size.height * 0.3336571);
    path_0.quadraticBezierTo(size.width * 0.9981357, size.height * 0.5031000,
        size.width, size.height * 1.0114286);
    path_0.lineTo(size.width * -0.0057143, size.height * 1.0085714);
    path_0.quadraticBezierTo(size.width * -0.0042857, size.height * 0.8671429,
        0, size.height * 0.4428571);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);

    // Layer 1

    Paint paint_fill_1 = Paint()
      ..color = const Color.fromARGB(255, 174, 130, 245)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_1 = Path();
    path_1.moveTo(size.width, size.height * 0.50);
    path_1.quadraticBezierTo(size.width * 0.7264000, size.height * 0.7306571,
        size.width * 0.5000000, size.height * 0.7342857);
    path_1.quadraticBezierTo(size.width * 0.2656286, size.height * 0.7304000, 0,
        size.height * 0.5000000);
    path_1.lineTo(size.width * -0.0057143, size.height * 1.0057143);
    path_1.lineTo(size.width * 0.9971429, size.height * 1.0057143);
    path_1.lineTo(size.width * 0.9979429, size.height * 0.5010000);
    path_1.close();

    canvas.drawPath(path_1, paint_fill_1);

    // Layer 1

    Paint paint_stroke_1 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_1, paint_stroke_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
