import 'package:flutter/material.dart';
import 'package:smart_home_humidity/humidity_controller_painter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HumidityController(),
    );
  }
}

class HumidityController extends StatefulWidget {
  @override
  _HumidityControllerState createState() => _HumidityControllerState();
}

class _HumidityControllerState extends State<HumidityController> {
  var _tapPosition = Offset.zero;
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: _screenSize.width,
          height: _screenSize.height,
          color: Colors.white,
          child: GestureDetector(
            child: CustomPaint(
              size: Size.infinite,
              painter: HumidityControllerPainter(_tapPosition),
            ),
            onTapDown: (details) {
              setState(() {
                _tapPosition = details.globalPosition;
              });
            },
            onTapUp: (details) {
              
            },
            onHorizontalDragUpdate: (details) {
              setState(() {
                _tapPosition = details.globalPosition;
              });
            },
          ),
        ),
      ),
    );
  }
}
