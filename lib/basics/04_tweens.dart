import 'package:flutter/material.dart';

class TweenDemo extends StatefulWidget {
  TweenDemo({Key key}) : super(key: key);
  static const String routeName = '/basics/tweens';

  @override
  _TweenDemoState createState() => _TweenDemoState();
}

class _TweenDemoState extends State<TweenDemo>
    with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(seconds: 1);
  static const double accountBalance = 1000000;
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: _duration)
      ..addListener(() {
        setState(() {});
      });
    animation = Tween(begin: 0.0, end: accountBalance).animate(controller);
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
        title: Text('Animation Controller'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              child: Text('\$${animation.value.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headline6),
              constraints: BoxConstraints(maxWidth: 200),
            ),
            ElevatedButton(
                onPressed: () {
                  if (controller.status == AnimationStatus.completed) {
                    controller.reverse();
                  } else {
                    controller.forward();
                  }
                },
                child: Text(
                  controller.status == AnimationStatus.completed
                      ? 'Buy a Mansion'
                      : 'Win Lottery',
                )),
          ],
        ),
      ),
    );
  }
}
