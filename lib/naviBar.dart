import 'package:cardispatch/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NaviBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
        child: ListView(children: [
      UserAccountsDrawerHeader(
          accountName: const Text('早渕RF'),
          accountEmail: const Text('TEST'),
          currentAccountPicture: CircleAvatar(
              child: ClipOval(
            child: Image.asset(
              'images/car.jpg',
              width: 90,
              height: 90,
            ),
          ))),
      ListTile(
        leading: const Icon(Icons.calendar_month),
        title: const Text('ホーム'),
        onTap: () => Navigator.pushNamed(context, '/mainMenu'),
      ),
      ListTile(
        leading: const Icon(Icons.calendar_month),
        title: const Text('配車日程'),
        onTap: () => Navigator.pushNamed(context, '/scheduleReg'),
      ),
      const ListTile(
        leading: Icon(Icons.question_mark_rounded),
        title: Text(
          '参加回答',
          style: TextStyle(
            color: Color.fromRGBO(224, 224, 224, 1),
          ),
        ),
        //onTap: () => Navigator.pushNamed(context, '/todo'),
        onTap: null,
      ),
      ListTile(
        leading: const Icon(Icons.car_repair),
        title: const Text('配車'),
        onTap: () => Navigator.pushNamed(context, '/haisya'),
      ),
      ListTile(
        leading: const Icon(Icons.calculate_outlined),
        title: const Text('清算'),
        onTap: () => Navigator.pushNamed(context, '/report'),
      ),
      const ListTile(
        leading: Icon(Icons.people),
        title: Text(
          '部員登録',
          style: TextStyle(
            color: Color.fromRGBO(224, 224, 224, 1),
          ),
        ),
        onTap: null,
        //onTap: () => Navigator.pushNamed(context, '/memReg'),
      ),
      const ListTile(
        leading: Icon(Icons.place),
        title: Text(
          '試合球場登録',
          style: TextStyle(
            color: Color.fromRGBO(224, 224, 224, 1),
          ),
        ),
        onTap: null,
        //onTap: () => Navigator.pushNamed(context, '/todo'),
      ),
      const ListTile(
        leading: Icon(Icons.car_rental),
        title: Text(
          '車登録',
          style: TextStyle(
            color: Color.fromRGBO(224, 224, 224, 1),
          ),
        ),
        onTap: null,
        //onTap: () => Navigator.pushNamed(context, '/carReg'),
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.exit_to_app_outlined),
        title: const Text('ログアウト'),
        onTap: () => signOut(context),
      ),
    ]));
  }
}

void signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushNamedAndRemoveUntil(
    context,
    '/login',
    (Route<dynamic> route) => false,
  );
}
