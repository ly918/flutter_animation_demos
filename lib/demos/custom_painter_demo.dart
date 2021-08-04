import 'dart:math';

import 'package:flutter/material.dart';

class CustomPainterDemo extends StatefulWidget {
  const CustomPainterDemo({Key key}) : super(key: key);
  static const String routeName = '/demos/custom_painter';

  @override
  _CustomPainterDemoState createState() => _CustomPainterDemoState();
}

class _CustomPainterDemoState extends State<CustomPainterDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    _animation = Tween<double>(begin: 0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    ;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Text('Start'),
          onPressed: () {
            _controller.forward();
          }),
      appBar: AppBar(
        title: Text("CustomPainter"),
      ),
      body: Center(
        child: Container(
          child: CustomPaint(
            child: Container(
              width: 300,
              height: 300,
              child: Center(
                child: Text(
                  '${((_animation.value) * 100).toInt()}%',
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
            size: Size(300, 300),
            painter: LoadingPainter(animation: _animation),
          ),
        ),
      ),
    );
  }
}

class LoadingPainter extends CustomPainter {
  final Animation<double> animation;
  LoadingPainter({this.animation}) : super(repaint: animation);
  static const width = 30.0;

  @override
  void paint(Canvas canvas, Size size) {
    final angle = animation.value * pi * 2.0;
    final paintBg = Paint()
      ..color = Colors.grey
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
      Offset(
        size.width * 0.5,
        size.height * 0.5,
      ),
      size.width * 0.5,
      paintBg,
    );

    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.5),
        width: size.width,
        height: size.height,
      ),
      -0.5 * pi,
      angle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
