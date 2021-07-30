import 'package:flutter/material.dart';

class CarouselDemo extends StatefulWidget {
  const CarouselDemo({Key key}) : super(key: key);
  static String routeName = '/misc/carousel';

  @override
  _CarouselDemoState createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> {
  static const fileNames = [
    'assets/car2.jpeg',
    'assets/car3.jpeg',
    'assets/car4.jpeg',
  ];

  final List<Widget> images =
      fileNames.map((e) => Image.asset(e, fit: BoxFit.cover)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carousel'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: AspectRatio(
            aspectRatio: 1,
            child: Carousel(itemBuilder: widgetBuilder),
          ),
        ),
      ),
    );
  }

  Widget widgetBuilder(BuildContext context, int index) {
    return images[index % images.length];
  }
}

typedef OnCurrentItemChangedCallback = Function(int currentItem);

class Carousel extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  const Carousel({Key key, this.itemBuilder}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  PageController _controller;
  int _currentPage;
  bool _pageHasChanged = false;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _controller = PageController(
      viewportFraction: .85,
      initialPage: _currentPage,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return PageView.builder(
      controller: _controller,
      onPageChanged: (value) {
        setState(() {
          _pageHasChanged = true;
          _currentPage = value;
        });
      },
      itemBuilder: (context, index) => AnimatedBuilder(
        child: widget.itemBuilder(context, index),
        animation: _controller,
        builder: (context, child) {
          var result = _pageHasChanged ? _controller.page : _currentPage * 1.0;
          var value = result - index;
          value = (1.0 - (value.abs() * .5)).clamp(0.0, 1.0);
          return Center(
            child: SizedBox(
                child: child,
                height: Curves.easeOut.transform(value) * size.height,
                width: Curves.easeOut.transform(value) * size.width),
          );
        },
      ),
    );
  }
}
