// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

enum PlayerType {
  parent,
  member,
  coach,
  ob,
}

//清算ページのタブ区分
const REPORT_PAGE_KBN_MEM = 0; //部員
const REPORT_PAGE_KBN_PAR = 1; //保護者
const REPORT_PAGE_KBN_DRV = 2; //ドライバー

const double INPUT_TEXT_HEIGHT = 50.0;
const double CAR_SEAT_H = 40.0;
const double CAR_SEAT_W = 70.0;
const double MEM_BOX_H = 30.0;
const double MEM_BOX_W = 75.0;
const double LAB_WID_L = 80.0;
const double FONT_SIZE = 12.0;
const double BUTTON_SIZE_W = 90.0;
const double BUTTON_SIZE_H = 35.0;
const DROP_LIST_TEXT_INPUT_WIDTH = 150.0;
const DROP_TEAMLIST = 200.0;
const REG_TEAMNM_LAB_W = 100.0;
const DROP_LIST_TEXT_INPUT_WIDTH_WIDE = 300.0;
const DROP_LIST_TEXT_INPUT_WIDTH_MAXWIDE = 500.0;

const DATE_TEXT_INPUT_WIDTH = 240.0;
const double ICON_MAINMENU_SIZE = 60;
const double ICON_MAINMENU_LAB_FONTSIZE = 12;
const int MEMBER_KBN_BOY = 0;
const int MEMBER_KBN_PAR = 1;
String userTeamName = 'チーム名未設定';

List<String> gradeItems = [
  '一年生',
  '二年生',
  '三年生',
  '四年生',
  '五年生',
  '六年生',
  '年長',
  '年中',
  'その他'
];
List<String> capacityItems = ['5', '6', '7', '8', '10', '4', '3', '2', '15'];
List<String> teamItems = ['A', 'B', 'C', 'T', 'トス', 'その他'];
List<String> groundItems = [
  '東方鍛錬場',
  '牛久保西公園',
  '早渕公園',
  '東方公園',
  '市場小学校（鶴見区）',
  '未定'
];
List<String> gameItems = [
  'さわやかカップ',
  '区大会',
  '練習試合',
  'わかばジュニア',
  'ybbl',
  '小泉杯',
  '県小連',
  '親善大会',
  'ベイスターズ',
  'その他'
];

final scheduleList = [
  Schedule(
    groundFrom: 5,
    groundTo: 5,
    dt: '2022/10/20',
    team: 0,
    distance: 10,
    schNm: 'さわやかA一回戦 VS シャークス',
  ),
  Schedule(
    groundFrom: 1,
    groundTo: 4,
    dt: '2022/10/21',
    team: 1,
    distance: 18,
    schNm: 'さわやかB一回戦 VS イーグルス',
  ),
];

class Schedule {
  int groundFrom = 0;
  int groundTo = 0;
  String dt = '2022/10/01';
  int team = 0;
  int distance = 10;
  String schNm;
  Schedule({
    required this.groundFrom,
    required this.groundTo,
    required this.dt,
    required this.team,
    required this.distance,
    required this.schNm,
  });
}

class Team {
  String teamNo;
  String teamName;
  Team({
    required this.teamNo,
    required this.teamName,
  });
}

List<Team> teams = [];

class Member {
  int grade = 9999;
  int number = 9999;
  String name;
  final PlayerType type;

  Member({
    required this.grade,
    required this.number,
    required this.name,
    required this.type,
  });
}

class Parent {
  int sensyu_no = 9999;
  String name;
  int grade = 9999;

  Parent({
    required this.sensyu_no,
    required this.name,
    required this.grade,
  });
}

class Car {
  int teiin = 5;
  int nenpi = 30;
  int owner = 99;
  String name;
  int toolMinus = 3;
  Car({
    required this.teiin,
    required this.nenpi,
    required this.owner,
    required this.name,
  });
}

final allCars = [
  Car(
    teiin: 5,
    nenpi: 30,
    owner: 61,
    name: '',
  ),
  Car(
    teiin: 7,
    nenpi: 30,
    owner: 62,
    name: '高橋カー',
  ),
  Car(
    teiin: 5,
    nenpi: 30,
    owner: 63,
    name: '佐藤カー',
  ),
];
var divider = Divider(
  thickness: 2.0,
  color: Colors.blue, /*区切り線*/
);
var dividerLight = Divider(
  thickness: 0.0,
  indent: 10.0,
  endIndent: 10.0,
  color: Colors.lightBlue, /*区切り線*/
);

final Map<int, String> carMap = {
  63: '佐藤カー',
  62: '高橋カー',
  61: '田中カー',
};
final Map<int, Color> colorMap = {
  1: Colors.orange.shade200,
  2: Colors.pink.shade100,
  3: Color.fromARGB(255, 155, 148, 224),
  4: Colors.green.shade100,
  5: Colors.cyan.shade100,
  6: Color.fromARGB(201, 3, 140, 252),
  88: Colors.amber.shade100, //保護者
  99: Colors.white60,
};
final allParents = [
  Parent(
    sensyu_no: 24,
    name: '24郎母',
    grade: 88,
  ),
  Parent(
    sensyu_no: 25,
    name: '25郎父',
    grade: 88,
  ),
  Parent(
    sensyu_no: 23,
    name: '23郎父',
    grade: 88,
  ),
  Parent(
    sensyu_no: 14,
    name: '14郎父',
    grade: 88,
  ),
  Parent(
    sensyu_no: 32,
    name: '田中父',
    grade: 88,
  ),
  Parent(
    sensyu_no: 32,
    name: '田中母',
    grade: 88,
  ),
  Parent(
    sensyu_no: 34,
    name: '高橋父',
    grade: 88,
  ),
  Parent(
    sensyu_no: 34,
    name: '高橋母',
    grade: 88,
  ),
];
final allMembers = [
  Member(
    grade: 1,
    number: 34,
    name: '高橋ヒカル',
    type: PlayerType.member,
  ),
  Member(
    grade: 1,
    number: 33,
    name: '工藤新一',
    type: PlayerType.member,
  ),
  Member(
    grade: 1,
    number: 32,
    name: '田中一郎',
    type: PlayerType.member,
  ),
  Member(
    grade: 2,
    number: 31,
    name: '吉田健',
    type: PlayerType.member,
  ),
  Member(
    grade: 2,
    number: 30,
    name: '町田啓太',
    type: PlayerType.member,
  ),
  Member(
    grade: 4,
    number: 29,
    name: 'テルマ',
    type: PlayerType.member,
  ),
  Member(
    grade: 4,
    number: 28,
    name: '仲隆志',
    type: PlayerType.member,
  ),
  Member(
    grade: 4,
    number: 27,
    name: 'Smith',
    type: PlayerType.member,
  ),
  Member(
    grade: 4,
    number: 26,
    name: '佐藤達也',
    type: PlayerType.member,
  ),
  Member(
    grade: 3,
    number: 25,
    name: '二郎',
    type: PlayerType.member,
  ),
  Member(
    grade: 2,
    number: 24,
    name: '楓',
    type: PlayerType.member,
  ),
  Member(
    grade: 4,
    number: 23,
    name: '健翔',
    type: PlayerType.member,
  ),
  Member(
    grade: 3,
    number: 22,
    name: '3年生郎',
    type: PlayerType.member,
  ),
  Member(
    grade: 4,
    number: 21,
    name: '4年生郎',
    type: PlayerType.member,
  ),
  Member(
    grade: 5,
    number: 20,
    name: '5年生郎',
    type: PlayerType.member,
  ),
  Member(
    grade: 6,
    number: 19,
    name: '6年生郎',
    type: PlayerType.member,
  ),
];
