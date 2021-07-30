import 'package:flutter/material.dart';
import 'package:flutter_demo_animations/basics/08_fade_transition.dart';

class AnimatedListDemo extends StatefulWidget {
  AnimatedListDemo({Key key}) : super(key: key);
  static String routeName = '/misc/animated_list';

  @override
  _AnimatedListDemoState createState() => _AnimatedListDemoState();
}

class _AnimatedListDemoState extends State<AnimatedListDemo> {
  GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final listData = [
    UserModel(0, 'Govind', 'Dixit'),
    UserModel(1, 'Greta', 'Stoll'),
    UserModel(2, 'Monty', 'Carlo'),
    UserModel(3, 'Petey', 'Cruiser'),
    UserModel(4, 'Barry', 'Cade'),
  ];
  final initialListSize = 5;

  addUser() {
    setState(() {
      var index = listData.length;
      listData.add(UserModel(++_maxIdValue, 'New', 'Person'));
      _listKey.currentState.insertItem(
        index,
        duration: Duration(milliseconds: 300),
      );
    });
  }

  deleteUser(int id) {
    setState(() {
      final index = listData.indexWhere((u) => u.id == id);
      var user = listData.removeAt(index);
      _listKey.currentState.removeItem(index, (context, animation) {
        return FadeTransition(
          opacity:
              CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
          child: SizeTransition(
            sizeFactor:
                CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
            axisAlignment: 0.0,
            child: _buildItem(user),
          ),
        );
      }, duration: Duration(milliseconds: 600));
    });
  }

  Widget _buildItem(UserModel user) {
    return ListTile(
      key: ValueKey<UserModel>(user),
      title: Text(user.firstName),
      subtitle: Text(user.lastName),
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () => deleteUser(user.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedList'),
      ),
      body: SafeArea(
        child: AnimatedList(
          key: _listKey,
          initialItemCount: 5,
          itemBuilder: (context, index, animation) {
            return FadeTransition(
              opacity: animation,
              child: _buildItem(listData[index]),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: addUser,
      ),
    );
  }
}

class UserModel {
  UserModel(
    this.id,
    this.firstName,
    this.lastName,
  );

  final int id;
  final String firstName;
  final String lastName;
}

int _maxIdValue = 4;
