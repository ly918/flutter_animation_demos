import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class PhysicsCardDragDemo extends StatefulWidget {
  PhysicsCardDragDemo({Key key}) : super(key: key);
  static const String routeName = '/misc/physics_card';

  @override
  _PhysicsCardDragDemoState createState() => _PhysicsCardDragDemoState();
}

class _PhysicsCardDragDemoState extends State<PhysicsCardDragDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PhysicsCardDrag'),
      ),
      body: DraggableCard(
        child: FlutterLogo(
          size: 120,
        ),
      ),
    );
  }
}

class DraggableCard extends StatefulWidget {
  final Widget child;
  DraggableCard({Key key, this.child}) : super(key: key);

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Alignment> _animation;
  Alignment _dragAlignment = Alignment.center;
  SpringDescription _spring = SpringDescription(
    mass: 10,
    stiffness: 1000,
    damping: 0.7,
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this)
      ..addListener(
        () => setState(
          () => _dragAlignment = _animation.value,
        ),
      );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _onPanStart(DragStartDetails details) {
    _controller.stop(canceled: true);
  }

  _onPanUpdate(DragUpdateDetails details) {
    Size size = MediaQuery.of(context).size;
    setState(
      () => _dragAlignment += Alignment(
        details.delta.dx / (size.width * 0.5),
        details.delta.dy / (size.height * 0.5),
      ),
    );
  }

  _onPanEnd(DragEndDetails details) {
    Size size = MediaQuery.of(context).size;
    _runAnimation(details.velocity.pixelsPerSecond, size);
  }

  _runAnimation(Offset velocity, Size size) {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );

    final simulation =
        SpringSimulation(_spring, 0, 1, _normalizeVelocity(velocity, size));
    _controller.animateWith(simulation);
  }

  _normalizeVelocity(Offset velocity, Size size) {
    final normalizedVelocity = Offset(
      velocity.dx / size.width,
      velocity.dy / size.height,
    );
    return -normalizedVelocity.distance;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Align(
        alignment: _dragAlignment,
        child: Card(
          child: widget.child,
        ),
      ),
    );
  }
}
