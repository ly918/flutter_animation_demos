import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class CardSwipeDemo extends StatefulWidget {
  CardSwipeDemo({Key key}) : super(key: key);
  static String routeName = '/misc/card_swipe';

  @override
  _CardSwipeDemoState createState() => _CardSwipeDemoState();
}

class _CardSwipeDemoState extends State<CardSwipeDemo> {
  List<String> fileNames = [];

  List<Widget> _cards() {
    return fileNames
        .map(
          (e) => SwipeableCard(
            imageAssetName: e,
            onSwiped: () {
              setState(() {
                fileNames.remove(e);
              });
            },
          ),
        )
        .toList();
  }

  _resetCards() {
    fileNames = [
      'assets/car2.jpeg',
      'assets/car3.jpeg',
      'assets/car4.jpeg',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Swipe'),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: ClipRect(
                  child: Stack(
                    children: _cards(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _resetCards();
                    });
                  },
                  child: Text('Reset')),
            ],
          ),
        ),
      ),
    );
  }
}

class SwipeableCard extends StatefulWidget {
  final String imageAssetName;
  final VoidCallback onSwiped;

  SwipeableCard({
    Key key,
    this.imageAssetName,
    this.onSwiped,
  }) : super(key: key);

  @override
  _SwipeableCardState createState() => _SwipeableCardState();
}

class _SwipeableCardState extends State<SwipeableCard>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> animation;
  double dragStartX;
  bool _isSwipingLeft = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController.unbounded(vsync: this);
    animation = controller.drive(
      Tween<Offset>(
        begin: Offset.zero,
        end: Offset.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: GestureDetector(
        onHorizontalDragStart: _dragStart,
        onHorizontalDragUpdate: _dragUpdate,
        onHorizontalDragEnd: _dragEnd,
        child: _MyCard(imageAssetName: widget.imageAssetName),
      ),
    );
  }

  _dragStart(DragStartDetails details) {
    dragStartX = details.localPosition.dx;
  }

  _dragUpdate(DragUpdateDetails details) {
    var isSwipingLeft = (details.localPosition.dx - dragStartX) < 0;
    if (isSwipingLeft != _isSwipingLeft) {
      _isSwipingLeft = isSwipingLeft;
      _updateAnimation(details.localPosition.dx);
    }
    setState(() {
      final size = context.size;
      if (size == null) {
        return;
      }
      controller.value =
          (details.localPosition.dx - dragStartX).abs() / size.width;
    });
  }

  _dragEnd(DragEndDetails details) {
    final size = context.size;
    if (size == null) return;

    var velocity = (details.velocity.pixelsPerSecond.dx / size.width).abs();
    _animate(velocity);
  }

  _animate(double velocity) {
    var description = SpringDescription(mass: 50, stiffness: 1, damping: 1);
    var simulation =
        SpringSimulation(description, controller.value, 1, velocity);
    controller.animateWith(simulation).then((_) {
      widget.onSwiped();
    });
  }

  _updateAnimation(double dx) {
    animation = controller.drive(
      Tween<Offset>(
        begin: Offset.zero,
        end: _isSwipingLeft ? Offset(-1, 0) : Offset(1, 0),
      ),
    );
  }
}

class _MyCard extends StatelessWidget {
  final String imageAssetName;
  const _MyCard({
    Key key,
    this.imageAssetName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 5.0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: AssetImage(imageAssetName),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
