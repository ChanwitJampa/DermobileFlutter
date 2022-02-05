import 'package:flutter/material.dart';

// MAJOR ROUTE
const String HOME_ROUTE = '0';
const String DOWNLOAD_ROUTE = '1';
const String SCAN_QR_ROUTE = '2';
const String EXPERIMENT_ROUTE = '3';
const String REPORT_ROUTE = '4';

// MINOR ROUTE
const String PLOT_ROUTE = '5';
const String SELECT_IMAGE_ROUTE = '6';
const String UNMATCH_PLOT_ROUTE = '7';
const String NONE_UPLOAD_ROUTE = '8';
const String PRETEST_PLOT_ROUTE = '9';
const String PRETEST_REPORT_PLOT_ROUTE = '10';
const String EXPERIMENT_DASHBOARD_ROUTE = '11';
const String SIGNUP_ROUTE = '12';
const String ASSESSMENT_ROUTE = '13';
const String EXISTED_ROUTE = '15';
const String NEWLOGIN_ROUTE = '16';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  // color: Colors.white,
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kTest = TextStyle(
    // color: Colors.white,
    color: Colors.white,
    fontFamily: 'OpenSans',
    fontSize: 25,
    height: 1.15);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
