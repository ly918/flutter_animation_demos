import 'package:flutter/material.dart';
import 'package:flutter_demo_animations/common.dart';
import 'supports/animation_point_manager.dart';

class ShoppingCartDemo extends StatefulWidget {
  ShoppingCartDemo({Key key}) : super(key: key);
  static const String routeName = '/demos/shopping_cart';

  @override
  _ShoppingCartDemoState createState() => _ShoppingCartDemoState();
}

class _ShoppingCartDemoState extends State<ShoppingCartDemo>
    with TickerProviderStateMixin {
  int count = 0;

  GlobalKey stackKey = GlobalKey();
  GlobalKey endKey = GlobalKey();
  AnimationPointManager _animationPointManager = AnimationPointManager();

  itemOnTap(GlobalKey startKey) {
    print("start key " + startKey.toString());
    print("stack key " + stackKey.toString());
    print("end key " + endKey.toString());

    _animationPointManager.addParabolicAniamtion(
      vsync: this,
      stackKey: stackKey,
      startKey: startKey,
      endKey: endKey,
      color: Colors.green,
      statusListener: (AnimationStatus status) {
        setState(() {
          if (status == AnimationStatus.completed) {
            count += 1;
            buyOnTap();
          }
        });
      },
      duration: Duration(milliseconds: 700),
    );
  }

  buyOnTap() {
    _animationPointManager.addPopupAniamtion(
      vsync: this,
      stackKey: stackKey,
      startKey: endKey,
      child: Container(
        width: 100,
        color: randomColor(),
        padding: EdgeInsets.all(25),
        child: FlutterLogo(size: 50, textColor: Colors.white),
      ),
      popupOffset: Offset(0, -50),
      duration: Duration(milliseconds: 500),
      statusListener: (AnimationStatus status) {},
    );
  }

  ShopListView _shopListView;
  BuyCartView _buyCartView;
  LeftView _leftView;

  @override
  Widget build(BuildContext context) {
    _shopListView ??= ShopListView(onTap: itemOnTap);
    _buyCartView = BuyCartView(
      count,
      endKey: endKey,
      onTap: buyOnTap,
    );
    _leftView = LeftView();

    List<Widget> childrens = [
      _leftView,
      _shopListView,
      _buyCartView,
    ];

    //step 4
    print("pointers: " + _animationPointManager.list.length.toString());
    childrens += _animationPointManager.list;

    return Scaffold(
      appBar: AppBar(title: Text('Shopping Cart')),
      body: SafeArea(
        child: Stack(
          key: stackKey,
          children: childrens,
        ),
      ),
    );
  }
}

class BuyCartView extends StatefulWidget {
  final int count;
  final GlobalKey endKey;
  final Function onTap;

  BuyCartView(this.count, {this.endKey, this.onTap});

  @override
  _BuyCartViewState createState() => _BuyCartViewState();
}

class _BuyCartViewState extends State<BuyCartView> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.grey,
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: widget.onTap,
              child: Container(
                width: 100,
                color: Colors.grey,
                padding: EdgeInsets.all(10),
                key: widget.endKey,
                alignment: Alignment.center,
                child: Stack(children: [
                  Container(
                      child: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.blue,
                    size: 60,
                  )),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      constraints: BoxConstraints(minWidth: 28, minHeight: 28),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red.withAlpha(225),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          '${widget.count}',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LeftView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 0,
      width: 100,
      height: 500,
      child: Container(
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Container(
              height: 40,
              color: index % 2 == 0 ? Colors.black26 : Colors.black12,
              child: Center(
                child: Text(
                  'Left $index',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ShopListView extends StatelessWidget {
  final Function onTap;
  ShopListView({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 100,
      right: 0,
      height: 500,
      child: Container(
        child: Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: 50,
            itemBuilder: (context, index) {
              GlobalKey key = GlobalKey();
              return Container(
                color: index % 2 == 0 ? Colors.black26 : Colors.black12,
                alignment: Alignment.centerRight,
                width: 50,
                child: GestureDetector(
                  onTap: () => onTap(key),
                  child: Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    key: key,
                    width: 120,
                    color: Colors.redAccent,
                    child: Text("加入购物车 $index",
                        style: TextStyle(color: Colors.black, fontSize: 12)),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
