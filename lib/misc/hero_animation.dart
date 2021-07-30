import 'package:flutter/material.dart';
import 'package:flutter_demo_animations/common.dart';

class HeroAnimationDemo extends StatefulWidget {
  const HeroAnimationDemo({Key key}) : super(key: key);
  static const String routeName = '/misc/hero_animation';

  @override
  _HeroAnimationDemoState createState() => _HeroAnimationDemoState();
}

class _HeroAnimationDemoState extends State<HeroAnimationDemo> {
  @override
  Widget build(BuildContext context) {
    return MyScaffoldPage(
      title: 'HeroAnimation',
      body: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HeroPage(),
          ),
        ),
        child: Hero(
          tag: 'hero-page-child',
          child: _createHeroContainer(
            50.0,
            Colors.red,
          ),
        ),
      ),
    );
  }
}

class HeroPage extends StatelessWidget {
  const HeroPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: 'hero-page-child',
          child: _createHeroContainer(
            100.0,
            Colors.white,
          ),
        ),
      ),
    );
  }
}

StatelessWidget _createHeroContainer(double size, Color color) {
  return Container(
    width: size,
    height: size,
    padding: EdgeInsets.all(10.0),
    margin: size < 100.0 ? EdgeInsets.all(10.0) : EdgeInsets.all(0),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
    child: FlutterLogo(),
  );
}
