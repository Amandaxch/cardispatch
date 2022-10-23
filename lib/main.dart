import 'dart:ui';

import 'package:cardispatch/RegisterPage.dart';
import 'package:cardispatch/authError.dart';
import 'package:cardispatch/carReg.dart';
import 'package:cardispatch/data.dart';
import 'package:cardispatch/haisya.dart';
import 'package:cardispatch/login.dart';
import 'package:cardispatch/mainMenu.dart';
import 'package:cardispatch/memReg.dart';
import 'package:cardispatch/notApproved.dart';
import 'package:cardispatch/report.dart';
import 'package:cardispatch/scheduleReg.dart';
import 'package:cardispatch/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:month_year_picker/month_year_picker.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(

  );
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // FirebaseUserのログイン状態が確定するまで待つ
  //final firebaseUser = await FirebaseAuth.instance.userChanges().first;

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int stateLogin = 0;
  var currentUser;
  late Future<void> _future;
  @override
  void initState() {
    super.initState();
    _future = iniTeams();
  }

  Future iniTeams() async {
    QuerySnapshot collection =
        await FirebaseFirestore.instance.collection('teams').get();
    var teamlist = collection.docs
        .map((doc) => Team(teamNo: doc['teamNo'], teamName: doc['teamNm']))
        .toList();
    // ignore: unnecessary_this
    teams = teamlist;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ja'),
      ],
      title: '少年野球・サッカー配車Webアプリ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const LoginPage(),
        '/login': (context) => const LoginPage(),
        '/regis': (context) => const RegisterPage(),
        '/mainMenu': (context) => MainMenu(),
        '/haisya': (context) => HaisyaPage(),
        '/todo': (context) => TodoPage(title: '作成中'),
        '/scheduleReg': (context) => const ScheduleRegPage(),
        '/memReg': (context) => MemberRegPage(title: '部員登録'),
        '/carReg': (context) => CarRegPage(title: '車登録'),
        '/report': (context) => ReportPage(title: '清算'),
        '/notApproved': (context) => NotApprovedPage(title: '管理者承認待ち'),
      },
    );
  }
}

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Topページ'),
      ),
      body: SafeArea(
        bottom: false,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Text(
                  'ログインページへ',
                  style: TextStyle(color: Colors.black),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              SizedBox(
                width: 40,
              ),
              TextButton(
                child: Text(
                  'ユーザ登録へ',
                  style: TextStyle(color: Colors.black),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/regis');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
