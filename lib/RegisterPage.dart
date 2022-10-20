import 'package:cardispatch/authError.dart';
import 'package:cardispatch/main.dart';
import 'package:cardispatch/naviBar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // メッセージ表示用
  String infoText = '';
  // 入力したメールアドレス・パスワード
  String email = '';
  String password = '';
  String userName = '';
  final auth_error = Authentication_error_to_ja();
  TextStyle linkStyle = const TextStyle(color: Colors.blue, fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: NaviBar(),
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
            child: Container(
              padding: const EdgeInsets.all(24),
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
                      decoration: const InputDecoration(labelText: 'メールアドレス'),
                      onChanged: (String value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                  ),
                  // パスワード入力
                  SizedBox(
                    width: 250,
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'パスワード'),
                      obscureText: true,
                      onChanged: (String value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    // メッセージ表示
                    child: Text(infoText,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.red)),
                  ),
                  Container(
                    width: 150,
                    // ユーザー登録ボタン
                    child: ElevatedButton(
                      child: const Text('ユーザ登録'),
                      onPressed: () async {
                        try {
                          // メール/パスワードでユーザ登録
                          final FirebaseAuth auth = FirebaseAuth.instance;
                          await auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );

                          // ユーザー登録に成功した場合
                          await Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                              return const MyApp();
                            }),
                          );
                        } catch (e) {
                          // ユーザー登録に失敗した場合
                          setState(() {
                            infoText = auth_error.register_error_msg(
                                e.hashCode, e.toString());
                          });
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: RichText(
                      text: TextSpan(
                        text: 'ログイン画面へ戻る',
                        style: linkStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            await Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                                return const MyApp();
                              }),
                            );
                          },
                      ),
                    ),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        child: const Text('ログイン画面へ戻る'),
                        onPressed: () async {
                          await Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                              return const MyApp();
                            }),
                          );
                        },
                      ),
                    ),
                  ),*/

                  Container(
                    padding: const EdgeInsets.all(8),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
