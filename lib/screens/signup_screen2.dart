// ignore_for_file: unnecessary_new, prefer_const_constructors
import 'dart:async';
import 'dart:convert';
import 'dart:io';
//import 'dart:html';

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

//check internet
import 'package:connectivity_plus/connectivity_plus.dart';
//hive
import 'package:der/entities/site/user.dart';

import 'package:der/entities/response.dart';
import 'package:der/entities/trial.dart';
import 'package:path_provider/path_provider.dart';

Box? _UserBox;
//const SERVER_IP = 'http://10.0.2.2:8080';
String? userNameNow;
ConnectivityResult? _connectivityResult;
bool _isConnectionSuccessful = false;

List<String> caseLogin = [
  "sucess",
  "wrong userName or password",
  "no internet",
  "no web"
];

// const SERVER_IP = 'http://10.0.2.2:8005';
//const SERVER_IP = 'http://10.0.2.2:8080';
//const SERVER_IP = 'http://192.168.3.199:8080';

//const SERVER_IP = 'http://10.0.2.2:8005';
const SERVER_IP = 'http://10.0.2.2:8080';
//const SERVER_IP = 'http://192.168.3.199:8080';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreen createState() => _SignupScreen();
}

class _SignupScreen extends State<SignupScreen> {
  @override
  void initState() {
    _UserBox = Hive.box("Users");
    super.initState();
  }

  Future<void> _tryConnection() async {
    try {
      final response = await InternetAddress.lookup('www.google.com');
      setState(() {
        _isConnectionSuccessful = response.isNotEmpty;
        print("Sucess");
      });
    } on SocketException catch (e) {
      setState(() {
        _isConnectionSuccessful = false;
        print("failed");
      });
    }
  }

  @override
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'LogIn',
                    style:
                        TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
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
                            String resultLogin = await signIn(
                                usernameController.text,
                                passwordController.text);
                            print("result login : ${resultLogin}");
                            //["sucess","wrong userName or password","no internet","no web"]
                            if (resultLogin == caseLogin[0]) {
                              Navigator.of(context).pushNamed(HOME_ROUTE);
                            } else if (resultLogin == caseLogin[1]) {
                              usernameController.clear();
                              passwordController.clear();
                              useShowDialog(
                                  "wrong user name or password", context);
                            } else if (resultLogin == caseLogin[2]) {
                              usernameController.clear();
                              passwordController.clear();
                              useShowDialog("no internet connection", context);
                            } else if (resultLogin == caseLogin[3]) {
                              usernameController.clear();
                              passwordController.clear();
                              useShowDialog("no web", context);
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
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.redAccent,
                        color: Colors.redAccent,
                        elevation: 7.0,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(EXISTED_ROUTE);
                          },
                          child: Center(
                            child: Text(
                              'EXISTED',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      )),
                ],
              )),
        ]));
  }

  useShowDialog(String title, BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
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

  Future<String> signIn(String username, String password) async {
    //["sucess","wrong userName or password","no internet","no web"]

    // print("-----------------------get token---------------------");
    // username = "Test";
    //password = "Test";
    await _tryConnection();
    if (!_isConnectionSuccessful) {
      return caseLogin[2];
    }
    userNameNow = username;
    loginService dc = loginService();
    var res = await dc.attemptLogIn(username, password);

    if (res == null) {
      //res == null if dont' have web service
      print("web don't have service or don't have web");
      return caseLogin[3];
    } else if (res.statusCode != 200) {
      print("fails to  join");

      return caseLogin[1];
    }

    // Response<Token> t = Response<Token>.fromJson(
    //     jsonDecode(res.body), (body) => Token.fromJson(body));
    // String token = t.body.token;
    // User u = t.body.user;
    // u.userName = username;
    // print("token " + token);
    // if (_UserBox?.get(username) == null) {
    //   OnSiteUser user = OnSiteUser(u.userName, u.firstName, u.lastName,
    //       u.picture, token, 123, "", [], [], "");
    //   _UserBox?.put(u.userName, user);
    // } else {
    //   _UserBox?.get(username).token = token;
    // }

    //["sucess","wrong userName or password","no internet","no web"]
    return caseLogin[0];
  }
}

class loginService {
  static late String token = "";

  attemptLogIn(String username, String password) async {
    var url = "$SERVER_IP/syngenta/api/authenticate";
    var res = null;
    try {
      res = await Http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'username': username, 'password': password}),
      );
    } on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    }
    return res;
  }
}
