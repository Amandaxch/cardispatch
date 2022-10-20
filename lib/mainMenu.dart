//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cardispatch/data.dart';
import 'package:cardispatch/scheduleReg.dart';
import 'package:flutter/material.dart';
import 'package:cardispatch/naviBar.dart';

// MyHomePage ウィジェットクラス

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var db = FirebaseFirestore.instance;
    debugPrint("MainMenu Start");
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
              child: GridView.count(
                crossAxisCount: 3,
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
                        style: TextStyle(fontSize: ICON_MAINMENU_LAB_FONTSIZE)),
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
                        style: TextStyle(fontSize: ICON_MAINMENU_LAB_FONTSIZE)),
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
                        style: TextStyle(fontSize: ICON_MAINMENU_LAB_FONTSIZE)),
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
                        style: TextStyle(fontSize: ICON_MAINMENU_LAB_FONTSIZE)),
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
                      child: const Icon(Icons.people, size: ICON_MAINMENU_SIZE),
                    ),
                    const Text('部員登録',
                        style: TextStyle(fontSize: ICON_MAINMENU_LAB_FONTSIZE)),
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
                      child: const Icon(Icons.place, size: ICON_MAINMENU_SIZE),
                    ),
                    const Text('試合球場登録',
                        style: TextStyle(fontSize: ICON_MAINMENU_LAB_FONTSIZE)),
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
                        style: TextStyle(fontSize: ICON_MAINMENU_LAB_FONTSIZE)),
                  ]),
                ],
              ),
            ),
          ),
        ));
  }
}
