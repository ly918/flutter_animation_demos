import 'package:flutter/material.dart';
import 'package:flutter_demo_animations/common.dart';

class FocusImagesDemo extends StatefulWidget {
  const FocusImagesDemo({Key key}) : super(key: key);
  static String routeName = '/misc/focus_image';

  @override
  _FocusImagesDemoState createState() => _FocusImagesDemoState();
}

class _FocusImagesDemoState extends State<FocusImagesDemo> {
  @override
  Widget build(BuildContext context) {
    return MyScaffoldPage(
      title: 'Focus Image',
      body: Grid(),
    );
  }
}

class Grid extends StatelessWidget {
  const Grid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 40,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (context, index) {
        return index >= 20
            ? SmallCard('assets/car2.jpeg')
            : SmallCard('assets/car3.jpeg');
      },
    );
  }
}

Route _createRoute(BuildContext parentContext, String image) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    return _SecondPage(image);
  }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
    var rectAnimation = _createTween(parentContext)
        .chain(CurveTween(curve: Curves.ease))
        .animate(animation);

    return Stack(
      children: [
        PositionedTransition(
          rect: rectAnimation,
          child: child,
        ),
      ],
    );
  });
}

Tween<RelativeRect> _createTween(BuildContext context) {
  var size = MediaQuery.of(context).size;
  var box = context.findRenderObject() as RenderBox;
  var rect = box.localToGlobal(Offset.zero) & box.size;
  var relativeRect = RelativeRect.fromSize(rect, size);

  return RelativeRectTween(
    begin: relativeRect,
    end: RelativeRect.fill,
  );
}

class SmallCard extends StatelessWidget {
  final String imageAssetName;
  SmallCard(this.imageAssetName);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(_createRoute(context, imageAssetName));
          },
          child: Image.asset(
            imageAssetName,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _SecondPage extends StatefulWidget {
  final String imageAssetName;

  _SecondPage(this.imageAssetName);

  @override
  __SecondPageState createState() => __SecondPageState();
}

class __SecondPageState extends State<_SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                widget.imageAssetName,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
