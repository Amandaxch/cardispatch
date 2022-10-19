import 'package:flutter/material.dart';
import 'package:cardispatch/data.dart';
import 'package:intl/intl.dart';
import 'package:cardispatch/naviBar.dart';

// class HaisyaPage extends StatefulWidget {
// ステートクラス
class TodoPage extends StatefulWidget {
  TodoPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _TodoPageState createState() => new _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NaviBar(),
      appBar: AppBar(
        title: Text('ToDo'),
      ),
      body: Center(child: Text('作成中........')),
    );
  }
}
