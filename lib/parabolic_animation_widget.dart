import 'dart:math';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ParabolicAnimationWidget extends AnimatedWidget {
  final GlobalKey stackKey;
  final GlobalKey startKey;
  final GlobalKey endKey;
  final double size;
  final Color color;
  final Offset startAdjustOffset;
  final Offset endAdjustOffset;

  ParabolicAnimationWidget({
    @required Animation<double> animation,
    @required this.stackKey,
    @required this.startKey,
    @required this.endKey,
    this.size = 30.0,
    this.color = Colors.black,
    this.startAdjustOffset = Offset.zero,
    this.endAdjustOffset = Offset.zero,
  }) : super(listenable: animation);

  double _width = 0;
  double _height = 0;
  Offset _startOffset;
  Offset _endOffset;

  @override
  Widget build(BuildContext context) {
    final Offset offset = _calOffset();
    return Positioned(
      top: offset.dy,
      left: offset.dx,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(size / 2.0))),
      ),
    );
  }

  Offset _calOffset() {
    if (_startOffset == null) {
      RenderBox stackBox = stackKey.currentContext.findRenderObject();
      Offset stackBoxOffset = stackBox.globalToLocal(Offset.zero);

      EdgeInsets startMargin = _margin(startKey);
      RenderBox startBox = startKey.currentContext.findRenderObject();
      _startOffset = startBox.localToGlobal(Offset(
          startMargin.left + startAdjustOffset.dx,
          stackBoxOffset.dy + startMargin.top + startAdjustOffset.dy));

      EdgeInsets endMargin = _margin(endKey);
      RenderBox endBox = endKey.currentContext.findRenderObject();
      _endOffset = endBox.localToGlobal(Offset(
          endMargin.left + endAdjustOffset.dx,
          stackBoxOffset.dy + endMargin.top + endAdjustOffset.dy));

      _width = _endOffset.dx - _startOffset.dx;
      _height = _endOffset.dy - _startOffset.dy;

      return _startOffset;
    } else {
      return Offset(_startOffset.dx + _x(), _startOffset.dy + _y());
    }
  }

  EdgeInsets _margin(GlobalKey key) {
    final Widget widget = key.currentContext.widget;
    EdgeInsets margin = (widget is Container) ? widget.margin : EdgeInsets.zero;
    return margin ?? EdgeInsets.zero;
  }

  double _y() {
    Animation<double> animation = listenable;
    double t = animation.value;
    return pow(t, 3) * _height;
  }

  double _x() {
    Animation<double> animation = listenable;
    double t = animation.value;
    return _width * t;
  }
}
