import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedSwitcherDemo extends StatefulWidget {
  AnimatedSwitcherDemo({Key key}) : super(key: key);
  static String routeName = '/basics/10_animated_switcher';

  @override
  _AnimatedSwitcherDemoState createState() => _AnimatedSwitcherDemoState();
}

class _AnimatedSwitcherDemoState extends State<AnimatedSwitcherDemo> {
  Color randomColor() => Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
  Widget randomContainer(int keyCount) => Container(
        key: ValueKey<int>(keyCount),
        height: Random().nextDouble() * 200,
        width: Random().nextDouble() * 200,
        decoration: BoxDecoration(
          color: randomColor(),
          borderRadius: BorderRadius.circular(Random().nextDouble() * 100),
          border: Border.all(
            color: randomColor(),
            width: Random().nextDouble() * 5,
          ),
        ),
      );

  Widget container;
  int keyCount;

  @override
  void initState() {
    super.initState();
    keyCount = 0;
    container = randomContainer(keyCount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('Change'),
        onPressed: () => setState(
          () => container = randomContainer(++keyCount),
        ),
      ),
      appBar: AppBar(
        title: Text('AnimatedSwitcher'),
      ),
      body: Center(
        child: AnimatedSwitcher(
          duration: Duration(seconds: 1),
          child: container,
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
        ),
      ),
    );
  }
}
