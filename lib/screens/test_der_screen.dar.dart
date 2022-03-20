

import 'dart:io';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:der/utils/constants.dart';

class TestDERScreen extends StatefulWidget{

  _TestDERScreen createState() => _TestDERScreen() ;

}

class _TestDERScreen extends State<TestDERScreen>{

  var _image;



  final  picker = ImagePicker();

  bool isSelected = false ;

  _getImage(ImageSource imageSource) async
  {

    final _imageFile  = await picker.pickImage(source: imageSource,
      maxWidth: 1000,
      maxHeight: 1000,
      //imageQuality: quality,
    );
//if user doesn't take any image, just return.
    if (_imageFile == null) return;
    setState(
          () {
        _image = _imageFile;
        isSelected = true ;
        //_imageFileList = pickedFile;
//Rebuild UI with the selected image.
        //print('$_image');
        //_image = File(pickedFile.path);
      },
    );
  }

  void saveExperiment(){

    Navigator.of(context).pushNamed(PRETEST_REPORT_PLOT_ROUTE);

  }

  void cancelExperiment(){


  }


  Widget build(BuildContext context){


    return Scaffold(

      body: Column(
        crossAxisAlignment:  CrossAxisAlignment.start,
        children: [

          Container(
            height: 120,
            color: Colors.blue,
          ),
          //SizedBox(width: 10,),
          Container(
            //color: Colors.red,
              height: 550 ,
              child:Card(
                child:Center(
                  child: _image != null
                      ? Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                      //width: 300,
                      //height: 300,
                      child: Image.file(
                        File(_image.path),
                      ),
                    ),
                  )
                      : Container(
                    //height: 300,
                    width: 500,
                    padding: const EdgeInsets.all(10.0),
                      child: Image.asset('assets/images/ic_no_image_icon_4.png'),
                  ),
                ),
              )
          ),
          Container(
            height: 80,
            //color: Colors.red,
            //child:Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget> [

                  ElevatedButton.icon(
                    onPressed: () => isSelected == true ? saveExperiment() : _getImage(ImageSource.gallery),

                    icon: isSelected == true ? Icon(Icons.add) : Icon(Icons.photo),
                    label: isSelected == true ? Text("Ok") : Text("gallery"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => isSelected == true ? cancelExperiment() : _getImage(ImageSource.camera),
                    icon: isSelected == true ? Icon(Icons.dangerous) : Icon(Icons.camera),
                    label: isSelected == true ? Text("Cancel") : Text("camera"),

                  ),
                ],
              ),
            )


          //),
        ],
      ),
      bottomNavigationBar:  ConvexAppBar(
      style: TabStyle.react,
      items: [

        TabItem(icon: Icons.home,title: 'Home'),
        TabItem(icon: Icons.download, title:'Download'),
        TabItem(icon: Icons.qr_code, title:'Scan'),
        TabItem(icon: Icons.art_track, title:'Experiment'),
        TabItem(icon: Icons.bar_chart,title:'Report'),

      ],
      initialActiveIndex: 0,
      onTap: (int i) => Navigator.of(context).pushReplacementNamed('$i'),

    ),


    );
  }

}