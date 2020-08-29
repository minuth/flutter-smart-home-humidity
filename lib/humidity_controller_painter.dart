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
      ..shader = gradient.createShader(gradientRect)
      ..color = Colors.red;
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
    canvas.drawPath(path, paint);
    canvas.drawCircle(
        controllOffset, controllRadius, paint..style = PaintingStyle.fill);
    final pathMetric = path.computeMetrics().first;
    final n = 50;
    final spaceBetweenLine = pathMetric.length / n;
    for (var i = 0; i < n; i++) {
      final startPosition = pathMetric.getTangentForOffset(spaceBetweenLine * i).position - Offset(10, 0);
      final endPosition = startPosition - Offset(size.width * 0.1, 0);
      canvas.drawLine(startPosition, endPosition, paint);
    }
  }

  @override
  bool shouldRepaint(HumidityControllerPainter oldDelegate) {
    return true;
  }
}
