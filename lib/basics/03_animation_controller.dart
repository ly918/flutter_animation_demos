import 'package:flutter/material.dart';

class AnimationControllerDemo extends StatefulWidget {
  AnimationControllerDemo({Key key}) : super(key: key);
  static const String routeName = '/basics/animation_controller';

  @override
  _AnimationControllerDemoState createState() =>
      _AnimationControllerDemoState();
}

class _AnimationControllerDemoState extends State<AnimationControllerDemo>
    with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(seconds: 1);
  AnimationController controller;
  int setStateCount = 0;
  int buildCount = 0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: _duration, vsync: this)
      ..addListener(() {
        print('setState {$setStateCount++}');
        setStateCount++;
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build {$buildCount}');
    buildCount++;

    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Controller'),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 200),
            child: Text(
              '${controller.value.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headline3,
              textScaleFactor: 1 + controller.value,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setStateCount = 0;
              buildCount = 0;
              if (controller.status == AnimationStatus.completed) {
                controller.reverse();
              } else {
                controller.forward();
              }
            },
            child: Text('Go!'),
          )
        ],
      )),
    );
  }
}
