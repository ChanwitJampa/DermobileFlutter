// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:der/utils/constants.dart';
import 'package:http/http.dart' as Http;
import 'package:der/entities/token.dart';
import 'package:der/entities/user.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreen createState() => _SignupScreen();
}

class _SignupScreen extends State<SignupScreen> {
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
    var url = "http://10.0.2.2:8080/syngenta/api/authenticate";
    var response = await Http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'username': '$username', 'password': '$password'}),
    );
    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body);
      print("Response status: ${response.body}");
      Token t = Token.fromJson(responseJson);
      print("TOKEN FROM T.TOKEN " + t.token);

      print("------------------------send token------------------------");
      var token = t.token;
      var url2 = "http://10.0.2.2:8080/syngenta/api/trial/user/findAll";
      var response2 = await Http.get(Uri.parse(url2), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      var response2Json = jsonDecode(response2.body);
      print("Response status: ${response2.body}");
      User u = User.fromJson(response2Json);
      return true;
    } else {
      print("wrong username or password ");
      return false;
    }
  }
}
