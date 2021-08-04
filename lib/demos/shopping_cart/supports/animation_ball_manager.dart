import 'package:flutter/material.dart';
import 'package:flutter_demo_animations/demos/shopping_cart/supports/ball_animation_widget.dart';
import 'package:flutter_demo_animations/demos/shopping_cart/supports/popup_animation_widget.dart';

class AnimationBallManager {
  List<AnimatedWidget> list = [];

  Future<void> addBallAniamtion({
    @required TickerProvider vsync,
    @required GlobalKey stackKey,
    @required GlobalKey startKey,
    @required GlobalKey endKey,
    @required Duration duration,
    @required AnimationStatusListener statusListener,
    Color color = Colors.blue,
    double size = 20,
    Offset startAdjustOffset = Offset.zero,
    Offset endAdjustOffset = Offset.zero,
  }) async {
    AnimationController controller = createController(vsync, duration);
    Animation animation = createAnimation(controller);

    AnimatedWidget animatedWidget = BallAnimationWidget(
      animation: animation,
      stackKey: stackKey,
      startKey: startKey,
      endKey: endKey,
      size: size,
      color: color,
      startAdjustOffset: startAdjustOffset,
      endAdjustOffset: endAdjustOffset,
    );
    list.add(animatedWidget);
    statusListener(AnimationStatus.dismissed);

    try {
      await controller.forward().orCancel;
    } on TickerCanceled {
      print("Ticker Canceled");
    }

    list.remove(animatedWidget);
    controller.dispose();
    statusListener(AnimationStatus.completed);
  }

  Future<void> addPopupAniamtion({
    @required TickerProvider vsync,
    @required GlobalKey stackKey,
    @required GlobalKey startKey,
    @required Widget child,
    Duration duration,
    Offset popupOffset = Offset.zero,
    AnimationStatusListener statusListener,
  }) async {
    AnimationController controller = createController(vsync, duration);

    AnimatedWidget animatedWidget = PopupAnimationWidget(
      animation: controller.view,
      stackKey: stackKey,
      startKey: startKey,
      child: child,
      popupOffset: popupOffset,
    );
    list.add(animatedWidget);
    statusListener(AnimationStatus.dismissed);

    try {
      await controller.forward().orCancel;
      await controller.reverse().orCancel;
    } on TickerCanceled {
      print("Ticker Canceled");
    }

    list.remove(animatedWidget);
    controller.dispose();

    statusListener(AnimationStatus.completed);
  }

  static AnimationController createController(
      TickerProvider vsync, Duration duration) {
    AnimationController ani = AnimationController(
        lowerBound: 0,
        upperBound: 1,
        duration: duration ?? Duration(milliseconds: 2000),
        vsync: vsync);
    return ani;
  }

  static CurvedAnimation createAnimation(controller) {
    return CurvedAnimation(parent: controller, curve: Curves.linear);
  }
}
