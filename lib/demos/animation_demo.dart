import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_demo_animations/common.dart';

class AnimationDemo extends StatefulWidget {
  const AnimationDemo({Key key}) : super(key: key);
  static const String routeName = '/demos/animation_demo';

  @override
  _AnimationDemoState createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo> {
  Ticker _ticker;
  double _count = 0;

  @override
  void initState() {
    super.initState();
    _createTicker();
  }

  _createTicker() {
    _ticker = Ticker((Duration elapsed) {
      print('elapsed: $elapsed');
      print('count: ${_count++}');
      if (_count <= 300) {
        setState(() {});
      }
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker?.dispose();
    super.dispose();
    print('dispose');
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldPage(
      title: "Animation Demo",
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          height: _count,
          width: _count,
          child: FlutterLogo(
            textColor: Colors.red,
          ),
        ),
      ),
    );
  }
}


/*
class AnimationDemo extends StatefulWidget {
  const AnimationDemo({Key key}) : super(key: key);
  static const String routeName = '/demos/animation_demo';

  @override
  _AnimationDemoState createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
    print('dispose');
  }

  Animation<double> _animation;
  AnimationController _animationController;

  _initAnimation() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animation = Tween<double>(begin: 0, end: 300).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldPage(
      title: "Animation Demo",
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          height: _animation.value,
          width: _animation.value,
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
*/

/*
class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: new FlutterLogo(),
      ),
    );
  }
}

class AnimationDemo extends StatefulWidget {
  const AnimationDemo({Key key}) : super(key: key);
  static const String routeName = '/demos/animation_demo';

  @override
  _AnimationDemoState createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
    print('dispose');
  }

  Animation<double> _animation;
  AnimationController _animationController;

  _initAnimation() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animation =
        Tween<double>(begin: 0, end: 300).animate(_animationController);
    _animation.addStatusListener((status) {
      print(status);
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldPage(
      title: "Animation Demo",
      body: AnimatedLogo(
        animation: _animation,
      ),
    );
  }
}
*/

/*
class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  GrowTransition({this.child, this.animation});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Container(
            margin: new EdgeInsets.symmetric(vertical: 10.0),
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}

class AnimationDemo extends StatefulWidget {
  const AnimationDemo({Key key}) : super(key: key);
  static const String routeName = '/demos/animation_demo';

  @override
  _AnimationDemoState createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
    print('dispose');
  }

  Animation<double> _animation;
  AnimationController _animationController;

  _initAnimation() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animation =
        Tween<double>(begin: 0, end: 300).animate(_animationController);
    _animation.addStatusListener((status) {
      print(status);
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldPage(
      title: "Animation Demo",
      body: GrowTransition(
        animation: _animation,
        child: FlutterLogo(),
      ),
    );
  }
}
*/

/*
class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  final Tween<double> _alphaTween = Tween<double>(begin: 0.1, end: 1.0);
  final Tween<double> _sizeTween = Tween<double>(begin: 0.0, end: 300.0);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Opacity(
        opacity: _alphaTween.evaluate(animation),
        child: Container(
          margin: new EdgeInsets.symmetric(vertical: 10.0),
          width: _sizeTween.evaluate(animation),
          height: _sizeTween.evaluate(animation),
          child: new FlutterLogo(),
        ),
      ),
    );
  }
}

class AnimationDemo extends StatefulWidget {
  const AnimationDemo({Key key}) : super(key: key);
  static const String routeName = '/demos/animation_demo';

  @override
  _AnimationDemoState createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
    print('dispose');
  }

  Animation<double> _animation;
  AnimationController _animationController;

  _initAnimation() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);

    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)
          ..addStatusListener((status) {
            print(status);
            if (status == AnimationStatus.completed) {
              _animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _animationController.forward();
            }
          });

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldPage(
      title: "Animation Demo",
      body: AnimatedLogo(
        animation: _animation,
      ),
    );
  }
}
*/