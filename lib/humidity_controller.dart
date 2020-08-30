import 'package:flutter/material.dart';

import 'humidity_controller_painter.dart';

class HumidityController extends StatefulWidget {
  final int currentCelcius;
  HumidityController(this.currentCelcius);
  @override
  _HumidityControllerState createState() => _HumidityControllerState();
}

class _HumidityControllerState extends State<HumidityController> {
  var _tapPosition = Offset.zero;
  var _dragePosition = Offset.infinite;
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
                  widget.currentCelcius,
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