import 'package:camera/camera.dart';
import 'package:der/screens/main/newlogin_screen.dart';
import 'package:flutter/material.dart';
import 'package:der/screens/signup_screen.dart';
import 'package:der/utils/constants.dart';
import "package:der/utils/router.dart";
import 'package:reflectable/reflectable.dart';
import 'package:der/screens/main/existed_screen.dart';

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
    return FutureBuilder(
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
            // home: new SignupScreen(),
            // home: new SignupScreen(),
            home: new LoginScreen(),
          );
        }
        MyHomePage(cameras: cameras);
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
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
