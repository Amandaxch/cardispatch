import 'package:flutter/material.dart';
import 'package:cardispatch/data.dart';
import 'package:intl/intl.dart';
import 'package:cardispatch/naviBar.dart';

// class ScheduleRegPage extends StatefulWidget {
// ステートクラス
class ScheduleRegPage extends StatefulWidget {
  const ScheduleRegPage({super.key});

  @override
  State<ScheduleRegPage> createState() => _ScheduleRegPageState();
}

class _ScheduleRegPageState extends State<ScheduleRegPage> {
  @override
  Widget build(BuildContext context) {
    //チーム
    var dropdownButtonFormField_team = DropdownButtonFormField<String>(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          //borderSide: const BorderSide(width: 3, color: Colors.blue)
        ),
      ),
      value: selectedItem_t,
      items: teamItems
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
        () => selectedItem_t = item,
      ),
    );
    //出発球場
    var dropdownButtonFormField_ground_from = DropdownButtonFormField<String>(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 3, color: Colors.blue)),
      ),
      value: selectedItem_g_from,
      items: groundItems
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
        () => selectedItem_g_from = item,
      ),
    );
    var dropdownButtonFormField_ground_to = DropdownButtonFormField<String>(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          //borderSide: const BorderSide(width: 3, color: Colors.blue)
        ),
      ),
      value: selectedItem_g_to,
      items: groundItems
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
        () => selectedItem_g_to = item,
      ),
    );
    //試合区分
    var dropdownButtonFormField_game = DropdownButtonFormField<String>(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          //borderSide: const BorderSide(width: 3, color: Colors.blue)
        ),
      ),
      value: selectedItem_game,
      items: gameItems
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
        () => selectedItem_game = item,
      ),
    );

    var teamListPullDown = Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
      child: Container(
        height: INPUT_TEXT_HEIGHT,
        child: Row(children: [
          const SizedBox(
            width: LAB_WID_L,
            child: Text(
              'チーム',
              textAlign: TextAlign.left,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: DROP_LIST_TEXT_INPUT_WIDTH,
              child: dropdownButtonFormField_team,
            ),
          ),
        ]),
      ),
    );
    var groundPullDown = Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
      child: Container(
        height: INPUT_TEXT_HEIGHT,
        child: Row(children: [
          const SizedBox(
            width: LAB_WID_L,
            child: Text(
              '出発',
              textAlign: TextAlign.left,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: DROP_LIST_TEXT_INPUT_WIDTH_WIDE,
              child: dropdownButtonFormField_ground_from,
            ),
          ),
        ]),
      ),
    );
    var groundPullDown_to = Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
      child: Container(
        height: INPUT_TEXT_HEIGHT,
        child: Row(children: [
          const SizedBox(
            width: LAB_WID_L,
            child: Text(
              '到着',
              textAlign: TextAlign.left,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: DROP_LIST_TEXT_INPUT_WIDTH_WIDE,
              child: dropdownButtonFormField_ground_to,
            ),
          ),
        ]),
      ),
    );
    var gameListPullDown = Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
      child: Container(
        height: INPUT_TEXT_HEIGHT,
        child: Row(children: [
          const SizedBox(
            width: LAB_WID_L,
            child: Text(
              '試合区分',
              textAlign: TextAlign.left,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: DROP_LIST_TEXT_INPUT_WIDTH_WIDE,
              child: dropdownButtonFormField_game,
            ),
          ),
        ]),
      ),
    );
    var dateDrumRoll = Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 0),
      child: Container(
        height: INPUT_TEXT_HEIGHT,
        child: Row(
          children: [
            const SizedBox(
              width: LAB_WID_L,
              child: Text(
                '移動日',
                style: TextStyle(fontSize: FONT_SIZE),
                textAlign: TextAlign.left,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: DATE_TEXT_INPUT_WIDTH,
                child: TextField(
                  controller: _date,
                  textInputAction: TextInputAction.next,
                  enabled: enabled,
                  //initialValue: '2022/10/15',
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    //hintText: '日付',
                    // inputの端にカレンダーアイコンをつける
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        // textFieldがの値からデフォルトの日付を取得する
                        DateTime initDate = DateTime.now();
                        try {
                          initDate = DateFormat('yyyy/MM/dd').parse(_date.text);
                        } catch (_) {}

                        // DatePickerを表示する
                        DateTime? picked = await showDatePicker(
                          context: context,
                          locale: const Locale("ja"),
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime.now().add(
                            const Duration(days: 360),
                          ),
                        );

                        // DatePickerで取得した日付を文字列に変換
                        String? formatedDate;
                        try {
                          formatedDate =
                              DateFormat.yMMMEd('ja').format(picked!);
                        } catch (_) {}
                        if (formatedDate != null) {
                          _date.text = formatedDate;
                        }
                      },
                    ),
                    // labelText: 'Password',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    var header = <Widget>[
      //行き、帰り球場
      groundPullDown,
      //帰り
      groundPullDown_to,
      //チームリスト
      teamListPullDown,
      //試合区分
      gameListPullDown,
      //距離入力
      distanceInput,
      //日付入力
      dateDrumRoll,
      scheNmInput,
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
              addSchedule();
            },
            child: const Text('登録', style: TextStyle(fontSize: FONT_SIZE)),
          ),
        ),
      ),
    ];
    return Scaffold(
      drawer: NaviBar(),
      appBar: AppBar(
        title: Text('日程登録'),
      ),
      body: Center(
        child: Column(
          children: header,
        ),
      ),
    );
  }

//DB登録処理
  void addSchedule() {
    scheduleList.add(Schedule(
      groundFrom: 1,
      groundTo: 1,
      dt: '',
      team: 1,
      distance: 1,
      schNm: 'name',
    ));
  }
}

var enabled;
String? selectedItem_t = teamItems[0];
String? selectedItem_g_from = groundItems[0];
String? selectedItem_g_to = groundItems[0];
String? selectedItem_game = gameItems[0];
TextEditingController _date = TextEditingController(
    text:
        DateFormat.yMMMEd('ja').format(DateTime.now().add(Duration(days: 1))));
TextEditingController _controller_distance = TextEditingController(text: '10');
TextEditingController _controller_note = TextEditingController(text: '');

var distanceInput = Padding(
  padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
  child: Container(
    height: INPUT_TEXT_HEIGHT,
    child: Row(
      children: [
        const SizedBox(
          width: LAB_WID_L,
          child: Text(
            '片道距離',
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
            controller: _controller_distance,
            style: const TextStyle(
              fontSize: FONT_SIZE,
              height: 1.5,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text('km'),
        ),
      ],
    ),
  ),
);
var scheNmInput = Padding(
  padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
  child: Container(
    height: INPUT_TEXT_HEIGHT,
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
              hintText: "例：さわやか一回戦 vs 〇〇",
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
  ),
);
