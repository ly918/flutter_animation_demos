import 'package:flutter/material.dart';

class FadeTransitionDemo extends StatefulWidget {
  FadeTransitionDemo({Key key}) : super(key: key);
  static const String routeName = '/basics/fade_transition';

  @override
  _FadeTransitionDemoState createState() => _FadeTransitionDemoState();
}

class _FadeTransitionDemoState extends State<FadeTransitionDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  CurvedAnimation _curve;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _animation = Tween(begin: 1.0, end: 0.0).animate(_curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    print('value ${_animation.value}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Fade Transition'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeTransition(
              opacity: _animation,
              child: Icon(
                Icons.star,
                color: Colors.amber,
                size: 300,
              ),
            ),
            ElevatedButton(
              onPressed: () => setState(() {
                _controller.animateTo(1.0).then<TickerFuture>(
                    (value) => _controller.animateBack(0.0));
              }),
              child: Text('animate'),
            ),
          ],
        ),
      ),
    );
  }
}
