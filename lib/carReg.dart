import 'package:flutter/material.dart';
import 'package:cardispatch/data.dart';
import 'package:cardispatch/naviBar.dart';
import 'package:flutter/material.dart';

// class ScheduleRegPage extends StatefulWidget {
// ステートクラス
class CarRegPage extends StatefulWidget {
  CarRegPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _CarRegPageState createState() => new _CarRegPageState();
}

class _CarRegPageState extends State<CarRegPage> {
  String? selectedItem_cap = '5';
  String? selectedItem_member = 'テルマ';
  @override
  Widget build(BuildContext context) {
    var dropdownButtonFormField_capacity = DropdownButtonFormField<String>(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 3, color: Colors.blue)),
      ),
      value: selectedItem_cap,
      items: capacityItems
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child:
                      Text(item, style: const TextStyle(fontSize: FONT_SIZE)),
                ),
              ))
          .toList(),
      onChanged: (item) => setState(
        () => selectedItem_cap = item,
      ),
    );

    var capacityListPullDown = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        const SizedBox(
          width: LAB_WID_L,
          child: Text(
            '定員数',
            textAlign: TextAlign.left,
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: DROP_LIST_TEXT_INPUT_WIDTH,
            child: dropdownButtonFormField_capacity,
          ),
        ),
      ]),
    );

    var dropdownButtonFormField_member = DropdownButtonFormField<String>(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          //borderSide: const BorderSide(width: 3, color: Colors.blue)
        ),
      ),
      value: selectedItem_member,
      items: allMembers
          .map((item) => DropdownMenuItem<String>(
                value: item.name,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(item.name,
                      style: const TextStyle(fontSize: FONT_SIZE)),
                ),
              ))
          .toList(),
      onChanged: (item) => setState(
        () => selectedItem_member = item,
      ),
    );

    var memberListPullDown = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        const SizedBox(
          width: LAB_WID_L,
          child: Text(
            '部員名',
            textAlign: TextAlign.left,
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: DROP_LIST_TEXT_INPUT_WIDTH,
            child: dropdownButtonFormField_member,
          ),
        ),
      ]),
    );
    var header = <Widget>[
      //部員
      memberListPullDown,
      //車名前入力
      carNameInput,
      //定員数
      capacityListPullDown,
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
              allCars.add(Car(
                teiin: 5,
                nenpi: 5,
                owner: 29,
                name: '田中カー',
              ));
            },
            child: const Text('登録', style: TextStyle(fontSize: FONT_SIZE)),
          ),
        ),
      ),
    ];
    return Scaffold(
      drawer: NaviBar(),
      appBar: AppBar(
        title: Text('車登録'),
      ),
      body: Center(
        child: Column(
          children: header,
        ),
      ),
    );
  }
}

TextEditingController _controller_car_name = TextEditingController(text: '');

var carNameInput = Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: [
      const SizedBox(
        width: LAB_WID_L,
        child: Text(
          '車名',
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
            hintText: "例：佐藤カー",
          ),
          controller: _controller_car_name,
          style: const TextStyle(
            fontSize: FONT_SIZE,
            height: 1.5,
          ),
        ),
      ),
    ],
  ),
);
