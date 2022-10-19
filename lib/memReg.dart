import 'package:flutter/material.dart';
import 'package:cardispatch/data.dart';
import 'package:cardispatch/naviBar.dart';

// class ScheduleRegPage extends StatefulWidget {
// ステートクラス
class MemberRegPage extends StatefulWidget {
  MemberRegPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MemberRegPageState createState() => new _MemberRegPageState();
}

class _MemberRegPageState extends State<MemberRegPage> {
  @override
  Widget build(BuildContext context) {
    var header = <Widget>[
      //学年
      gradeListPullDown,
      //名前入力
      nameInput,
      numberInput,
      noteInput,
      //横線
      divider,
      Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: SizedBox(
          width: BUTTON_SIZE_W,
          height: BUTTON_SIZE_H,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
            ),
            onPressed: () {
              addMember();
            },
            child: const Text('登録', style: TextStyle(fontSize: FONT_SIZE)),
          ),
        ),
      ),
    ];
    return Scaffold(
      drawer: NaviBar(),
      appBar: AppBar(
        title: Text('部員登録'),
      ),
      body: Center(
        child: Column(
          children: header,
        ),
      ),
    );
  }

  //DB登録 部員
  void addMember() {
    allMembers
        .add(Member(grade: 1, name: '', number: 29, type: PlayerType.member));
  }
}

String? selectedItem_grade = gradeItems[0];
TextEditingController _controller_name = TextEditingController(text: '');
TextEditingController _controller_note = TextEditingController(text: '');
TextEditingController _controller_number = TextEditingController(text: '');
var dropdownButtonFormField_grade = DropdownButtonFormField<String>(
  decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 3, color: Colors.blue)),
  ),
  value: selectedItem_grade,
  items: gradeItems
      .map((item) => DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(item, style: const TextStyle(fontSize: FONT_SIZE)),
            ),
          ))
      .toList(),
  onChanged: (item) => setState(
    () => selectedItem_grade = item,
  ),
);
setState(String? Function() value) {}

var nameInput = Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: [
      const SizedBox(
        width: LAB_WID_L,
        child: Text(
          '名前',
          style: TextStyle(fontSize: FONT_SIZE),
          textAlign: TextAlign.left,
        ),
      ),
      SizedBox(
        width: DROP_LIST_TEXT_INPUT_WIDTH,
        child: TextField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            //Focusしているとき
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 3.0,
              ),
            ),
          ),
          controller: _controller_name,
          style: const TextStyle(
            fontSize: FONT_SIZE,
            height: 1.5,
          ),
        ),
      ),
    ],
  ),
);
var noteInput = Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: [
      const SizedBox(
        width: LAB_WID_L,
        child: Text(
          '備考',
          style: TextStyle(fontSize: FONT_SIZE),
          textAlign: TextAlign.left,
        ),
      ),
      SizedBox(
        width: DROP_LIST_TEXT_INPUT_WIDTH_MAXWIDE,
        child: TextField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            //Focusしているとき
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 3.0,
              ),
            ),
            hintText: "備考",
          ),
          controller: _controller_note,
          style: const TextStyle(
            fontSize: FONT_SIZE,
            height: 1.5,
          ),
        ),
      ),
    ],
  ),
);
var numberInput = Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: [
      const SizedBox(
        width: LAB_WID_L,
        child: Text(
          '背番号',
          style: TextStyle(fontSize: FONT_SIZE),
          textAlign: TextAlign.left,
        ),
      ),
      SizedBox(
        width: DROP_LIST_TEXT_INPUT_WIDTH,
        child: TextField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            //Focusしているとき
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 3.0,
              ),
            ),
            hintText: "背番号",
          ),
          controller: _controller_number,
          style: const TextStyle(
            fontSize: FONT_SIZE,
            height: 1.5,
          ),
        ),
      ),
    ],
  ),
);

var gradeListPullDown = Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(children: [
    const SizedBox(
      width: LAB_WID_L,
      child: Text(
        '学年',
        textAlign: TextAlign.left,
      ),
    ),
    Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        width: DROP_LIST_TEXT_INPUT_WIDTH,
        child: dropdownButtonFormField_grade,
      ),
    ),
  ]),
);
