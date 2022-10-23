//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html';

import 'package:cardispatch/data.dart';
import 'package:cardispatch/scheduleReg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cardispatch/naviBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// MyHomePage ウィジェットクラス

class MainMenu extends StatefulWidget {
  //final String userId;
  MainMenu();

  @override
  State<StatefulWidget> createState() => _MainMenuState();
}

/* var db = FirebaseFirestore.instance;
    db.collection("users")
        .doc(uid)
        .get()
        .then((DocumentSnapshot result) {
          debugPrint('user document存在');
          teamNo = result.get('teamNo');

          var resultTeam = db.collection("teams").where("teamNo", isEqualTo: teamNo).get();
          resultTeam.then((DocumentSnapshot resultTeam2){
            userTeamName = resultTeam2.get('teamNm');
          }

*/
class _MainMenuState extends State<MainMenu> {
  String teamNo = '999999';

  late Future<void> _future;

  String userId = '0';

  @override
  void initState() {
    _future = fetchTeamName();
    super.initState();
  }

  Future fetchTeamName() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try {
      debugPrint('Main Menu userId before:$userId');
      userId = _firebaseAuth.currentUser!.uid;
      debugPrint('Main Menu userId after:$userId');
      await _firestore.collection('users').doc('$userId').get().then(
        (event) {
          teamNo = event.get('teamNo');
          debugPrint('Main Menu TeamNo:$teamNo');
        },
      );
    } catch (e) {
      debugPrint('Error : $e');
    }
    try {
      await _firestore.collection('teams').doc('$teamNo').get().then(
        (event) {
          userTeamName = event.get('teamNm');
          debugPrint('Main Menu TeamNm:$userTeamName');
        },
      );
    } catch (e) {
      debugPrint('Error : $e');
    }
  }

  //to do uidでFirestoreからチーム名を取得する

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NaviBar(),
        appBar: AppBar(
          title: const Text('メインメニュー'),
        ),
        body: Center(
          child: Container(
            width: 400,
            height: 600,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(children: [
                Text('チーム名：$userTeamName'),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: [
                    Column(children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/scheduleReg');
                        },
                        child: const Icon(Icons.calendar_month,
                            size: ICON_MAINMENU_SIZE),
                      ),
                      const Text('配車日程',
                          style:
                              TextStyle(fontSize: ICON_MAINMENU_LAB_FONTSIZE)),
                    ]),
                    Column(children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                        //onPressed: () {
                        //  Navigator.pushNamed(context, '/todo');
                        //},
                        onPressed: null,
                        child: const Icon(Icons.question_mark_rounded,
                            size: ICON_MAINMENU_SIZE),
                      ),
                      const Text('参加回答',
                          style:
                              TextStyle(fontSize: ICON_MAINMENU_LAB_FONTSIZE)),
                    ]),
                    Column(children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/haisya');
                        },
                        //onPressed: null,
                        child: const Icon(Icons.car_repair,
                            size: ICON_MAINMENU_SIZE),
                      ),
                      const Text('配車',
                          style:
                              TextStyle(fontSize: ICON_MAINMENU_LAB_FONTSIZE)),
                    ]),
                    Column(children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/report');
                        },
                        child: const Icon(Icons.calculate_outlined,
                            size: ICON_MAINMENU_SIZE),
                      ),
                      const Text('清算',
                          style:
                              TextStyle(fontSize: ICON_MAINMENU_LAB_FONTSIZE)),
                    ]),
                    Column(children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                        //onPressed: () {
                        //  Navigator.pushNamed(context, '/memReg');
                        //},
                        onPressed: null,
                        child:
                            const Icon(Icons.people, size: ICON_MAINMENU_SIZE),
                      ),
                      const Text('部員登録',
                          style:
                              TextStyle(fontSize: ICON_MAINMENU_LAB_FONTSIZE)),
                    ]),
                    Column(children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                        //onPressed: () {
                        //  Navigator.pushNamed(context, '/todo');
                        //},
                        onPressed: null,
                        child:
                            const Icon(Icons.place, size: ICON_MAINMENU_SIZE),
                      ),
                      const Text('試合球場登録',
                          style:
                              TextStyle(fontSize: ICON_MAINMENU_LAB_FONTSIZE)),
                    ]),
                    Column(children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                        //onPressed: () {
                        //  Navigator.pushNamed(context, '/carReg');
                        //},
                        onPressed: null,
                        child: const Icon(Icons.car_rental,
                            size: ICON_MAINMENU_SIZE),
                      ),
                      const Text('車登録',
                          style:
                              TextStyle(fontSize: ICON_MAINMENU_LAB_FONTSIZE)),
                    ]),
                  ],
                ),
                //SizedBox(height: 40, child: Text('チーム名：$userTeamName')),
              ]),
            ),
          ),
        ));
  }
}
