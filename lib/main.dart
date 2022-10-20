import 'dart:ui';

import 'package:cardispatch/RegisterPage.dart';
import 'package:cardispatch/authError.dart';
import 'package:cardispatch/carReg.dart';
import 'package:cardispatch/haisya.dart';
import 'package:cardispatch/mainMenu.dart';
import 'package:cardispatch/memReg.dart';
import 'package:cardispatch/report.dart';
import 'package:cardispatch/scheduleReg.dart';
import 'package:cardispatch/todo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDPl3Snp2wHJV-swFnphq_CTE1x8jI79L0",
        authDomain: "baseball-rf.firebaseapp.com",
        projectId: "baseball-rf",
        storageBucket: "baseball-rf.appspot.com",
        messagingSenderId: "220563805936",
        appId: "1:220563805936:web:e2bce2dd85839938c9d435",
        measurementId: "G-Y45DXELGF0"),
  );
  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '少年野球・サッカー配車Webアプリ',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          // 初期画面のclassを指定
          '/': (context) => const MyWidget(),
          // 次ページのclassを指定
/*
          '/mainMenu': (context) => MainMenu(),
          '/haisya': (context) => HaisyaPage(title: '配車'),
          '/todo': (context) => TodoPage(title: '作成中'),
          '/scheduleReg': (context) => ScheduleRegPage(title: '配車日程登録'),
          '/memReg': (context) => MemberRegPage(title: '部員登録'),
          '/carReg': (context) => CarRegPage(title: '車登録'),
          '/report': (context) => ReportPage(title: '清算'),*/
        });
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // メッセージ表示用
  String infoText = '';
  // 入力したメールアドレス・パスワード
  String email = '';
  String password = '';
  TextStyle linkStyle = const TextStyle(color: Colors.blue, fontSize: 12);
  final auth_error = Authentication_error_to_ja();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: NaviBar(),
      //appBar: AppBar(
      //  title: const Text('ホーム'),
      //),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: 400,
          height: 600,
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  '少年野球・サッカー',
                  style: TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(255, 13, 101, 173),
                  ),
                  textAlign: TextAlign.center,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 100),
                  child: Text(
                    '配車支援Webアプリ',
                    style: TextStyle(
                      fontSize: 26,
                      //fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Color.fromARGB(255, 1, 87, 155),
                      //fontFamily: 'Cursive',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                // メールアドレス入力
                SizedBox(
                  width: 250,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'メールアドレス', border: OutlineInputBorder()),
                    onChanged: (String value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                ),
                // パスワード入力
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    width: 250,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'パスワード', border: OutlineInputBorder()),
                      obscureText: true,
                      onChanged: (String value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  // メッセージ表示
                  child: Text(infoText,
                      style: const TextStyle(fontSize: 12, color: Colors.red)),
                ),
                ElevatedButton(
                  child: const Text('ログイン'),
                  onPressed: () async {
                    try {
                      // メール/パスワードでログイン
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      UserCredential _result =
                          await auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      // ログイン成功
                      User _user = _result.user!; // ログインユーザーのIDを取得

                      // Email確認が済んでいる場合のみHome画面へ
                      /*if (_user.emailVerified) {
                        debugPrint("CARDISPATCH_user email verified");
                        await Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(
                          builder: (context) => MainMenu(),
                          //Home(user_id: _user.uid, auth: _auth),
                        ));
                      }
                      */

                      /*
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MainMenu()),
                      );
                      */
                    } catch (e) {
                      // ユーザー登録に失敗した場合
                      setState(() {
                        infoText = auth_error.register_error_msg(
                            e.hashCode, e.toString());
                      });
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(children: [
                    const Center(
                        child: Center(
                            child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'アカウントお持ちではない場合',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 97, 97, 97)),
                        textAlign: TextAlign.center,
                      ),
                    ))),
                    RichText(
                      text: TextSpan(
                        text: 'ユーザ登録へ',
                        style: linkStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            await Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                                return const RegisterPage();
                              }),
                            );
                          },
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
