import 'package:flutter/material.dart';
import 'package:flutter_animation_demos/parabolic_animation_widget.dart';
import 'package:flutter_animation_demos/popup_animation_widget.dart';

class AnimationPointManager {
  List<AnimatedWidget> list = [];

  addParabolicAniamtion({
    @required TickerProvider vsync,
    @required GlobalKey stackKey,
    @required GlobalKey startKey,
    @required GlobalKey endKey,
    Duration duration,
    AnimationStatusListener statusListener,
  }) {
    AnimationController controller = createController(vsync, duration);
    Animation animation = createAnimation(controller);

    AnimatedWidget animatedWidget = ParabolicAnimationWidget(
      animation: animation,
      stackKey: stackKey,
      startKey: startKey,
      endKey: endKey,
      endAdjustOffset: Offset.zero,
      startAdjustOffset: Offset.zero,
    );
    list.add(animatedWidget);

    try {
      controller.forward().orCancel;
    } on TickerCanceled {}

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        list.remove(animatedWidget);
        controller.dispose();
      }
      statusListener(status);
    });
  }

  addPopupAniamtion({
    @required TickerProvider vsync,
    @required GlobalKey stackKey,
    @required GlobalKey startKey,
    @required Size size,
    Duration duration,
    AnimationStatusListener statusListener,
  }) async {
    AnimationController controller = createController(vsync, duration);

    AnimatedWidget animatedWidget = PopupAnimationWidget(
      animation: controller.view,
      stackKey: stackKey,
      startKey: startKey,
      size: size,
      startAdjustOffset: Offset(0, -30),
    );
    list.add(animatedWidget);

    try {
      await controller.forward().orCancel;
      await controller.reverse().orCancel;
    } on TickerCanceled {}

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        list.remove(animatedWidget);
        controller.dispose();
      }
      statusListener(status);
    });
  }

  static AnimationController createController(
      TickerProvider vsync, Duration duration) {
    AnimationController ani = AnimationController(
        lowerBound: 0,
        upperBound: 1,
        duration: duration ?? Duration(milliseconds: 800),
        vsync: vsync);
    return ani;
  }

  static CurvedAnimation createAnimation(controller) {
    return CurvedAnimation(parent: controller, curve: Curves.linear);
  }
}
