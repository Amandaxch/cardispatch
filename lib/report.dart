import 'package:flutter/material.dart';
import 'package:cardispatch/data.dart';
import 'package:intl/intl.dart';
import 'package:cardispatch/naviBar.dart';

// class HaisyaPage extends StatefulWidget {
// ステートクラス
class ReportPage extends StatefulWidget {
  ReportPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _ReportPageState createState() => new _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NaviBar(),
      appBar: AppBar(
        title: Text('清算'),
      ),
      body: Center(
        child: TableSample(),
      ),
    );
  }
}

class TableSample extends StatelessWidget {
  const TableSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1200,
        alignment: Alignment.topCenter,
        child: Table(
            border: TableBorder.all(),
            columnWidths: const <int, TableColumnWidth>{
              0: FractionColumnWidth(0.1),
              1: FractionColumnWidth(0.1),
              2: FractionColumnWidth(0.1),
              3: FractionColumnWidth(0.05),
              4: FractionColumnWidth(0.05),
              5: FractionColumnWidth(0.15),
              6: FractionColumnWidth(0.1),
              7: FractionColumnWidth(0.2),
              8: FractionColumnWidth(0.1),
              9: FractionColumnWidth(0.05),
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
            ]));
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
