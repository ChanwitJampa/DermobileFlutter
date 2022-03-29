import 'package:der/entities/site/plot.dart';
import 'package:der/entities/site/trial.dart';
import 'package:der/screens/main/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:developer';
import 'dart:io';
import 'package:der/screens/select_Image.dart';
import 'package:der/utils/constants.dart';

String dataCode = "";
String type = "";
Box? _UserBox;
int itrial = 0;
int jplot = 0;

class QRScreen extends StatefulWidget {
  @override
  _QRScreen createState() => _QRScreen();
}

class _QRScreen extends State<QRScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  initState() {
    super.initState();
    _UserBox = Hive.box("Users");
  }

  List<bool> _isSelected = [false, false];

  List<Widget> toggleButton = [
    Icon(Icons.flash_on),
    Icon(Icons.flip_camera_ios)
    // Icon(Icons.pause)
  ];

  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.none,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    Icon(Icons.qr_code_outlined, color: Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: ToggleButtons(
                          children: toggleButton,
                          color: Colors.grey,
                          selectedColor: Colors.white,
                          fillColor: Colors.blue,
                          isSelected: _isSelected,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          onPressed: (int index) {
                            setState(() {
                              _isSelected[index] = !_isSelected[index];
                              switch (index) {
                                case 0:
                                  controller?.toggleFlash();
                                  break;
                                case 1:
                                  controller?.flipCamera();
                                  break;
                                // case 2:
                                //   toggleButton.removeAt(2);
                                //   if (_isSelected[index]) {
                                //     controller?.pauseCamera();
                                //     toggleButton.add(Icon(Icons.pause));
                                //   } else {
                                //     controller?.resumeCamera();
                                //     toggleButton.add(Icon(Icons.play_arrow));
                                //   }
                                //   break;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            type = "MATCH";
                            controller?.pauseCamera();
                            Navigator.of(context).pushNamed(SELECT_IMAGE_ROUTE);
                          },
                          child: Text('MATCH'),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            type = "UNMATCH";
                            dataCode = "DR234658394";
                            controller?.pauseCamera();
                            Navigator.of(context).pushNamed(SELECT_IMAGE_ROUTE);
                          },
                          child: Text('NOT MATCH'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.blue,
          borderRadius: 10,
          borderLength: 80,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    //print('--------------------------------------------------------------------------------');
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        print(scanData);
        result = scanData;
        print("resule = " + result.toString());
        print(
            'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}');
        dataCode = result!.code;

        if (checkPlost(dataCode)) {
          print("match plot ID is" + dataCode);
          type = "MATCH";
          controller.pauseCamera();
          Navigator.of(context).pushNamed(SELECT_IMAGE_ROUTE);
        } else {
          print("unmatch plot ID is" + dataCode);
          controller.pauseCamera();
          type = "UNMATCH";
          Navigator.of(context).pushNamed(SELECT_IMAGE_ROUTE);
        }

        // Navigator.of(context).pushNamed(SELECT_IMAGE_ROUTE);
        // controller.pauseCamera();
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
    print("CustomWidget dispose");
  }
}

bool checkPlost(String barcode) {
  print("------------------------------------------------");
  List<OnSiteTrial> ost = _UserBox?.get(userNameNow).onSiteTrials;
  // ost.forEach((e) {
  //   e.onSitePlots.forEach((l) {
  //     if (barcode == l.barcode) {
  //       print(e.trialId);
  //       print(l.barcode);
  //       check = 1;
  //     }
  //     if(check==0)
  //     jplot++;
  //   });
  //   if(check==0)
  //   itrial++;
  // });
  for (; itrial < ost.length; itrial++) {
    for (; jplot < ost[itrial].onSitePlots.length; jplot++) {
      if (barcode == ost[itrial].onSitePlots[jplot].barcode) {
        print(ost[itrial].trialId);
        print(ost[itrial].onSitePlots[jplot].barcode);
        print("i = " + itrial.toString() + " j = " + jplot.toString());
        print("------------------------------------------------------");
        return true;
      }
    }
  }

  print("------------------------------------------------------");

  return false;
}
