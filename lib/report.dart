import 'package:flutter/material.dart';
import 'package:cardispatch/data.dart';
import 'package:intl/intl.dart';
import 'package:cardispatch/naviBar.dart';

TextEditingController _date =
    TextEditingController(text: DateFormat.yMMM('ja').format(DateTime.now()));
var enabled;

// class HaisyaPage extends StatefulWidget {
// ステートクラス
class ReportPage extends StatefulWidget {
  ReportPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _ReportPageState createState() => new _ReportPageState();
}

class PageMem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          child: TableSample(),
        )
      ],
    );
  }
}

class PagePar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          child: TableSample(),
        )
      ],
    );
  }
}

class PageDrv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          child: TableSample(),
        )
      ],
    );
  }
}

class _ReportPageState extends State<ReportPage> {
  final List<TabInfo> _tabs = [
    TabInfo("選手", PageMem()),
    TabInfo("保護者", PagePar()),
    TabInfo("ドライバー", PageDrv()),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        //drawer: NaviBar(),
        appBar: AppBar(
          title: Text('清算'),
          bottom: PreferredSize(
            child: TabBar(
              isScrollable: true,
              tabs: _tabs.map((TabInfo tab) {
                return Tab(text: tab.label);
              }).toList(),
            ),
            preferredSize: Size.fromHeight(30.0),
          ),
        ),
        body: TabBarView(children: _tabs.map((tab) => tab.widget).toList()),
      ),
    );
    //body: Center(
    //  child: TableSample(),
    //),
    //);
  }
}

class TableSample extends StatefulWidget {
  const TableSample({super.key});

  @override
  State<StatefulWidget> createState() => _TableState();
}

class TabInfo {
  String label;
  Widget widget;
  TabInfo(this.label, this.widget);
}

class _TableState extends State<TableSample> {
  @override
  Widget build(BuildContext context) {
    var dateDrumRoll = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const SizedBox(
            width: LAB_WID_L,
            child: Text(
              '清算月',
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
                        formatedDate = DateFormat.yMMMEd('ja').format(picked!);
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
    );
    return Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            dateDrumRoll,
            Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  0: IntrinsicColumnWidth(),
                  1: FlexColumnWidth(1.0),
                  2: FlexColumnWidth(1.0),
                  3: FlexColumnWidth(1.0),
                  4: FlexColumnWidth(1.0),
                  5: FlexColumnWidth(1.0),
                  6: FlexColumnWidth(1.0),
                  7: FlexColumnWidth(1.0),
                  8: FlexColumnWidth(1.0),
                  9: FlexColumnWidth(1.0),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: <TableRow>[
                  buildRow([
                    '月',
                    '日付',
                    '車',
                    '距離',
                    '燃料費',
                    '駐車料金',
                    'その他の費用',
                    '配車名',
                    '試合区分',
                    '備考'
                  ], isHeader: true),
                  buildRow([
                    '2022年10月',
                    '2022/10/1',
                    '加藤カー',
                    '10',
                    '800',
                    '1,000',
                    '0',
                    'さわやかB vs ライオンズ',
                    'B',
                    'なし'
                  ]),
                ]),
          ],
        ));
  }
}

TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
      children: cells.map((cell) {
        final style = TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 18,
        );
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Center(child: Text(cell)),
        );
      }).toList(),
    );
