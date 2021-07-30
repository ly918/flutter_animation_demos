import 'package:flutter/material.dart';
import 'package:flutter_demo_animations/common.dart';

class ExpandCardDemo extends StatefulWidget {
  ExpandCardDemo({Key key}) : super(key: key);
  static const String routeName = '/misc/expand_card';

  @override
  _ExpandCardDemoState createState() => _ExpandCardDemoState();
}

class _ExpandCardDemoState extends State<ExpandCardDemo> {
  @override
  Widget build(BuildContext context) {
    return MyScaffoldPage(
      title: "ExpandCard",
      body: ExpandCard(),
    );
  }
}

class ExpandCard extends StatefulWidget {
  const ExpandCard({Key key}) : super(key: key);

  @override
  _ExpandCardState createState() => _ExpandCardState();
}

class _ExpandCardState extends State<ExpandCard>
    with SingleTickerProviderStateMixin {
  bool selected = false;
  double get size => selected ? 256 : 128;
  static const _duration = Duration(seconds: 1);

  _toggleExpanded() {
    setState(() {
      selected = !selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _toggleExpanded,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: AnimatedContainer(
              duration: _duration,
              width: size,
              height: size,
              curve: Curves.ease,
              child: AnimatedCrossFade(
                firstChild: Image.asset(
                  'assets/car2.jpeg',
                  fit: BoxFit.cover,
                ),
                secondChild: Image.asset(
                  'assets/car3.jpeg',
                  fit: BoxFit.cover,
                ),
                crossFadeState: selected
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: _duration,
                layoutBuilder:
                    (topChild, topChildKey, bottomChild, bottomChildKey) {
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: bottomChild,
                        key: bottomChildKey,
                      ),
                      Positioned.fill(
                        child: topChild,
                        key: topChildKey,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
