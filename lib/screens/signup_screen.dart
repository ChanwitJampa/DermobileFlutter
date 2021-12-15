// ignore_for_file: unnecessary_new, prefer_const_constructors
import 'dart:async';
import 'dart:convert';

import 'package:der/entities/site/plot.dart';
import 'package:der/entities/site/trial.dart';
import 'package:der/entities/site/user.dart';
import 'package:flutter/material.dart';
import 'package:der/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as Http;
import 'package:der/entities/token.dart';
import 'package:der/entities/user.dart';
import 'package:der/entities/objectlist.dart';

//hive
import 'package:der/entities/site/user.dart';

import 'package:der/entities/response.dart';
import 'package:der/entities/trial.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Box? _TrialBox;
const SERVER_IP = 'http://10.0.2.2:8080';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreen createState() => _SignupScreen();
}

class _SignupScreen extends State<SignupScreen> {
  @override
  void initState() {
    super.initState();
    if (!Hive.isAdapterRegistered(OnSiteUserAdapter().typeId)) {
      Hive.registerAdapter(OnSiteUserAdapter());
    }
    if (!Hive.isAdapterRegistered(OnSiteTrialAdapter().typeId)) {
      Hive.registerAdapter(OnSiteTrialAdapter());
    }
    if (!Hive.isAdapterRegistered(OnSitePlotAdapter().typeId)) {
      Hive.registerAdapter(OnSitePlotAdapter());
    }

    _openBox();
  }

  @override
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text(
                        'LogIn',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
                      child: Text(
                        '.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            // hintText: 'EMAIL',
                            // hintStyle: ,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            labelText: 'PASSWORD ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        obscureText: true,
                      ),
                      SizedBox(height: 10.0),
                      SizedBox(height: 50.0),
                      Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.greenAccent,
                            color: Colors.green,
                            elevation: 7.0,
                            child: InkWell(
                              onTap: () async {
                                if (await signIn(usernameController.text,
                                    passwordController.text)) {
                                  Navigator.of(context).pushNamed(HOME_ROUTE);
                                } else {
                                  usernameController.clear();
                                  passwordController.clear();
                                  await showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Wrong username or Password'),
                                        content: Text('Please try again'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: Center(
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(height: 20.0),
                      Container(
                        height: 40.0,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: InkWell(
                            onTap: () {
                              //Navigator.of(context).pop();
                            },
                            child: Center(
                              child: Text('Go Back',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ]));
  }

  static Future<bool> signIn(String username, String password) async {
    print("username : " + username + " password : " + password);

    print("-----------------------get token---------------------");

    loginService dc = loginService();
    var res = await dc.attemptLogIn(username, password);
    if (res.statusCode != 200) {
      print("fails to  join");
      return false;
    }

    Response<Token> t = Response<Token>.fromJson(
        jsonDecode(res.body), (body) => Token.fromJson(body));

    var token = t.body.token;
    User user = t.body.user;
    user.userName = username;
    //share token to other page
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    print("sigin token is : " + token);

    return true;
  }
}

class loginService {
  static late String token = "";

  attemptLogIn(String username, String password) async {
    var url = "$SERVER_IP/syngenta/api/authenticate";

    var res = await Http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'username': username, 'password': password}),
    );

    return res;
  }
}

void _openBox() async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  // print('[Debug] Hive path: ${dir.path}');
  _TrialBox = await Hive.openBox('BoxTrial');
}
