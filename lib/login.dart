import 'package:cardispatch/RegisterPage.dart';
import 'package:cardispatch/main.dart';
import 'package:cardispatch/mainMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:cardispatch/authError.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  //final String title = '';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // メッセージ表示用
  String infoText = '';
  // 入力したメールアドレス・パスワード
  //String email = '';
  //String password = '';
  String userName = '';
  //final auth_error = Authentication_error_to_ja();
  TextStyle linkStyle = const TextStyle(color: Colors.blue, fontSize: 12);
  Future<FirebaseAuthResultStatus> signInEmail(
      String email, String password) async {
    FirebaseAuthResultStatus result;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('succeed');
      if (userCredential.user! != null) {
        result = FirebaseAuthResultStatus.Successful;
      } else {
        result = FirebaseAuthResultStatus.Undefined;
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      result = FirebaseAuthExceptionHandler.handleException(e);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final _formKeyId = GlobalKey<FormState>();
    final _formKeyPwd = GlobalKey<FormState>();

    TextEditingController _email = new TextEditingController();
    TextEditingController _password = new TextEditingController();
    return Scaffold(
      //drawer: NaviBar(),
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
                    child: Form(
                      key: _formKeyId,
                      child: TextFormField(
                        controller: _email,
                        decoration: const InputDecoration(labelText: 'メールアドレス'),
                        // onChanged: (String value) {
                        //  setState(() {
                        //    email = value;
                        //  });
                        //},
                      ),
                    ),
                  ),
                  // パスワード入力
                  SizedBox(
                    width: 250,
                    child: Form(
                      key: _formKeyPwd,
                      child: TextFormField(
                        controller: _password,
                        decoration: const InputDecoration(labelText: 'パスワード'),
                        obscureText: true,
                        //onChanged: (String value) {
                        //  setState(() {
                        //    password = value;
                        //  });
                        //},
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: 150,
                      // ユーザー登録ボタン
                      child: ElevatedButton(
                        child: const Text('ログイン'),
                        onPressed: () async {
                          _formKeyId.currentState!.validate();
                          _formKeyPwd.currentState!.validate();

                          final FirebaseAuthResultStatus signInResult =
                              await signInEmail(_email.text, _password.text);
                          if (signInResult !=
                              FirebaseAuthResultStatus.Successful) {
                            final errorMessage =
                                FirebaseAuthExceptionHandler.exceptionMessage(
                                    signInResult);

                            _showErrorDialog(context, errorMessage);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Login successful')));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainMenu()));
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
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
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                        ),
                      ],
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

void _showErrorDialog(BuildContext context, String? message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(message!),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(dialogContext);
            },
          ),
        ],
      );
    },
  );
}
