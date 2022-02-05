import 'package:der/screens/main/newlogin_screen.dart';
import 'package:der/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:der/screens/assessment_screen.dart';
import 'package:der/screens/experiment_dashboard_screen.dart';
import 'package:der/screens/plot/ear_screen.dart';
import 'package:der/screens/plot/none_upload_screen.dart';
import 'package:der/screens/plot/plot_screen.dart';
import 'package:der/screens/main/download_screen.dart';
import 'package:der/screens/main/experiment_screen.dart';
import 'package:der/screens/main/main_screen.dart';
import 'package:der/screens/main/qr_screen.dart';
import 'package:der/screens/main/report_screen.dart';
import 'package:der/screens/plot/unmatch_screen.dart';
import 'package:der/screens/select_Image.dart';
import 'package:der/screens/test_der_report_screen.dart';
import 'package:der/screens/test_der_screen.dar.dart';
import 'package:der/screens/main/existed_screen.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '0':
        print("1111111111111111111111111");

        return MaterialPageRoute(builder: (_) => MainScreen());
      case '1':
        return MaterialPageRoute(builder: (_) => DownloadScreen());
      case '2':
        return MaterialPageRoute(builder: (_) => QRScreen());
      case '3':
        return MaterialPageRoute(builder: (_) => ExperimentScreen());
      case '4':
        return MaterialPageRoute(builder: (_) => EarGalleryScreen());

      case '5':
        return MaterialPageRoute(
            builder: (_) => PlotsScreen(title: settings.arguments.toString()));
      case '6':
        return MaterialPageRoute(builder: (_) => SelectImage());
      case '7':
        return MaterialPageRoute(builder: (_) => UnMatchPlotScreen());
      case '8':
        return MaterialPageRoute(builder: (_) => NoneUploadScreen());
      case '9':
        return MaterialPageRoute(builder: (_) => TestDERScreen());
      case '10':
        return MaterialPageRoute(builder: (_) => TestDERReportScreen());
      case '11':
        return MaterialPageRoute(builder: (_) => ExperimanetDashBoardScreen());

      case '12':
        return MaterialPageRoute(builder: (_) => SignupScreen());

      case '13':
        return MaterialPageRoute(builder: (_) => AssessmentScreen());

      case '15':
        print("1515155151515151515515151");
        return MaterialPageRoute(builder: (_) => ExistedScreen());

      case '16':
        print("1616616161616116");
        return MaterialPageRoute(builder: (_) => LoginScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
