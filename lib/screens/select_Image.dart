// ignore_for_file: file_names

import 'dart:io';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:der/entities/site/plot.dart';
import 'package:der/screens/signup_screen.dart';
import 'package:der/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import 'package:der/screens/main/qr_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart' as p;

Box? _UserBox;
String galleryPath = "";

class SelectImage extends StatefulWidget {
  _SelectImage createState() => _SelectImage();
}

class _SelectImage extends State<SelectImage> {
  //List<XFile>? _imageFileList;
  initState() {
    super.initState();
    _UserBox = Hive.box("Users");
  }

  var _image;

  final picker = ImagePicker();
  //late final XFile _imageFile ;

  _getImage(ImageSource imageSource) async {
    final _imageFile = await picker.pickImage(
      source: imageSource,
      maxWidth: 1000,
      maxHeight: 1000,
      //imageQuality: quality,
    );
//if user doesn't take any image, just return.
    if (_imageFile == null) return;
    setState(
      () {
        _image = _imageFile;
        isSelected = true;

        //_imageFileList = pickedFile;
        //Rebuild UI with the selected image.
        //print('$_image');
        //_image = File(pickedFile.path);
      },
    );
  }

  bool isSelected = false;

  Future<List<Directory>?>? _externalStorageDirectories;
  // String tempPath = "";

  // void _requestExternalStorageDirectories(StorageDirectory type) {
  //   setState(() {
  //     _externalStorageDirectories = getExternalStorageDirectories(type: type);
  //     tempPath = _externalStorageDirectories as String;
  //   });
  // }

  Future<void> saveExperiment(XFile impath) async {
    Directory? directory;
    String testpath = "";

    GallerySaver.saveImage(impath.path);

    final _filename = p.basename(impath.path);

    // _externalStorageDirectories =
    //     getExternalStorageDirectories(type: StorageDirectory.pictures);
    //tempPath = _externalStorageDirectories;
    // directory = await getExternalStorageDirectories();

    directory = await getExternalStorageDirectory();
    //directory = await getExternalStorageDirectories(type: StorageDirectory.pictures);

    // print(directory);
    // print("tempPath2 = " + directory.toString());
    print("tempPath3 = " + directory!.path);
    print("FileName = " + _filename);

    int count1 = 0;

    if (count1 == 0) {
      galleryPath = "";
      for (int i = 0; i < directory!.path.length; i++) {
        print(directory!.path[i]);

        galleryPath = galleryPath + directory!.path[i];

        if (directory.path[i] == "0") {
          break;
          count1 = 1;
        }
      }
    }

    galleryPath = galleryPath + "/Pictures/";

    testpath = galleryPath + _filename;

    print("galleryPath = " + galleryPath);
    print("imgPath = " + testpath);

    print(impath.path);
    _image = null;

    _UserBox?.get(userNameNow)
        .onSiteTrials[itrial]
        .onSitePlots[jplot]
        .plotImgPath = testpath;
    _UserBox?.get(userNameNow).save();
    print(
        "img path plots is : ${_UserBox?.get(userNameNow).onSiteTrials[itrial].onSitePlots[jplot].plotImgPath}");
    Navigator.of(context).pushNamed(HOME_ROUTE);
  }

  void cancelExperiment() {
    setState(
      () {
        _image = null;
        isSelected = false;
      },
    );
  }

/*

  Widget test() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Stack(
            children: [
              Row(
                children: [
                  Container(
                    child: Chip(
                      label: Text(
                        "Experiment ID:",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.lightBlue,
                    ),
                  ),
                  Container(
                    child: Chip(
                      label: Text('XXXXXX', textAlign: TextAlign.center),
                    ),
                  ),
                ],
                //Text('Customer Contact', textAlign: TextAlign.left),
              ),
            ],
          ),
        ),
        Container(
          child: Stack(
            children: [
              Row(
                children: [
                  Container(
                    child: Chip(
                      label: Text(
                        "Plot ID:",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.lightBlue,
                    ),
                  ),
                  Container(
                    child: Chip(
                      label: Text('XXXXXX', textAlign: TextAlign.center),
                    ),
                  ),
                ],
                //Text('Customer Contact', textAlign: TextAlign.left),
              ),
            ],
          ),
        ),
        Container(
          child: Stack(
            children: [
              Row(
                children: [
                  Container(
                    child: Chip(
                      label: Text(
                        "Ref Number:",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.lightBlue,
                    ),
                  ),
                  Container(
                    child: Chip(
                      label: Text('XXXXXX', textAlign: TextAlign.center),
                    ),
                  ),
                ],
                //Text('Customer Contact', textAlign: TextAlign.left),
              )
            ],
          ),
        ),
        Center(
          child: _image != null
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    //width: 300,
                    //height: 300,
                    child: Image.file(
                      File(_image.path),
                    ),
                  ),
                )
              : Container(
                  height: 300,
                  width: 500,
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/images/ic_no_image_icon_4.png'),
                ),
        ),
        SizedBox(
          width: 20,
          height: 40,
          //child: okButton,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //Container(
            //   child: isSelected == true ? ,
            // ),
            ElevatedButton.icon(
              onPressed: () => isSelected == true
                  ? saveExperiment()
                  : _getImage(ImageSource.gallery),
              icon: isSelected == true ? Icon(Icons.add) : Icon(Icons.photo),
              label: isSelected == true ? Text("Ok") : Text("gallery"),
            ),
            ElevatedButton.icon(
              onPressed: () => isSelected == true
                  ? cancelExperiment()
                  : cancelExperiment(), //_getImage(ImageSource.camera),
              icon: isSelected == true
                  ? Icon(Icons.dangerous)
                  : Icon(Icons.camera),
              label: isSelected == true ? Text("Cancel") : Text("camera"),
            ),
          ],
        ),
      ],
    );
  }

*/
  Widget makeSelectedImage() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            Container(
              color: Colors.blue,
              height: 100,
              padding:
                  EdgeInsets.only(top: 65, right: 20, left: 20, bottom: 10),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    //color: Colors.red,
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                            elevation: 0.5,
                            //width: 350,

                            child: Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 400,
                                    height: 30,
                                    /*decoration: BoxDecoration(

                                    border: Border.all(color: Colors.grey),
                                  ),*/
                                    child: Text(
                                      '  Plot ID : ' + dataCode,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 368,
                                    child: const Text(
                                      '  Img: ' + '1',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ), //Card(
                                ],
                              ),
                            )
                            //child:
                            ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Container(
                      //color: Colors.red,
                      height: 350,
                      child: Card(
                        child: Center(
                          child: _image != null
                              ? Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    width: 300,
                                    height: 300,
                                    child: Image.file(
                                      File(_image.path),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 300,
                                  width: 500,
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                      'assets/images/ic_no_image_icon_4.png'),
                                ),
                        ),
                      )),
                  Container(
                    height: 50,
                    //color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => isSelected == true
                              ? saveExperiment(_image)
                              : _getImage(ImageSource.gallery),
                          icon: isSelected == true
                              ? Icon(Icons.add)
                              : Icon(Icons.photo),
                          label:
                              isSelected == true ? Text("Ok") : Text("gallery"),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => isSelected == true
                              ? cancelExperiment()
                              : _getImage(ImageSource.camera),
                          icon: isSelected == true
                              ? Icon(Icons.dangerous)
                              : Icon(Icons.camera),
                          label: isSelected == true
                              ? Text("Cancel")
                              : Text("camera"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: makeSelectedImage(),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.download, title: 'Download'),
          TabItem(icon: Icons.qr_code, title: 'Scan'),
          TabItem(icon: Icons.art_track, title: 'Experiment'),
          TabItem(icon: Icons.bar_chart, title: 'Report'),
        ],
        initialActiveIndex: 2,
        onTap: (int i) => Navigator.of(context).pushNamed('$i'),
      ),
    );
  }
}
