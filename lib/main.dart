import 'package:camera/camera.dart';
import 'package:der/screens/setup_digit_screen.dart';
import 'package:der/screens/login_digit_screen.dart';
import 'package:der/screens/main/signup_screen.dart';
import 'package:der/screens/select_user_screen.dart';

import 'package:der/screens/main/newlogin_screen.dart';

import 'package:flutter/material.dart';
import 'package:der/screens/main/signup_screen.dart';
import 'package:der/utils/constants.dart';
import "package:der/utils/router.dart";
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reflectable/reflectable.dart';
import 'package:der/screens/main/existed_screen.dart';

import 'entities/site/plot.dart';
import 'entities/site/trial.dart';
import 'entities/site/user.dart';

Box? _UserBox;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  MyApp({required this.cameras});

  /*@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spin Circle Bottom Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(cameras:cameras),
    );
  }*/

  Widget build(BuildContext context) {
    print("%%%% openBox %%%%");
    _openBox();
    DateTime _lastExitTime = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        if (DateTime.now().difference(_lastExitTime) >= Duration(seconds: 2)) {
          //showing message to user
          final snack = SnackBar(
            content: Text("Press the back button again to exist the app"),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          _lastExitTime = DateTime.now();
          return false; // disable back press
        } else {
          return true; //  exit the app
        }
      },
      child: FutureBuilder(
        future: Init.instance.initialize(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(home: Splash());
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: true,
              onGenerateRoute: Routers.generateRoute,
              routes: <String, WidgetBuilder>{
                //'12': (BuildContext context) => new SignupScreen()
                HOME_ROUTE: (BuildContext context) =>
                    new MyHomePage(cameras: cameras)
              },

              //home: new LoginDigitScreen(),

              // home: new SignupScreen(),
              // home: new SignupScreen(),
              // home: new FirstScreen(),
              home: new LoginScreen(),
              // home: new NewUserScreen(),
            );
          }
          MyHomePage(cameras: cameras);
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  void initState() {}

  final List<CameraDescription> cameras;

  MyHomePage({required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Routers.generateRoute,
      initialRoute: HOME_ROUTE,
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      backgroundColor: lightMode
          ? Color(0xFFFFFF).withOpacity(1.0)
          : Color(0x042a49).withOpacity(1.0),
      body: Center(
          child: lightMode
              ? Image.asset('assets/images/syngenta_vector_logo.png')
              : Image.asset('assets/images/splash_dark.png')),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();
  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 2));
  }
}

void _openBox() async {
  if (!Hive.isAdapterRegistered(OnSiteUserAdapter().typeId)) {
    Hive.registerAdapter(OnSiteUserAdapter());
  }
  if (!Hive.isAdapterRegistered(OnSiteTrialAdapter().typeId)) {
    Hive.registerAdapter(OnSiteTrialAdapter());
  }
  if (!Hive.isAdapterRegistered(OnSitePlotAdapter().typeId)) {
    Hive.registerAdapter(OnSitePlotAdapter());
  }
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  print("DIR PATH = " + dir.path);

  await Hive.openBox('Users');
  _UserBox = Hive.box('Users');
}
