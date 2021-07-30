import 'package:flutter/material.dart';
import 'package:flutter_demo_animations/basics/01_animation_container.dart';
import 'package:flutter_demo_animations/basics/02_page_route_builder.dart';
import 'package:flutter_demo_animations/basics/03_animation_controller.dart';
import 'package:flutter_demo_animations/basics/04_tweens.dart';
import 'package:flutter_demo_animations/basics/05_animated_builder.dart';
import 'package:flutter_demo_animations/basics/06_custom_tween.dart';
import 'package:flutter_demo_animations/basics/07_tween_sequence.dart';
import 'package:flutter_demo_animations/basics/08_fade_transition.dart';
import 'package:flutter_demo_animations/demos/shopping_cart/shopping_cart.dart';
import 'package:flutter_demo_animations/misc/animated_positioned.dart';
import 'package:flutter_demo_animations/misc/animated_switcher.dart';
import 'package:flutter_demo_animations/misc/animted_list.dart';
import 'package:flutter_demo_animations/misc/card_swipe.dart';
import 'package:flutter_demo_animations/misc/carousel.dart';
import 'package:flutter_demo_animations/misc/curved_animation.dart';
import 'package:flutter_demo_animations/misc/expand_card.dart';
import 'package:flutter_demo_animations/misc/focus_images.dart';
import 'package:flutter_demo_animations/demos/gif_animation.dart';
import 'package:flutter_demo_animations/misc/hero_animation.dart';
import 'package:flutter_demo_animations/demos/json_animation.dart';
import 'package:flutter_demo_animations/misc/physics_card_drag.dart';
import 'package:flutter_demo_animations/misc/repeating_animation.dart';

void main() {
  runApp(MyApp());
}

class Demo {
  final String name;
  final String route;
  final WidgetBuilder builder;

  const Demo({
    this.name,
    this.route,
    this.builder,
  });
}

final String rootRouteName = '/';

final basicDemos = [
  Demo(
    name: 'AnimatedContainer',
    route: AnimatedContainerDemo.routeName,
    builder: (BuildContext context) => AnimatedContainerDemo(),
  ),
  Demo(
    name: 'PageRouteBuilder',
    route: PageRouteBuilderDemo.routeName,
    builder: (BuildContext context) => PageRouteBuilderDemo(),
  ),
  Demo(
    name: 'AnimationController',
    route: AnimationControllerDemo.routeName,
    builder: (BuildContext context) => AnimationControllerDemo(),
  ),
  Demo(
    name: 'Tween',
    route: TweenDemo.routeName,
    builder: (BuildContext context) => TweenDemo(),
  ),
  Demo(
    name: 'AnimatedBuilder',
    route: AnimatedBuilderDemo.routeName,
    builder: (BuildContext context) => AnimatedBuilderDemo(),
  ),
  Demo(
    name: 'CustomTween',
    route: CustomTweenDemo.routeName,
    builder: (BuildContext context) => CustomTweenDemo(),
  ),
  Demo(
    name: 'TweenSequence',
    route: TweenSequenceDemo.routeName,
    builder: (BuildContext context) => TweenSequenceDemo(),
  ),
  Demo(
    name: 'FadeTransition',
    route: FadeTransitionDemo.routeName,
    builder: (BuildContext context) => FadeTransitionDemo(),
  ),
];

final miscDemos = [
  Demo(
    name: 'AnimatedList',
    route: AnimatedListDemo.routeName,
    builder: (BuildContext context) => AnimatedListDemo(),
  ),
  Demo(
    name: 'AnimatedPositioned',
    route: AnimatedPositionedDemo.routeName,
    builder: (BuildContext context) => AnimatedPositionedDemo(),
  ),
  Demo(
    name: 'AnimatedSwitcher',
    route: AnimatedSwitcherDemo.routeName,
    builder: (BuildContext context) => AnimatedSwitcherDemo(),
  ),
  Demo(
    name: 'CardSwipe',
    route: CardSwipeDemo.routeName,
    builder: (BuildContext context) => CardSwipeDemo(),
  ),
  Demo(
    name: 'Carousel',
    route: CarouselDemo.routeName,
    builder: (BuildContext context) => CarouselDemo(),
  ),
  Demo(
    name: 'RepeatingAnimation',
    route: RepeatingAnimationDemo.routeName,
    builder: (BuildContext context) => RepeatingAnimationDemo(),
  ),
  Demo(
    name: 'PhysicsCardDrag',
    route: PhysicsCardDragDemo.routeName,
    builder: (BuildContext context) => PhysicsCardDragDemo(),
  ),
  Demo(
    name: 'ExpandCard',
    route: ExpandCardDemo.routeName,
    builder: (BuildContext context) => ExpandCardDemo(),
  ),
  Demo(
    name: 'FocusImages',
    route: FocusImagesDemo.routeName,
    builder: (BuildContext context) => FocusImagesDemo(),
  ),
  Demo(
    name: 'HeroAnimation',
    route: HeroAnimationDemo.routeName,
    builder: (BuildContext context) => HeroAnimationDemo(),
  ),
  Demo(
    name: 'CurvedAnimation',
    route: CurvedAnimationDemo.routeName,
    builder: (BuildContext context) => CurvedAnimationDemo(),
  ),
];

final demos = [
  Demo(
    name: 'GIFAnimation',
    route: GIFAnimationDemo.routeName,
    builder: (BuildContext context) => GIFAnimationDemo(),
  ),
  Demo(
    name: 'JsonAnimation',
    route: JsonAnimationDemo.routeName,
    builder: (BuildContext context) => JsonAnimationDemo(),
  ),
  Demo(
    name: 'ShoppingCart',
    route: ShoppingCartDemo.routeName,
    builder: (BuildContext context) => ShoppingCartDemo(),
  ),
];
final basicDemoRoutes =
    Map.fromEntries(basicDemos.map((e) => MapEntry(e.route, e.builder)));

final miscDemoRoutes =
    Map.fromEntries(miscDemos.map((e) => MapEntry(e.route, e.builder)));

final demosRoutes =
    Map.fromEntries(demos.map((e) => MapEntry(e.route, e.builder)));

final allDemos = [
  ...basicDemos,
  ...miscDemos,
  ...demos,
];

final allRoutes = <String, WidgetBuilder>{
  rootRouteName: (BuildContext context) => MyHomePage(),
  ...basicDemoRoutes,
  ...miscDemoRoutes,
  ...demosRoutes,
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: allRoutes,
      initialRoute: rootRouteName,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> listChildren() {
    final headerStyle = Theme.of(context).textTheme.headline6;
    return [
      ListTile(
          title: Text('Basics', style: headerStyle), tileColor: Colors.orange),
      ...basicDemos.map((e) => ListTile(
          leading: Text(e.name),
          onTap: () {
            Navigator.of(context).pushNamed(e.route);
          })),
      ListTile(
          title: Text('Misc', style: headerStyle), tileColor: Colors.orange),
      ...miscDemos.map((e) => ListTile(
          leading: Text(e.name),
          onTap: () {
            Navigator.of(context).pushNamed(e.route);
          })),
      ListTile(
          title: Text('Demos', style: headerStyle), tileColor: Colors.orange),
      ...demos.map((e) => ListTile(
          leading: Text(e.name),
          onTap: () {
            Navigator.of(context).pushNamed(e.route);
          })),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Animation Demos'),
        ),
        body: ListView(
          children: listChildren(),
        ));
  }
}
