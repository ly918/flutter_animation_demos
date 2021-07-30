import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_animations/common.dart';
import 'package:lottie/lottie.dart';

class JsonAnimationDemo extends StatefulWidget {
  JsonAnimationDemo({Key key}) : super(key: key);
  static const String routeName = '/misc/json_animation';

  @override
  _JsonAnimationDemoState createState() => _JsonAnimationDemoState();
}

class _JsonAnimationDemoState extends State<JsonAnimationDemo> {
  var windy =
      'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json';
  var logo = 'assets/logo.json';
  var zip = 'assets/spinning_carrousel.zip';
  var networkzip =
      'https://github.com/xvrh/lottie-flutter/raw/master/example/assets/lottiefiles/ball_%26_map.zip';

  bool loadJson = false;

  @override
  Widget build(BuildContext context) {
    return MyScaffoldPage(
      title: 'Json Animation',
      body: ListView(
        children: [
          MyListTile(title: '本地Json动画'),
          Lottie.asset(
            logo,
            width: 200,
            height: 200,
          ),
          MyListTile(title: '本地zip动画'),
          Lottie.asset(
            zip,
            width: 200,
            height: 200,
          ),
          MyListTile(
            title: '网络Json动画',
            trailing: ElevatedButton(
              onPressed: () {
                setState(() {
                  loadJson = true;
                });
              },
              child: Text('加载网络Json动画'),
            ),
          ),
          if (loadJson)
            Lottie.network(
              windy,
              width: 200,
              height: 200,
            ),
        ],
      ),
    );
  }
}
