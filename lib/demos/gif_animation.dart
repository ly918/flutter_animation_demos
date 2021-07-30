import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_animations/common.dart';

class GIFAnimationDemo extends StatefulWidget {
  GIFAnimationDemo({Key key}) : super(key: key);
  static const String routeName = '/misc/gif_animation';

  @override
  _GIFAnimationDemoState createState() => _GIFAnimationDemoState();
}

class _GIFAnimationDemoState extends State<GIFAnimationDemo> {
  String localGif = 'assets/image1.gif';
  String networkGif =
      'https://pic2.zhimg.com/50/v2-40ba65d1f98b3f8500fefce6175e2929_hd.webp?source=1940ef5c';
  bool loadGif = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProgressIndicatorBuilder _progressBuilder() {
      return (context, url, progress) {
        var progressMsg = progress.progress != null
            ? '下载中${(progress.progress * 100.0).toInt()}%'
            : "下载中";
        return Center(
          child: Column(
            children: [
              CircularProgressIndicator(value: progress.progress),
              SizedBox(height: 4),
              Text(
                progressMsg,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        );
      };
    }

    PlaceholderWidgetBuilder _placeholderBuilder() {
      return (context, desc) {
        return CircularProgressIndicator();
      };
    }

    LoadingErrorWidgetBuilder _loadingErrorBuidler() {
      return (context, desc, obj) {
        return Icon(Icons.error, color: Colors.red);
      };
    }

    return MyScaffoldPage(
      title: "GIF Animation",
      body: Center(
        child: ListView(
          children: [
            MyListTile(title: "本地动图"),
            Image.asset(localGif),
            MyListTile(
              title: "网络动图",
              trailing: ElevatedButton(
                onPressed: () {
                  setState(() {
                    loadGif = true;
                  });
                },
                child: Text('加载网络动图图'),
              ),
            ),
            if (loadGif)
              CachedNetworkImage(
                imageUrl: networkGif,
                progressIndicatorBuilder: _progressBuilder(),
                // placeholder: _placeholderBuilder(),
                errorWidget: _loadingErrorBuidler(),
                fadeInCurve: Curves.easeIn,
                fadeInDuration: Duration(seconds: 2),
              ),
          ],
        ),
      ),
    );
  }
}
