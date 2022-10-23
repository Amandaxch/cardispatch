import 'package:flutter/material.dart';
import 'package:cardispatch/data.dart';
import 'package:intl/intl.dart';
import 'package:cardispatch/naviBar.dart';

// ステートクラス
class NotApprovedPage extends StatefulWidget {
  NotApprovedPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _NotApprovedPageState createState() => new _NotApprovedPageState();
}

class _NotApprovedPageState extends State<NotApprovedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: NaviBar(),
      appBar: AppBar(
        title: Text('管理者承認待ち'),
      ),
      body: Center(
          child: Text('管理者承認待ち状態です。\nチーム所属を確認でき次第、承認を致します。',
              style: TextStyle(fontSize: 16))),
    );
  }
}
