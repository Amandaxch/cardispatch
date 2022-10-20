//import 'package:cloud_firestore/cloud_firestore.dart';
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
        //drawer: NaviBar(),
        appBar: AppBar(
          title: Text('メインメニュー'),
        ),
        body: GridView.count(
          crossAxisCount: 3,
          children: [
            Container(
                child: Column(children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                ),
                onPressed: () {
                  //Navigator.pushNamed(context));
                  /*Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ScheduleRegPage(
                          title: '配車日程',
                        );
                      },
                    ),
                  );*/
                },
                child: Icon(Icons.calendar_month, size: 80),
              ),
              Text('配車日程', style: const TextStyle(fontSize: 18)),
            ])),
            Container(
                child: Column(children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, '/todo');
                },
                child: Icon(Icons.question_mark_rounded, size: 80),
              ),
              Text('参加回答', style: const TextStyle(fontSize: 18)),
            ])),
            Container(
                child: Column(children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, '/haisya');
                },
                child: Icon(Icons.car_repair, size: 80),
              ),
              Text('配車', style: const TextStyle(fontSize: 18)),
            ])),
            Container(
                child: Column(children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, '/report');
                },
                child: Icon(Icons.calculate_outlined, size: 80),
              ),
              Text('清算', style: const TextStyle(fontSize: 18)),
            ])),
            Container(
                child: Column(children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, '/memReg');
                },
                child: Icon(Icons.people, size: 80),
              ),
              Text('部員登録', style: const TextStyle(fontSize: 18)),
            ])),
            Container(
                child: Column(children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, '/todo');
                },
                child: Icon(Icons.place, size: 80),
              ),
              Text('試合球場登録', style: const TextStyle(fontSize: 18)),
            ])),
            Container(
                child: Column(children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, '/carReg');
                },
                child: Icon(Icons.car_rental, size: 80),
              ),
              Text('車登録', style: const TextStyle(fontSize: 18)),
            ])),
          ],
        ));
  }
}
