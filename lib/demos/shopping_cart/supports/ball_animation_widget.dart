import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

// ignore: must_be_immutable
class BallAnimationWidget extends AnimatedWidget {
  final GlobalKey stackKey;
  final GlobalKey startKey;
  final GlobalKey endKey;
  final double size;
  final Color color;
  final Offset startAdjustOffset;
  final Offset endAdjustOffset;

  BallAnimationWidget({
    @required Animation<double> animation,
    @required this.stackKey,
    @required this.startKey,
    @required this.endKey,
    this.size = 20.0,
    this.color = Colors.red,
    this.startAdjustOffset = Offset.zero,
    this.endAdjustOffset = Offset.zero,
  }) : super(listenable: animation);

  Offset _startOffset;
  Offset _endOffset;

  @override
  Widget build(BuildContext context) {
    _calPositions();

    final Animation<double> animation = listenable;
    final double time = animation.value;

    // 设time=1 已知两点坐标 和 初速度 可求出 加速度 a
    // double x(double time) => _x + _v * time + 0.5 * _a * time * time;
    final double initV = -400; //纵坐标初速度, 负值为向上抛
    final double acceleration =
        (_endOffset.dy - _startOffset.dy - initV) / 0.5; //求纵坐标加速度

    final GravitySimulation spy = GravitySimulation(
        acceleration, _startOffset.dy, _endOffset.dy, initV); //y轴加速度运动 模拟

    final GravitySimulation spx = GravitySimulation(0, _startOffset.dx,
        _endOffset.dx, _endOffset.dx - _startOffset.dx); //x轴匀速模拟 加速度为0

    final Animation<double> opacity = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(
            parent: animation, curve: Interval(0.9, 1, curve: Curves.ease)));

    return Positioned(
      top: spy.x(time),
      left: spx.x(time),
      child: Opacity(
        opacity: opacity.value,
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(size / 2.0))),
        ),
      ),
    );
  }

  void _calPositions() {
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
    }
  }

  EdgeInsets _margin(GlobalKey key) {
    final Widget widget = key.currentContext.widget;
    EdgeInsets margin = (widget is Container) ? widget.margin : EdgeInsets.zero;
    return margin ?? EdgeInsets.zero;
  }
}
