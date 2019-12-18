import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PopupAnimationWidget extends AnimatedWidget {
  final GlobalKey stackKey;
  final GlobalKey startKey;
  final Color color;
  final Widget child;
  final Offset popupOffset;
  final Animation<double> animation;

  PopupAnimationWidget({
    @required this.animation,
    @required this.stackKey,
    @required this.startKey,
    @required this.child,
    this.color = Colors.yellow,
    this.popupOffset = Offset.zero,
  }) : super(listenable: animation);

  Offset _startOffset;
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    _calAnimation();

    final Animation<double> opacityAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(
            parent: animation, curve: Interval(0, 0.4, curve: Curves.ease)));
    _offset =
        Offset(_startOffset.dx, _startOffset.dy - opacityAnimation.value * 80);

    return Positioned(
      left: _offset.dx,
      top: _offset.dy,
      child: Opacity(
        opacity: opacityAnimation.value,
        child: ScaleTransition(
          alignment: Alignment.bottomCenter,
          scale: opacityAnimation,
          child: Container(
            child: child,
          ),
        ),
      ),
    );
  }

  void _calAnimation() {
    if (_startOffset == null) {
      final RenderBox stackBox = stackKey.currentContext.findRenderObject();
      final Offset stackBoxOffset = stackBox.globalToLocal(Offset.zero);

      final EdgeInsets startMargin = _margin(startKey);
      final RenderBox startBox = startKey.currentContext.findRenderObject();

      _startOffset = startBox.localToGlobal(Offset(
          startMargin.left + popupOffset.dx,
          stackBoxOffset.dy + startMargin.top + popupOffset.dy));
    }
  }

  EdgeInsets _margin(GlobalKey key) {
    final Widget widget = key.currentContext.widget;
    final EdgeInsets margin =
        (widget is Container) ? widget.margin : EdgeInsets.zero;
    return margin ?? EdgeInsets.zero;
  }
}
