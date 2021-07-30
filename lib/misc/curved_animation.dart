import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_demo_animations/common.dart';

class CurvedAnimationDemo extends StatefulWidget {
  const CurvedAnimationDemo({Key key}) : super(key: key);
  static const String routeName = '/misc/curved_animation';

  @override
  _CurvedAnimationDemoState createState() => _CurvedAnimationDemoState();
}

class CurveChoice {
  final Curve curve;
  final String name;
  const CurveChoice({this.curve, this.name});
}

class _CurvedAnimationDemoState extends State<CurvedAnimationDemo>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> _animationRotation;
  Animation<Offset> _animationTranslation;
  Duration _duration = Duration(seconds: 4);

  /// 查看动画演示：https://flutter.github.io/assets-for-api-docs/assets/animation/curve_bounce_in.mp4
  List<CurveChoice> curves = [
    CurveChoice(curve: Curves.bounceIn, name: 'Bounce In'),
    CurveChoice(curve: Curves.bounceOut, name: 'Bounce Out'),
    CurveChoice(curve: Curves.easeInCubic, name: 'Ease In Cubic'),
    CurveChoice(curve: Curves.easeOutCubic, name: 'Ease Out Cubic'),
    CurveChoice(curve: Curves.easeInExpo, name: 'Ease In Expo'),
    CurveChoice(curve: Curves.easeOutExpo, name: 'Ease Out Expo'),
    CurveChoice(curve: Curves.elasticIn, name: 'Elastic In'),
    CurveChoice(curve: Curves.elasticOut, name: 'Elastic Out'),
    CurveChoice(curve: Curves.easeInQuart, name: 'Ease In Quart'),
    CurveChoice(curve: Curves.easeOutQuart, name: 'Ease Out Quart'),
    CurveChoice(curve: Curves.easeInCirc, name: 'Ease In Circle'),
    CurveChoice(curve: Curves.easeOutCirc, name: 'Ease Out Circle'),
  ];

  CurveChoice selectedForwardCurve, selectedReverseCurve;
  CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: _duration,
    );
    selectedForwardCurve = curves.first;
    selectedReverseCurve = curves.first;
    curvedAnimation = CurvedAnimation(
        parent: controller,
        curve: selectedForwardCurve.curve,
        reverseCurve: selectedReverseCurve.curve);
    _animationRotation =
        Tween<double>(begin: 0, end: 2 * math.pi).animate(curvedAnimation)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            }
          });
    _animationTranslation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(1, 0),
    ).animate(curvedAnimation)
      ..addStatusListener((status) {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldPage(
      title: 'CurvedAnimation',
      body: Column(
        children: [
          SizedBox(height: 20.0),
          Text('Select Curve for forward motion'),
          DropdownButton(
            value: selectedForwardCurve,
            onChanged: (newValue) {
              if (newValue != null) {
                setState(() {
                  selectedForwardCurve = newValue;
                  curvedAnimation.curve = selectedForwardCurve.curve;
                });
              }
            },
            items: curves
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name),
                    ))
                .toList(),
          ),
          SizedBox(height: 15),
          Text('Select Curve for reverse motion'),
          DropdownButton(
            onChanged: (newValue) {
              if (newValue != null) {
                setState(() {
                  selectedReverseCurve = newValue;
                  curvedAnimation.reverseCurve = selectedReverseCurve.curve;
                });
              }
            },
            value: selectedReverseCurve,
            items: curves
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.name),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 35),
          Transform.rotate(
            angle: _animationRotation.value,
            child: Center(
              child: Container(
                child: FlutterLogo(
                  size: 100,
                ),
              ),
            ),
          ),
          SizedBox(height: 35),
          FractionalTranslation(
            translation: _animationTranslation.value,
            child: Container(
              child: FlutterLogo(
                size: 100,
              ),
            ),
          ),
          SizedBox(height: 25),
          ElevatedButton(
              onPressed: () {
                controller.forward();
              },
              child: Text('Animate')),
        ],
      ),
    );
  }
}
