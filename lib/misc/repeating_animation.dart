import 'package:flutter/material.dart';

class RepeatingAnimationDemo extends StatefulWidget {
  RepeatingAnimationDemo({Key key}) : super(key: key);
  static String routeName = '/misc/repeating_animation';

  @override
  _RepeatingAnimationDemoState createState() => _RepeatingAnimationDemoState();
}

class _RepeatingAnimationDemoState extends State<RepeatingAnimationDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<BorderRadius> _borderRadius;
  Animation<Color> _color;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this)
          ..repeat(reverse: true);
    _borderRadius = BorderRadiusTween(
            begin: BorderRadius.circular(100.0),
            end: BorderRadius.circular(0.0))
        .animate(_controller);
    _color =
        ColorTween(begin: Colors.red, end: Colors.blue).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RepeatAnimation"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _borderRadius,
          builder: (context, child) {
            return Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: _color.value,
                borderRadius: _borderRadius.value,
              ),
            );
          },
        ),
      ),
    );
  }
}
