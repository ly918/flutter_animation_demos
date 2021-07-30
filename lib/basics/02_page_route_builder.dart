import 'package:flutter/material.dart';

class PageRouteBuilderDemo extends StatelessWidget {
  PageRouteBuilderDemo({Key key}) : super(key: key);
  static String routeName = '/basics/02_page_route_builder';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 1"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Go!'),
          onPressed: () {
            Navigator.of(context).push(_route());
          },
        ),
      ),
    );
  }

  Route _route() {
    return PageRouteBuilder<SlideTransition>(
      pageBuilder: (context, animation, secondaryAnimation) => _Page2(),
      transitionsBuilder: (context, animation, secondaryAniamtion, child) {
        var tween = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero);
        var curveTween = CurveTween(curve: Curves.easeInOut);
        return SlideTransition(
          position: animation.drive(curveTween).drive(tween),
          child: child,
        );
      },
    );
  }
}

class _Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 2"),
      ),
      body: Center(
        child: Text("Page 2!", style: Theme.of(context).textTheme.headline4),
      ),
    );
  }
}
