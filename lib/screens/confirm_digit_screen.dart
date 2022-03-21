import 'package:der/screens/main/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:der/screens/setup_digit_screen.dart';
import 'package:der/utils/constants.dart';
import 'package:hive/hive.dart';

class ConfirmDigitScreen extends StatefulWidget {
  _ConfirmDigitScreen createState() => _ConfirmDigitScreen();
}

Box? _UserBox;

class _ConfirmDigitScreen extends State<ConfirmDigitScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.blueAccent,
        ], begin: Alignment.topRight)),
        child: PinScreen(),
      ),
    );
  }
}

class PinScreen extends StatefulWidget {
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  List<String> currentPin = ["", "", "", "", "", ""];
  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();
  TextEditingController pinFiveController = TextEditingController();
  TextEditingController pinSixController = TextEditingController();

  /*var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
    borderSide: BorderSide(color: Colors.transparent),
  );*/

  int pinIndex = 0;
  int stackPin = 1;
  bool visibility = true;
  int countError = 0;
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment(0, 0.3),
                padding: EdgeInsets.symmetric(horizontal: 80.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    buildSecurityText(),
                    SizedBox(height: 10.0),
                    IgnorePointer(
                      ignoring: visibility,
                      child: Opacity(
                        opacity: visibility ? 0 : 1,
                        child: buildBox(text: 'Pincode is wrong'),
                      ),
                    ),
                    buildPinRow(),
                  ],
                ),
              )),
          buildNumberPad(),
          buildSpace()
        ],
      ),
    );
  }

  Widget buildBox({
    @required String text = "",
  }) =>
      GestureDetector(
        child: Container(
          width: double.infinity,
          height: 40,
          child: Center(
            child: Text(
              text + '  $countError/3',
              style: TextStyle(
                fontSize: 25,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );

  buildNumberPad() {
    return Expanded(
      flex: 6,
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  KeyboardNumber(
                    n: 1,
                    onPressed: () {
                      pinIndexSetup("1");
                    },
                  ),
                  KeyboardNumber(
                    n: 2,
                    onPressed: () {
                      pinIndexSetup("2");
                    },
                  ),
                  KeyboardNumber(
                    n: 3,
                    onPressed: () {
                      pinIndexSetup("3");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  KeyboardNumber(
                    n: 4,
                    onPressed: () {
                      pinIndexSetup("4");
                    },
                  ),
                  KeyboardNumber(
                    n: 5,
                    onPressed: () {
                      pinIndexSetup("5");
                    },
                  ),
                  KeyboardNumber(
                    n: 6,
                    onPressed: () {
                      pinIndexSetup("6");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  KeyboardNumber(
                    n: 7,
                    onPressed: () {
                      pinIndexSetup("7");
                    },
                  ),
                  KeyboardNumber(
                    n: 8,
                    onPressed: () {
                      pinIndexSetup("8");
                    },
                  ),
                  KeyboardNumber(
                    n: 9,
                    onPressed: () {
                      pinIndexSetup("9");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  /*Container(
                    width: 60.0,
                    child: MaterialButton(
                      onPressed: null,
                      child: SizedBox(),
                    ),
                  ),*/
                  Container(
                    width: 90.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white10.withOpacity(0),
                    ),
                    alignment: Alignment.center,
                    child: MaterialButton(
                      padding: EdgeInsets.all(8.0),
                      onPressed: null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0)),
                      height: 90.0,
                    ),
                  ),
                  KeyboardNumber(
                    n: 0,
                    onPressed: () {
                      pinIndexSetup("0");
                    },
                  ),
                  /*Container(
                    width: 65.0,
                    child: MaterialButton(
                      height: 65.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      onPressed: () {
                        clearPin();
                      },
                      child: Image.asset("assets/images/delete_clear.png",
                          color: Colors.white),
                    ),
                  ),*/
                  Container(
                    width: 90.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white10.withOpacity(0.05),
                    ),
                    alignment: Alignment.center,
                    child: MaterialButton(
                      padding: EdgeInsets.all(27.0),
                      onPressed: () {
                        clearPin();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0)),
                      height: 90.0,
                      child: Image.asset(
                        "assets/images/delete_clear.png",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildSpace() {
    return Expanded(
      flex: 1,
      child: Container(),
    );
  }

  clearPin() {
    if (pinIndex == 0)
      pinIndex = 0;
    else if (pinIndex == 6) {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    } else {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    }
  }

  clearAllPin() {
    for (int n = pinIndex; n > 0; n--) {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    }
  }

  pinIndexSetup(String text) {
    String pinCodeCheck = "";
    if (pinIndex == 0) {
      pinIndex = 1;
    } else if (pinIndex < 6) {
      pinIndex++;
    }
    setPin(pinIndex, text);
    currentPin[pinIndex - 1] = text;
    currentPin.forEach((e) {
      pinCodeCheck += e;
    });
    if (pinIndex == 6 && pinCode == pinCodeCheck) {
      print("success");

      _UserBox = Hive.box("Users");
      _UserBox!.get(userNameNow).password = pinCode;
      _UserBox!.get(userNameNow).save();
      print(" set pass word : ");
      print(_UserBox!.get(userNameNow).password);
      Navigator.of(context).pushReplacementNamed(HOME_ROUTE);
    } else if (pinIndex == 6 && pinCode != pinCodeCheck) {
      print("The entered pincode is wrong");
      clearAllPin();
      stackPinError();
    }
  }

  stackPinError() {
    if (stackPin < 3) {
      if (visibility == true) setState(() => visibility = !visibility);
      stackPin++;
      setState(() => countError = countError += 1);
      //print(countError);
      //print(stackPin);
    } else {
      stackPin = 0;
      countError = 1;
      Navigator.of(context).pushNamed(SETDIGIT_ROUTE);
    }
  }

  setPin(int n, String text) {
    switch (n) {
      case 1:
        pinOneController.text = text;
        break;
      case 2:
        pinTwoController.text = text;
        break;
      case 3:
        pinThreeController.text = text;
        break;
      case 4:
        pinFourController.text = text;
        break;
      case 5:
        pinFiveController.text = text;
        break;
      case 6:
        pinSixController.text = text;
        break;
    }
  }

  buildPinRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        PINNumber(
          //outlineInputBorder: outlineInputBorder,
          textEditingController: pinOneController,
        ),
        PINNumber(
          //outlineInputBorder: outlineInputBorder,
          textEditingController: pinTwoController,
        ),
        PINNumber(
          //outlineInputBorder: outlineInputBorder,
          textEditingController: pinThreeController,
        ),
        PINNumber(
          //outlineInputBorder: outlineInputBorder,
          textEditingController: pinFourController,
        ),
        PINNumber(
          //outlineInputBorder: outlineInputBorder,
          textEditingController: pinFiveController,
        ),
        PINNumber(
          //outlineInputBorder: outlineInputBorder,
          textEditingController: pinSixController,
        ),
      ],
    );
  }

  /*List<Widget> _buildCircles() {
    var list = <Widget>[];
    var config = widget.circleUIConfig;
    var extraSize = animation.value;
    for (int i = 0; i < widget.passwordDigits; i++) {
      list.add(
        Container(
          margin: EdgeInsets.all(8),
          child: Circle(
            filled: i < enteredPasscode.length,
            circleUIConfig: config,
            extraSize: extraSize,
          ),
        ),
      );
    }
    return list;
  }*/

  buildSecurityText() {
    return Text(
      "Confirm Pincode",
      style: TextStyle(
        color: Colors.white70,
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /*buildExitButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: () {},
            height: 50.0,
            minWidth: 50.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Icon(Icons.clear, color: Colors.white),
          ),
        )
      ],
    );
  }*/
}

class PINNumber extends StatelessWidget {
  final TextEditingController textEditingController;
  //final OutlineInputBorder outlineInputBorder;
  PINNumber({
    required this.textEditingController,
    /*required this.outlineInputBorder*/
  });

  Widget build(BuildContext context) {
    return Container(
      //width: 70.0,
      width: 35.0,
      child: TextField(
        controller: textEditingController,
        enabled: false,
        obscureText: true,
        textAlign: TextAlign.center,
        /*decoration: InputDecoration(
          contentPadding: EdgeInsets.all(26.0),
          //border: outlineInputBorder,
          filled: true,
          fillColor: Colors.white30,
        ),*/
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 70.0,
          //fontSize: 21.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

class KeyboardNumber extends StatelessWidget {
  final int n;
  final Function() onPressed;
  KeyboardNumber({required this.n, required this.onPressed});
  Widget build(BuildContext context) {
    return Container(
      width: 90.0,
      height: 90.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white10.withOpacity(0),
      ),
      alignment: Alignment.center,
      child: MaterialButton(
        padding: EdgeInsets.all(8.0),
        onPressed: onPressed,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
        height: 90.0,
        child: Text(
          "$n",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28 * MediaQuery.of(context).textScaleFactor,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CircleUIConfig {
  final Color borderColor;
  final Color fillColor;
  final double borderWidth;
  final double circleSize;

  const CircleUIConfig({
    this.borderColor = Colors.white,
    this.borderWidth = 1,
    this.fillColor = Colors.white,
    this.circleSize = 20,
  });
}

class Circle extends StatelessWidget {
  final bool filled;
  final CircleUIConfig circleUIConfig;
  final double extraSize;

  Circle({
    Key? key,
    this.filled = false,
    required this.circleUIConfig,
    this.extraSize = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: extraSize),
      width: circleUIConfig.circleSize,
      height: circleUIConfig.circleSize,
      decoration: BoxDecoration(
        color: filled ? circleUIConfig.fillColor : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: circleUIConfig.borderColor,
          width: circleUIConfig.borderWidth,
        ),
      ),
    );
  }
}
