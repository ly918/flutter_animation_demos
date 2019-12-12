import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PopupAnimationWidget extends AnimatedWidget {
  final GlobalKey stackKey;
  final GlobalKey startKey;
  final Size size;
  final Color color;
  final Offset startAdjustOffset;
  final Animation<double> animation;

  PopupAnimationWidget({
    @required this.animation,
    @required this.stackKey,
    @required this.startKey,
    @required this.size,
    this.color = Colors.yellow,
    this.startAdjustOffset = Offset.zero,
  }) : super(listenable: animation);

  Offset _startOffset;
  Offset _offset = Offset.zero;
  Size _size = Size.zero;
  double _opacity = 0;
  BorderRadius _borderRadius = BorderRadius.all(Radius.circular(0));

  @override
  Widget build(BuildContext context) {
    _calAnimation();
    return Positioned(
      left: _offset.dx,
      top: _offset.dy,
      child: Opacity(
        opacity: _opacity,
        child: Container(
          child: FlutterLogo(),
          decoration: BoxDecoration(
            color: Colors.white,
            border: new Border.all(
              color: Colors.indigo[300],
              width: 3.0,
            ),
            borderRadius: _borderRadius,
          ),
          width: _size.width,
          height: _size.height,
        ),
      ),
    );
  }

  void _calAnimation() {
    if (_startOffset == null) {
      RenderBox stackBox = stackKey.currentContext.findRenderObject();
      Offset stackBoxOffset = stackBox.globalToLocal(Offset.zero);

      EdgeInsets startMargin = _margin(startKey);
      RenderBox startBox = startKey.currentContext.findRenderObject();

      _startOffset = startBox.localToGlobal(Offset(
          startMargin.left + startAdjustOffset.dx,
          stackBoxOffset.dy + startMargin.top + startAdjustOffset.dy));
      _offset = _startOffset;
    } else {
      Animation<double> left =
          Tween<double>(begin: _startOffset.dx, end: _startOffset.dx).animate(
              CurvedAnimation(
                  parent: animation,
                  curve: Interval(0, 1, curve: Curves.ease)));
      Animation<double> top = Tween<double>(
              begin: _startOffset.dy, end: _startOffset.dy - size.height)
          .animate(CurvedAnimation(
              parent: animation, curve: Interval(0, 0.6, curve: Curves.ease)));
      _offset = Offset(left.value, top.value);

      Animation<Size> value = Tween<Size>(begin: Size.zero, end: size).animate(
          CurvedAnimation(
              parent: animation, curve: Interval(0, 0.6, curve: Curves.ease)));

      _size = value.value;

      Animation<BorderRadius> radiusAnimation = BorderRadiusTween(
              begin: BorderRadius.all(Radius.circular(10)),
              end: BorderRadius.all(Radius.circular(size.height / 2.0)))
          .animate(CurvedAnimation(
              parent: animation, curve: Interval(0.6, 1, curve: Curves.ease)));

      _borderRadius = radiusAnimation.value;

      Animation<double> opacityAnimation = Tween<double>(begin: 0, end: 1)
          .animate(CurvedAnimation(
              parent: animation, curve: Interval(0, 0.6, curve: Curves.ease)));

      _opacity = opacityAnimation.value;
    }
  }

  EdgeInsets _margin(GlobalKey key) {
    final Widget widget = key.currentContext.widget;
    EdgeInsets margin = (widget is Container) ? widget.margin : EdgeInsets.zero;
    return margin ?? EdgeInsets.zero;
  }
}
