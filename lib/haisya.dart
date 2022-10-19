import 'package:flutter/material.dart';
import 'package:cardispatch/data.dart';

//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:cardispatch/naviBar.dart';

enum RadioValue { FIRST, SECOND }

void dispose(Widget wg) {}
Widget setWidgetName(Widget wg, bool empty) {
  if (empty == true) {
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      return Container(
        width: MEM_BOX_W,
        height: MEM_BOX_H,
        margin: const EdgeInsets.fromLTRB(10.0, 0, 0, 2),
        color: Colors.grey[400],
        child: Center(
            child: Text('',
                style: const TextStyle(fontSize: 15, color: Colors.grey))),
      );
    });
  } else {
    return Container();
  }
  throw '';
}

Widget buildWidgets(
  dynamic BuildContext, {
  required String text,
  required String syusekiFlg,
}) {
  String acceptedData = '空き'; // 受け側のデータ
  bool willAccepted = false; // Target範囲内かどうかのフラグ
  bool empty = true; //空席
  int grade = 99;
  //const IconData sports_baseball_outlined = IconData(0xf3c7, fontFamily: 'MaterialIcons');
  return SizedBox(
      width: CAR_SEAT_W,
      height: CAR_SEAT_H,
      child: DragTarget(
        builder: (context, candidateData, rejectedData) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: willAccepted ? Colors.blue : Colors.grey,
                width: willAccepted ? 3 : 1,
              ),
              color: colorMap[grade],
            ),
            margin: const EdgeInsets.all(1.0),
            width: CAR_SEAT_W,
            height: CAR_SEAT_H,
            child: Center(
                child:
                    Text(acceptedData, style: const TextStyle(fontSize: 12))),
          );
        },
        onWillAccept: (data) {
          willAccepted = true;
          if (acceptedData == '空き') {
            return true;
          } else {
            return false;
          }
        },
        onAccept: (List data) {
          if (data[0] == MEMBER_KBN_BOY) {
            acceptedData = allMembers[data[1]].name;
            grade = allMembers[data[1]].grade;
          } else if (data[0] == MEMBER_KBN_PAR) {
            acceptedData = allParents[data[1]].name;
            grade = allParents[data[1]].grade;
          }
          willAccepted = false;
          empty = false;
        },
        onLeave: (data) {
          willAccepted = false;
        },
      ));
}

// class HaisyaPage extends StatefulWidget {
// ステートクラス
class HaisyaPage extends StatefulWidget {
  HaisyaPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _HaisyaPageState createState() => new _HaisyaPageState();
}

class _HaisyaPageState extends State<HaisyaPage> {
  @override
  Widget build(BuildContext context) {
    var boys = <Widget>[
      for (int i = 0; i < allMembers.length; i++)
        //SizedBox(width: 20,),
        buildDraggable(MEMBER_KBN_BOY, i),
    ];

    var parentWidget = <Widget>[
      for (int i = 0; i < allParents.length; i++)
        //SizedBox(width: 20,),
        buildDraggable(MEMBER_KBN_PAR, i),
    ];

    var mainWidget = <Widget>[
      // 車のWidget生成
      for (int i = 0; i < allCars.length; i++)
        Column(
          children: [
            Row(
              children: [
                //車名
                //Text(carMap[allCars[i].owner]!),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: CAR_SEAT_H,
                    width: LAB_WID_L,
                    child: Text(
                      carMap[allCars[i].owner]!,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                for (int j = 0; j < allCars[i].teiin; j++)
                  buildWidgets(BuildContext, text: '空', syusekiFlg: '1'),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: LAB_WID_L,
                ),
                radioButtonRow(i),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: LAB_WID_L,
                ),
                radioButtonRowOneWay(i),
              ],
            ),
          ],
        ),
      //radioButtonWidget(),
      const SizedBox(height: 5.0),
      divider,
      // 選手のWidget生成
      SizedBox(
        width: double.infinity,
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const SizedBox(
                height: 30.0,
                width: LAB_WID_L,
                child: Text(
                  '選手',
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Wrap(
                //選手枠
                children: boys),
          ],
        ),
      ),
      dividerLight,
      // 保護者のWidget生成
      SizedBox(
        width: double.infinity,
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const SizedBox(
                height: 30.0,
                width: LAB_WID_L,
                child: Text(
                  '保護者',
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Wrap(
                //mainAxisAlignment: MainAxisAlignment.start,
                //選手枠
                children: parentWidget),
          ],
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.orange,
          ),
          onPressed: () {
            addHaisya();
          },
          child: const Text('保存'),
        ),
      ),
      divider,
      Container(
        width: 300.0,
        height: 150,
        color: Colors.white,
        child: const Text('@Copyright'),
      ),
    ];
    return Scaffold(
      drawer: NaviBar(),
      appBar: AppBar(
        title: Text('配車'),
      ),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: mainWidget,
            ),
          ),
        ),
      ),
    );
  }

//選手、保護者のWidget作成
//引数 kbn:区分値 0:選手;1:保護者
  Draggable<List<int>> buildDraggable(int kbn, int i) {
    String name = '';
    int grade = 0;
    if (kbn == MEMBER_KBN_BOY) {
      //選手の場合
      name = allMembers[i].name;
      grade = allMembers[i].grade;
    } else if (kbn == MEMBER_KBN_PAR) {
      //保護者の場合
      name = allParents[i].name;
      grade = allParents[i].grade;
    }
    return Draggable(
      data: [kbn, i],
      feedback: Container(
        width: MEM_BOX_W,
        height: MEM_BOX_H,
        margin: const EdgeInsets.fromLTRB(10.0, 0, 0, 2),
        color: colorMap[grade],
        child: Center(
            child: Text(name,
                style: const TextStyle(color: Colors.black, fontSize: 16))),
      ),
      childWhenDragging: Container(
        width: MEM_BOX_W,
        height: MEM_BOX_H,
        margin: const EdgeInsets.fromLTRB(10.0, 0, 0, 2),
        color: Colors.grey[400],
        child: Center(
            child: Text(name,
                style: const TextStyle(fontSize: 15, color: Colors.grey))),
      ),
      onDragCompleted: () {
        setWidgetName(widget, true);
        debugPrint("DEBUG: Draggable.onDragCompleted.");
      },
      onDragEnd: (details) {
        setWidgetName(widget, true);
        debugPrint("DEBUG: Draggable.onDragEnd.");
      },
      child: Container(
        width: MEM_BOX_W,
        height: MEM_BOX_H,
        margin: const EdgeInsets.fromLTRB(10.0, 0, 0, 2),
        color: colorMap[grade],
        child: Center(child: Text(name, style: const TextStyle(fontSize: 15))),
      ),
    );
  }

  bool _checkBox = false;
  void _handleOnCheck(bool? value) {
    setState(() {
      _checkBox = value!;
    });
    if (value == true) setWidgetTool();
  }

  Widget radioButtonRow(int carNo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            children: [
              Radio(
                value: 0,
                groupValue: 0,
                onChanged: (value) {},
              ),
              Icon(
                Icons.boy_outlined,
                color: Colors.blue,
              ),
              Text('選手カー')
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            children: [
              Radio(
                value: 1,
                groupValue: 0,
                onChanged: (value) => _onRadioSelectedCarType(value),
              ),
              Icon(
                Icons.man_outlined,
                color: Colors.blue,
              ),
              Text('保護者カー')
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            children: [
              Checkbox(
                activeColor: Colors.blue, // Onになった時の色を指定
                value: _checkBox, // チェックボックスのOn/Offを保持する値
                onChanged: _handleOnCheck, // チェックボックスを押下した際に行う処理
              ),
              Icon(
                Icons.sports_baseball_outlined,
                color: Colors.blue,
              ),
              Text('道具カー'),
            ],
          ),
        ),
      ],
    );
  }

  Widget radioButtonRowOneWay(int carNo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            children: [
              Radio(
                value: 0,
                groupValue: 0,
                onChanged: (value) {},
              ),
              Icon(
                Icons.boy_outlined,
                color: Colors.blue,
              ),
              Text('往復')
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            children: [
              Radio(
                value: 1,
                groupValue: 0,
                onChanged: (value) => _onRadioSelectedOneWay(value),
              ),
              Icon(
                Icons.man_outlined,
                color: Colors.blue,
              ),
              Text('片道')
            ],
          ),
        ),
      ],
    );
  }

  RadioValue _gValueCarType = RadioValue.FIRST;
  _onRadioSelectedCarType(int? value) {
    setState(() {
      _gValueCarType = value as RadioValue;
    });
  }

  RadioValue _gValueOneWay = RadioValue.FIRST;
  _onRadioSelectedOneWay(int? value) {
    setState(() {
      _gValueCarType = value as RadioValue;
    });
  }

  void setWidgetTool() {}

  void addHaisya() {}
}
