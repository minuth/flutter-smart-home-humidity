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
  var _dragePosition = Offset(0, 100);
  var _shouldDraw = false;
  var _validPressed = false;
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
              painter: HumidityControllerPainter(
                  tapPosition: _tapPosition,
                  dragePosition: _dragePosition,
                  validPressed: _validPressed,
                  onShouldDraw: (bool shouldDraw) {
                    _shouldDraw = shouldDraw;
                  }),
            ),
            onTapDown: (details) {
              setState(() {
                if(_shouldDraw){
                   _validPressed = true;
                }
                _tapPosition = details.localPosition;
              });
            },
            onTapUp: (detail) {
               setState(() {
                 _tapPosition = Offset.zero;
                _validPressed = false;
              });
            },
            onVerticalDragStart: (details) {
              setState(() {
                if(_shouldDraw){
                   _validPressed = true;
                }
                _tapPosition = details.localPosition;
              });
            },
            onVerticalDragEnd: (details) {
               setState(() {
                  _tapPosition = Offset.zero;
                _validPressed = false;
              });
            },
            onVerticalDragUpdate: (details) {
              print(_shouldDraw);
              setState(() {
                if (_shouldDraw) {
                  _validPressed = true;
                  _dragePosition = details.localPosition;
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
