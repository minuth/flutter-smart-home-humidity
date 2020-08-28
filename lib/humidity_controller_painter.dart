import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_home_humidity/utils.dart';

class HumidityControllerPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final centerPoint = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;
    final strokeWidth = 5.0;
    final gradient = LinearGradient(
      colors: [
        Colors.red[100],
        Colors.red[300],
        Colors.purple[300],
        Colors.purple[900],
        Colors.purple[300],
        Colors.red[300],
        Colors.red[100]
        ],
      stops: [
       0.0,
       0.2,
       0.3,
       0.5,
       0.7,
       0.8,
       1 
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      );
    final rect = Rect.fromCenter(center: centerPoint, height: size.height, width: size.width);
    final paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth
    ..shader = gradient.createShader(rect)
    ..color = Colors.red;

    // canvas.drawRect(rect, paint);
    final rect1 = Rect.fromLTRB(0, 0, size.width * 0.4, size.height * 0.2);
    final rect2 = Rect.fromLTRB(0, size.height * 0.3, size.width * 0.4, size.height * 0.5);
    final rect3 = Rect.fromLTRB(size.width * 0.3, size.height * 0.17, size.width * 0.4, size.height * 0.23);
    final path = Path()
    ..moveTo(size.width * 0.4, 0)
    ..lineTo(size.width * 0.4, size.height * 0.1)
    ..arcTo(rect1, Utils.degreeToRadian(0), Utils.degreeToRadian(45), false)
    ..quadraticBezierTo(size.width * 0.25, size.height * 0.23, size.width * 0.4, size.height * 0.28)
    // ..arcTo(rect2, Utils.degreeToRadian(315), Utils.degreeToRadian(45), false)
    // ..quadraticBezierTo(size.width * 0.3, size.height * 0.15, size.width * 0.4, size.height * 0.2)
    // ..arcTo(rect1, Utils.degreeToRadian(0), Utils.degreeToRadian(45), false)
    // ..arcTo(rect3, Utils.degreeToRadian(210), Utils.degreeToRadian(-180),false)
    // ..arcTo(rect2, Utils.degreeToRadian(315), Utils.degreeToRadian(45), false)
    ..lineTo(size.width * 0.4, size.height)
    // ..arcTo(Rect.fromLTRB(size.width * 0.2, top, right, bottom), startAngle, sweepAngle, forceMoveTo)
    ;
    // canvas.drawLine(Offset(size.width * 0.4, 0), Offset(size.width * 0.4, size.height), paint);
    canvas.drawPath(path, paint);
    // canvas.drawRect(rect1, paint);
    // canvas.drawRect(rect2, paint);
    // canvas.drawRect(rect3, paint);
    // canvas.drawArc(rect3, Utils.degreeToRadian(270), Utils.degreeToRadian(-180), false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
  
}