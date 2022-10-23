import 'package:flutter/material.dart';
import 'package:cardispatch/data.dart';
import 'package:intl/intl.dart';
import 'package:cardispatch/naviBar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';

//int pageKbn = REPORT_PAGE_KBN_MEM;

// class HaisyaPage extends StatefulWidget {
// ステートクラス//
class ReportPage extends StatefulWidget {
  ReportPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _ReportPageState createState() => new _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final List<TabInfo> _tabs = [
    TabInfo("選手", PageMem(reportPageKbn: REPORT_PAGE_KBN_MEM)),
    TabInfo("保護者", PageMem(reportPageKbn: REPORT_PAGE_KBN_PAR)),
    TabInfo("ドライバー", PageMem(reportPageKbn: REPORT_PAGE_KBN_DRV)),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        //drawer: NaviBar(),
        appBar: AppBar(
          title: const Text('清算'),
          bottom: PreferredSize(
            child: TabBar(
              isScrollable: true,
              tabs: _tabs.map((TabInfo tab) {
                return Tab(text: tab.label);
              }).toList(),
            ),
            preferredSize: const Size.fromHeight(30.0),
          ),
        ),
        body: TabBarView(children: _tabs.map((tab) => tab.widget).toList()),
      ),
    );
  }
}

//部員タブ
class PageMem extends StatefulWidget {
  int reportPageKbn = 0;
  PageMem({required this.reportPageKbn});

  //final int pageKbInPara = REPORT_PAGE_KBN_MEM;

  @override
  State<StatefulWidget> createState() => PageMemState();
}

class PageMemState extends State<PageMem> {
  DateTime? _selected;
  //TextEditingController _controller_month = TextEditingController(text: '2022/10');
  TextEditingController _date =
      TextEditingController(text: DateFormat.yMMM('ja').format(DateTime.now()));

  int pageKbn = 0;

  @override
  Widget build(BuildContext context) {
    //Tab区分値は部員の場合

    debugPrint('Page 区分:$pageKbn');

    var enabled;
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: DATE_TEXT_INPUT_WIDTH,
                    child: TextField(
                      controller: _date,
                      textInputAction: TextInputAction.next,
                      enabled: enabled,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // inputの端にカレンダーアイコンをつける
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () =>
                              _onPressed(context: context, locale: 'ja'),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        getTableData(_selected, pageKbn);
                      },
                      child: const Text('検索',
                          style: TextStyle(fontSize: FONT_SIZE)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 10, 0, 0),
                child: Container(
                  color: Colors.blue.shade50,
                  alignment: Alignment.topLeft,
                  child: TableForm(
                    pageKbn,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<void> _onPressed({
    required BuildContext context,
    String? locale,
  }) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: _selected ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
      locale: localeObj,
    );
    debugPrint('Datetime now$selected');
    String formatedDate;

    if (selected != null) {
      setState(() {
        _selected = selected;
        //formatedDate = DateFormat.yMMMEd('ja').format(_selected);
        formatedDate = DateFormat.yMMM('ja').format(selected);
        _date.text = formatedDate;
      });
    }
  }
}

void getTableData(DateTime? selected, int reportKbn) {}

class TableForm extends StatefulWidget {
  const TableForm(int pageKbn, {super.key});

  @override
  State<StatefulWidget> createState() => _TableFormState();
}

class TabInfo {
  String label;
  Widget widget;
  TabInfo(this.label, this.widget);
}

class _TableFormState extends State<TableForm> {
  int kbn = 0;
  get pageKbn => kbn;
  @override
  Widget build(BuildContext context) {
    switch (kbn) {
      case REPORT_PAGE_KBN_MEM:
        return TablePageMem();
      case REPORT_PAGE_KBN_PAR:
        return TablePagePar();
      case REPORT_PAGE_KBN_DRV:
        return TablePageDrv();
      default:
        return TablePageMem();
    }
  }
}

class TablePagePar extends StatelessWidget {
  const TablePagePar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            TableContentPar(),
          ],
        ));
  }
}

class TablePageMem extends StatelessWidget {
  const TablePageMem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            TableContentMember(),
          ],
        ));
  }
}

class TablePageDrv extends StatelessWidget {
  const TablePageDrv({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            TableContentDrv(),
          ],
        ));
  }
}

class TableContentMember extends StatelessWidget {
  const TableContentMember({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
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
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          buildRow(['月', '部員名', '交通費', 'A', 'B', 'C', 'T', 'その他', '備考'],
              isHeader: true),
          buildRow([
            '2022年10月',
            'たかし',
            '￥2,030',
            '￥1,000',
            '￥800',
            '￥1,230',
            '￥0',
            '￥0',
            'なし'
          ], isHeader: false),
        ]);
  }
}

class TableContentPar extends StatelessWidget {
  const TableContentPar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
        border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(1.0),
          2: FlexColumnWidth(1.0),
          3: FlexColumnWidth(1.0),
          4: FlexColumnWidth(1.0),
          5: FlexColumnWidth(1.0),
          6: FlexColumnWidth(1.0),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          buildRow(['月', '家庭', '交通費', '父', '母', 'その他の家族', '備考'],
              isHeader: true),
          buildRow(['2022年10月', '田村家', '￥1,000', '￥0', '￥1,000', '￥0', 'なし'],
              isHeader: false),
        ]);
  }
}

class TableContentDrv extends StatelessWidget {
  const TableContentDrv({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
        border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(1.0),
          2: FlexColumnWidth(1.0),
          3: FlexColumnWidth(1.0),
          4: FlexColumnWidth(1.0),
          5: FlexColumnWidth(1.0),
          6: FlexColumnWidth(1.0),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          buildRow(['月', '家庭名', '合計', '燃料費', '駐車料金', 'そのた', '備考'],
              isHeader: true),
          buildRow(
              ['2022年10月', '田村家', '￥3,000', '￥1,600', '￥1,400', '￥0', 'なし'],
              isHeader: false),
        ]);
  }
}

TableRow buildRow(List<String> cells, {required bool isHeader}) => TableRow(
      children: cells.map((cell) {
        final style = TextStyle(
          fontSize: 12,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        );
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(2),
              child: Center(
                  child: Container(
                child: Text(
                  cell,
                  style: style,
                ),
              )),
            )
          ],
        );
      }).toList(),
    );
