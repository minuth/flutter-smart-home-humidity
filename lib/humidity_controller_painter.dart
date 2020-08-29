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
    final rect = Rect.fromCenter(
        center: centerPoint, height: size.height, width: size.width);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = gradient.createShader(rect)
      ..color = Colors.red;
    final wavePoint = Utils.valueBetween(dragePosition.dy, size.height * 0.1, size.height * 0.9);
    final circlePath = Path()
      ..reset()
      ..addOval(Rect.fromCircle(
          center: Offset(size.width * 0.44, wavePoint), radius: 30));
    if(circlePath.contains(tapPosition) || validPressed){
      onShouldDraw(true);
    }
    else{
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
    canvas.drawPath(circlePath, paint..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(HumidityControllerPainter oldDelegate) {
    return true;
  }
}
