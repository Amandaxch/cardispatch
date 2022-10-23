import 'package:cardispatch/authError.dart';
import 'package:cardispatch/data.dart';
import 'package:cardispatch/main.dart';
import 'package:cardispatch/naviBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // メッセージ表示用
  String infoText = '';
  // 入力したメールアドレス・パスワード
  String email = '';
  String password = '';
  String userName = '';

  //final auth_error = Authentication_error_to_ja();
  TextStyle linkStyle = const TextStyle(color: Colors.blue, fontSize: 12);

  @override
  Widget build(BuildContext context) {
    TextEditingController ControllerTeam = TextEditingController(text: '');

    String? selectedTeamNo;
    var _text = 'チームを選択';

    /*for (int i = 0; i < teams.length; i++) {
      print(
          'teamList get teamno:$teams[$i].teamNo; teamname:$teams[$i].teamName');
    }*/
    var dropdownButtonFormField_teams = DropdownButtonFormField<String>(
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          )),
      // enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(12),
      // borderSide: const BorderSide(width: 1)),

      items: teams
          .map((item) => DropdownMenuItem<String>(
                value: item.teamNo,
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Text(item.teamName,
                      style: const TextStyle(fontSize: FONT_SIZE)),
                ),
              ))
          .toList(),
      onChanged: (item) => setState(() {
        selectedTeamNo = item;
      }),
    );
    var teamPullDown = Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 8),
          child: Container(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: REG_TEAMNM_LAB_W,
              child: Text(
                'チームを選択',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xFFF44336),
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: DROP_TEAMLIST,
          child: dropdownButtonFormField_teams,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 20.0),
          child: Container(
            child: Text(
              '※所属チームがリストにない場合、アプリ管理者にご連絡ください。',
              style: TextStyle(
                fontSize: 11,
                color: Colors.red.shade300,
              ),
            ),
          ),
        )
      ],
    );
    return Scaffold(
      drawer: NaviBar(),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: 400,
          height: 650,
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
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 50),
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
                            const TextStyle(fontSize: 10, color: Colors.red)),
                  ),
                  teamPullDown,
                  SizedBox(
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
                          String? docId = auth.currentUser!.uid;
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(docId)
                              .set(
                            {
                              'teamNo': selectedTeamNo,
                              'approved': false,
                              'email': email,
                            },
                          );

                          // ユーザー登録に成功した場合
                          await Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                              infoText = '登録が成功しました。ログインページからログインしてください。';
                              return const MyApp();
                            }),
                          );
                        } catch (e) {
                          // ユーザー登録に失敗した場合
                          setState(() {
                            infoText = '登録失敗';
                            //auth_error.register_error_msg(
                            //    e.hashCode, e.toString());
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
