import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_demo_animations/common.dart';

class TextStyleDemo extends StatefulWidget {
  const TextStyleDemo({Key key}) : super(key: key);
  static const String routeName = '/demos/text_style_demo';

  @override
  _TextStyleDemoState createState() => _TextStyleDemoState();
}

class _TextStyleDemoState extends State<TextStyleDemo> {
  TextStyle _style =
      TextStyle(color: Colors.red, fontWeight: FontWeight.normal, fontSize: 30);

  @override
  Widget build(BuildContext context) {
    return MyScaffoldPage(
      title: "Text Style Demo",
      body: ListView(children: [
        AnimatedDefaultTextStyle(
          child: Text('Text Style'),
          style: _style,
          duration: Duration(milliseconds: 500),
        ),
        ElevatedButton(
          child: Text('Change'),
          onPressed: () {
            _style = TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 40);
            setState(() {});
          },
        ),
      ]),
    );
  }
}
