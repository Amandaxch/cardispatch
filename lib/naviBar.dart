import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NaviBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
        child: ListView(children: [
      UserAccountsDrawerHeader(
          accountName: Text('早渕RF'),
          accountEmail: Text('xxx@yahoo.co.jp'),
          currentAccountPicture: CircleAvatar(
              child: ClipOval(
            child: Image.asset(
              'images/car.jpg',
              width: 90,
              height: 90,
            ),
          ))),
      ListTile(
        leading: Icon(Icons.calendar_month),
        title: Text('ホーム'),
        onTap: () => Navigator.pushNamed(context, '/mainMenu'),
      ),
      ListTile(
        leading: Icon(Icons.calendar_month),
        title: Text('配車日程'),
        onTap: () => Navigator.pushNamed(context, '/scheduleReg'),
      ),
      ListTile(
        leading: Icon(Icons.question_mark_rounded),
        title: Text('参加回答'),
        onTap: () => Navigator.pushNamed(context, '/todo'),
      ),
      ListTile(
        leading: Icon(Icons.car_repair),
        title: Text('配車'),
        onTap: () => Navigator.pushNamed(context, '/haisya'),
      ),
      ListTile(
        leading: Icon(Icons.calculate_outlined),
        title: Text('清算'),
        onTap: () => Navigator.pushNamed(context, '/report'),
      ),
      ListTile(
        leading: Icon(Icons.people),
        title: Text('部員登録'),
        onTap: () => Navigator.pushNamed(context, '/memReg'),
      ),
      ListTile(
        leading: Icon(Icons.place),
        title: Text('試合球場登録'),
        onTap: () => Navigator.pushNamed(context, '/todo'),
      ),
      ListTile(
        leading: Icon(Icons.car_rental),
        title: Text('車登録'),
        onTap: () => Navigator.pushNamed(context, '/carReg'),
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.exit_to_app_outlined),
        title: Text('ログアウト'),
        onTap: () => null,
      ),
    ]));
  }
}
