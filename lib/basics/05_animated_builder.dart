import 'package:flutter/material.dart';

class AnimatedBuilderDemo extends StatefulWidget {
  AnimatedBuilderDemo({Key key}) : super(key: key);
  static const String routeName = '/basics/animated_builder';

  @override
  _AnimatedBuilderDemoState createState() => _AnimatedBuilderDemoState();
}

class _AnimatedBuilderDemoState extends State<AnimatedBuilderDemo>
    with SingleTickerProviderStateMixin {
  static const Color beginColor = Colors.deepOrange;
  static const Color endColor = Colors.deepPurple;
  Duration duration = Duration(milliseconds: 800);
  AnimationController controller;
  Animation<Color> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: duration)
      ..addListener(() {
        setState(() {});
      });
    animation =
        ColorTween(begin: beginColor, end: endColor).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimatedBuilder"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return MaterialButton(
                onPressed: () {
                  if (controller.status == AnimationStatus.completed) {
                    controller.reverse();
                  } else {
                    controller.forward();
                  }
                },
                color: animation.value,
                height: 50,
                minWidth: 100,
                child: child);
          },
          child: Text('change color', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
