import 'package:flutter/material.dart';
import 'package:flutter_demo_animations/common.dart';

class AnimatedContainerDemo extends StatefulWidget {
  AnimatedContainerDemo({Key key}) : super(key: key);
  static String routeName = '/basics/01_animated_container';
  @override
  _AnimatedContainerDemoState createState() => _AnimatedContainerDemoState();
}

class _AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
  Color color;
  double borderRadius;
  double margin;

  @override
  void initState() {
    super.initState();
    color = randomColor();
    borderRadius = randomBorderRadius();
    margin = randomMargin();
  }

  change() {
    setState(() {
      color = randomColor();
      borderRadius = randomBorderRadius();
      margin = randomMargin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimatedContainer"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                width: 200,
                height: 128,
                child: AnimatedContainer(
                  margin: EdgeInsets.all(margin),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  duration: const Duration(milliseconds: 500),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: change,
              child: Text('change'),
            ),
          ],
        ),
      ),
    );
  }
}
