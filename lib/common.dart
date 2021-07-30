import 'dart:math';
import 'package:flutter/material.dart';

double randomBorderRadius() => Random().nextDouble() * 64;
double randomMargin() => Random().nextDouble() * 64;
Color randomColor() => Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));

class MyScaffoldPage extends StatefulWidget {
  final Widget body;
  final String title;
  const MyScaffoldPage({
    Key key,
    this.title,
    this.body,
  }) : super(key: key);

  @override
  _MyScaffoldPageState createState() => _MyScaffoldPageState();
}

class _MyScaffoldPageState extends State<MyScaffoldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: widget.body,
    );
  }
}

class MyListTile extends StatelessWidget {
  final String title;
  final Widget trailing;
  const MyListTile({Key key, this.trailing, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: trailing,
    );
  }
}
