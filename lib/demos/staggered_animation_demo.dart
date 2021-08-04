import 'package:flutter/material.dart';

class StaggeredAnimationDemo extends StatefulWidget {
  const StaggeredAnimationDemo({Key key}) : super(key: key);
  static const String routeName = '/misc/staggered_animation';

  @override
  _StaggeredAnimationDemoState createState() => _StaggeredAnimationDemoState();
}

class _StaggeredAnimationDemoState extends State<StaggeredAnimationDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> opacity;
  Animation<double> width;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<BorderRadius> borderRadius;
  Animation<Color> color;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    opacity = Tween<double>(begin: 0.2, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Interval(0, 0.2)));
    width = Tween<double>(begin: 100, end: 300).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.2, 0.4)));
    height = Tween<double>(begin: 100, end: 300).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.4, 0.6)));
    padding = Tween<EdgeInsets>(
            begin: EdgeInsets.all(30), end: EdgeInsets.all(80))
        .animate(
            CurvedAnimation(parent: _controller, curve: Interval(0.6, 0.8)));
    borderRadius = new BorderRadiusTween(
            begin: new BorderRadius.circular(4.0),
            end: new BorderRadius.circular(75.0))
        .animate(new CurvedAnimation(
            parent: _controller,
            curve: new Interval(0.8, 1.0, curve: Curves.ease)));
    color = ColorTween(begin: Colors.red, end: Colors.blue)
        .animate(CurvedAnimation(parent: _controller, curve: Interval(0, 1)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return new Container(
      padding: padding.value,
      alignment: Alignment.center,
      child: new Opacity(
        opacity: opacity.value,
        child: new Container(
          width: width.value,
          height: height.value,
          decoration: new BoxDecoration(
            color: color.value,
            border: new Border.all(
              color: Colors.indigo[300],
              width: 3.0,
            ),
            borderRadius: borderRadius.value,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('Start'),
        onPressed: () async {
          await _controller.forward().orCancel;
          await _controller.reverse().orCancel;
        },
      ),
      appBar: AppBar(
        title: Text('Staggered Animation'),
      ),
      body: Center(
        child: AnimatedBuilder(
          builder: _buildAnimation,
          animation: _controller,
        ),
      ),
    );
  }
}
