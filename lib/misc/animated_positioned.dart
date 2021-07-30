import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedPositionedDemo extends StatefulWidget {
  AnimatedPositionedDemo({Key key}) : super(key: key);
  static String routeName = '/basics/09_animated_positioned';

  @override
  _AnimatedPositionedDemoState createState() => _AnimatedPositionedDemoState();
}

class _AnimatedPositionedDemoState extends State<AnimatedPositionedDemo> {
  double topPosition;
  double leftPosition;

  double randomTopPosition(double top) => Random().nextDouble() * top;
  double randomLeftPosition(double left) => Random().nextDouble() * left;

  @override
  void initState() {
    super.initState();
    topPosition = randomTopPosition(30);
    leftPosition = randomLeftPosition(30);
  }

  _changePosition(double top, double left) {
    setState(() {
      topPosition = randomTopPosition(top);
      leftPosition = randomLeftPosition(left);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appBar = AppBar(
      title: Text('AnimatedPositioned'),
    );
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: Container(
        color: Colors.red,
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            AnimatedPositioned(
              child: InkWell(
                child: Container(
                  color: Colors.orange,
                  alignment: Alignment.center,
                  width: 150,
                  height: 50,
                  child: Text(
                    'Click Me',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () => _changePosition(
                    size.height -
                        (appBar.preferredSize.height + topPadding + 50),
                    size.width - 150),
              ),
              duration: Duration(seconds: 1),
              top: topPosition,
              left: leftPosition,
            )
          ],
        ),
      ),
    );
  }
}
