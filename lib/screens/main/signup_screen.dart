// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:der/main.dart';
import 'package:flutter/material.dart';
import 'package:der/entities/site/user.dart';
import 'package:http/http.dart' as Http;
import 'dart:convert';
import 'package:der/entities/objectlist.dart';
import 'package:der/entities/trial.dart';

//hive
import 'package:hive/hive.dart';
import 'package:der/entities/site/trial.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:der/utils/constants.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';

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

import 'package:der/env.dart';

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

//const SERVER_IP = 'http://192.168.3.199:8080';

class NewUserScreen extends StatefulWidget {
  _NewUserScreenState createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  bool _rememberMe = false;

  @override
  void initState() {
    print("--------test--------");
    print(Hive.box("Users"));
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

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: usernameController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Enter your Username',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: passwordController,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          String resultLogin =
              await signIn(usernameController.text, passwordController.text);
          print("result login : ${resultLogin}");
          //["sucess","wrong userName or password","no internet","no web"]
          if (resultLogin == caseLogin[0]) {
            if (_UserBox?.get(userNameNow).password == "") {
              Navigator.of(context).pushReplacementNamed(SETDIGIT_ROUTE);
            } else {
              print(
                  "pass word ${userNameNow} is ${_UserBox!.get(userNameNow).password}");
              Navigator.of(context).pushReplacementNamed(HOME_ROUTE);
            }
          } else if (resultLogin == caseLogin[1]) {
            usernameController.clear();
            passwordController.clear();
            useShowDialog("wrong user name or password", context);
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

        // {
        //   Navigator.of(context).pushNamed(SIGNUP_ROUTE);
        // },
        // onPressed: () {
        //   Navigator.of(context).pushNamed(SIGNUP_ROUTE);
        // },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'Sign in with',
          style: kLabelStyle,
        ),
        SizedBox(height: 0.0),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(DIGIT_ROUTE);
      },
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // _buildSocialBtn(
          //   () => print('Login with Facebook'),
          //   AssetImage(
          //     'assets/images/facebook.jpg',
          //     // 'assets/logos/facebook.jpg',
          //   ),
          // ),
          _buildSocialBtn(
            () => print('Login with Google'),
            AssetImage(
              'assets/images/google.jpg',
              // 'assets/logos/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialBtn2(
    Function onTap,
  ) {
    return Container(
        width: 500,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          color: Colors.white,
        ),
        child: InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(DIGIT_ROUTE);
            },
            child: Center(
              child: Ink(
                color: Colors.white,
                child: Padding(
                  // padding: EdgeInsets.all(6),
                  padding: const EdgeInsets.only(
                      left: 0, right: 14, top: 14, bottom: 14),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/googleLogo.png',
                        height: 30,
                        width: 60,
                      ), // <-- Use 'Image.asset(...)' here
                      SizedBox(width: 15),
                      Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF398AE5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  Widget _buildSocialBtn3(
    Function onTap,
  ) {
    return Container(
        width: 500,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          color: Colors.white,
        ),
        child: InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(DIGIT_ROUTE);
            },
            child: Center(
              child: Ink(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/microsoftLogo.jpg',
                        height: 40,
                        width: 40,
                      ), // <-- Use 'Image.asset(...)' here
                      SizedBox(width: 12),
                      Text(
                        'Sign in with Microsoft',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF398AE5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  Widget _buildDropdownUser() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: const [
            Icon(
              Icons.account_circle,
              size: 30,
              color: Color(0xFF398AE5),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                'User in this Device',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF398AE5),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF398AE5),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        iconSize: 14,
        iconEnabledColor: Color(0xFF398AE5),
        iconDisabledColor: Colors.grey,
        buttonHeight: 70,
        buttonWidth: 520,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.black26,
          ),
          color: Colors.white,
        ),
        buttonElevation: 2,
        itemHeight: 50,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 205,
        dropdownWidth: 520,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(10),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(0, -1),
      ),
    );
  }

  // Widget _buildSignupBtn() {
  //   return GestureDetector(
  //     onTap: () => print('Sign Up Button Pressed'),
  //     child: RichText(
  //       text: TextSpan(
  //         children: [
  //           TextSpan(
  //             text: 'Don\'t have an Account? ',
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 18.0,
  //               fontWeight: FontWeight.w400,
  //             ),
  //           ),
  //           TextSpan(
  //             text: 'Sign Up',
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 18.0,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  String dropdownValue = 'User in this Device';

  late String country_id;

  List<String> country = [
    "America",
    "Brazil",
    "Canada",
    "India",
    "Mongalia",
    "USA",
    "China",
    "Russia",
    "Germany"
  ];

  String? selectedValue;

  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  @override
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      // Colors.white
                      //Blue
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                      //Green
                      // Color(0xFF2EB62C),
                      // Color(0xFF2EB62C),
                      // Color(0xFF57C84D),
                      // Color(0xFF57C84D),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 50.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image(
                          image: AssetImage(
                            'assets/images/Syngenta-Logo.png',
                          ),
                          width: 250,
                          height: 100,
                        ),
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                          // color: Color(0xFF398AE5),
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 0.0),
                      // child: DropdownButtonFormField<String>(
                      //   decoration: InputDecoration(
                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(
                      //           color: Color(0xFF6CA8F1), width: 1),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     filled: true,
                      //     fillColor: Colors.blueAccent,
                      //   ),
                      //   value: dropdownValue,
                      //   dropdownColor: Colors.white,
                      //   icon: const Icon(
                      //     Icons.account_circle,
                      //     color: Colors.white,
                      //     size: 30,
                      //   ),
                      //   elevation: 16,
                      //   style: kTest,
                      //   onChanged: (String? newValue) {
                      //     setState(() {
                      //       dropdownValue = newValue!;
                      //     });
                      //   },
                      //   items: <String>[
                      //     'Existed User',
                      //     'Test',
                      //     'user1@ku.th',
                      //   ].map<DropdownMenuItem<String>>((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      // ),
                      //),
                      SizedBox(height: 40.0),
                      // ignore: avoid_unnecessary_containers
                      // Container(
                      //     child: Divider(
                      //   color: Colors.white54,
                      //   // color: Color(0xFF398AE5),
                      //   height: 10,
                      //   thickness: 3,
                      // )),
                      _buildEmailTF(),
                      SizedBox(height: 10.0),
                      _buildPasswordTF(),
                      SizedBox(height: 50.0),
                      _buildLoginBtn(),
                      _buildSignInWithText(),
                      SizedBox(height: 50.0),
                      _buildSocialBtn3(
                        () => Navigator.of(context)
                            .pushReplacementNamed(DIGIT_ROUTE),
                      ),
                      SizedBox(height: 30.0),
                      _buildSocialBtn2(
                        () => Navigator.of(context)
                            .pushReplacementNamed(DIGIT_ROUTE),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      // _buildForgotPasswordBtn(),
                      // _buildRememberMeCheckbox(),
                      // _buildSocialBtnRow(),

                      // _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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
    print("userNameNow " + userNameNow!);
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

    Response<Token> t = Response<Token>.fromJson(
        jsonDecode(res.body), (body) => Token.fromJson(body));

    String token = t.body.token;
    print("####################### ${token}");
    User u = t.body.user;
    u.userName = username;

    if (_UserBox?.get(userNameNow) == null) {
      print(" not  token null");
      OnSiteUser user = OnSiteUser(u.userName, u.firstName, u.lastName,
          u.picture, token, 123, "", [], [], "");
      _UserBox?.put(u.userName, user);
    } else {
      print(" save token");
      _UserBox?.get(userNameNow).token = token;
      _UserBox?.get(userNameNow).save();
    }

    //["sucess","wrong userName or password","no internet","no web"]
    return caseLogin[0];
  }
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
      print('No Internet connection ????');
    } on HttpException {
      print("Couldn't find the post ????");
    } on FormatException {
      print("Bad response format ????");
    }
    return res;
  }
}
