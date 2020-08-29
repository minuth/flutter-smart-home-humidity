import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_home_humidity/utils.dart';

class HumidityControllerPainter extends CustomPainter {
  final Offset tapPosition;
  final Offset dragePosition;
  final Function(bool shouldDraw) onShouldDraw;
  final bool validPressed;
  HumidityControllerPainter(
      {@required this.tapPosition,
      @required this.dragePosition,
      @required this.validPressed,
      @required this.onShouldDraw});
  @override
  void paint(Canvas canvas, Size size) {
    final centerPoint = Offset(size.width / 2, size.height / 2);
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
      stops: [0.0, 0.2, 0.3, 0.5, 0.7, 0.8, 1.0],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    final gradientRect = Rect.fromCenter(
        center: centerPoint, height: size.height, width: size.width);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = gradient.createShader(gradientRect);
    final wavePoint = Utils.valueBetween(
        dragePosition.dy, size.height * 0.1, size.height * 0.9);
    final controllOffset = Offset(size.width * 0.44, wavePoint);
    final rect = Rect.fromCircle(center: controllOffset, radius: 25);
    double controllRadius;
    if (rect.contains(tapPosition) || validPressed) {
      controllRadius = 30;
      onShouldDraw(true);
    } else {
      controllRadius = 25;
      onShouldDraw(false);
    }
    final path = Path()
      ..moveTo(size.width * 0.4, 0)
      ..lineTo(size.width * 0.4, wavePoint - 65)
      ..quadraticBezierTo(
          size.width * 0.4, wavePoint - 45, size.width * (0.35), wavePoint - 25)
      ..quadraticBezierTo(
          size.width * 0.29, wavePoint, size.width * 0.35, wavePoint + 25)
      ..quadraticBezierTo(
          size.width * 0.4, wavePoint + 45, size.width * 0.4, wavePoint + 75)
      ..lineTo(size.width * 0.4, size.height);

    final path2 = Path()
      ..moveTo(size.width * 0.4, 0)
      ..lineTo(size.width * 0.4, wavePoint - 65)
      ..quadraticBezierTo(
          size.width * 0.4, wavePoint - 45, size.width * (0.35), wavePoint - 25)
      ..quadraticBezierTo(
          size.width * 0.29, wavePoint, size.width * 0.35, wavePoint + 25)
      ..quadraticBezierTo(
          size.width * 0.4, wavePoint + 45, size.width * 0.4, wavePoint + 75)
      ..lineTo(size.width * 0.4, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0)
      ..close();
    paint
    ..color = paint.color.withOpacity(0.15)
    ..style = PaintingStyle.fill;
    canvas.drawPath(path2, paint);
    paint
    ..color = paint.color.withOpacity(1)
    ..style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
    canvas.drawCircle(
        controllOffset, controllRadius, paint..style = PaintingStyle.fill);
    final pathMetric = path.computeMetrics().first;
    final n = 60;
    final spaceBetweenLine = pathMetric.length / n;
    final linePaint = Paint()
    ..strokeWidth = 2
    ..color = Colors.white;
    for (var i = 0; i < n; i++) {
      final startPosition = pathMetric.getTangentForOffset(spaceBetweenLine * i).position - Offset(10, 0);
      final endPosition = startPosition - Offset(i % 6 == 0?size.width * 0.1: size.width * 0.08, 0);
      canvas.drawLine(startPosition, endPosition, linePaint);
    }
    final labelCount = 10;
    final spaceBetweenLabel = size.height * 0.8 /labelCount;
    int startValue = 10;
    final textStyle = ui.TextStyle(color: Colors.purple[900], fontSize: 20, fontWeight: FontWeight.bold);
    for (var i = 0; i <= labelCount; i++) {
      final label = Utils.generateParagraph("${10*startValue--}%", style: textStyle);
      canvas.drawParagraph(label, Offset(10, spaceBetweenLabel*i + (size.height * 0.1) - label.height / 2));
    }
    final selectedPercent = (100 * (wavePoint - (size.height * 0.1)))/(size.height * 0.8);
    final selectedLabel = Utils.generateParagraph("${100 - selectedPercent.toInt()}%",style: ui.TextStyle(color: Colors.purple[900],fontSize: 65, fontWeight: FontWeight.bold));
    canvas.drawParagraph(selectedLabel, Offset(controllOffset.dx + 40, (size.height * 0.5) - selectedLabel.height /2));
  }
  @override
  bool shouldRepaint(HumidityControllerPainter oldDelegate) {
    return true;
  }
}
