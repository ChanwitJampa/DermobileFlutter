



import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PictureScreen extends StatefulWidget{

  @override
  _PictureScreen createState() => _PictureScreen();

}

class _PictureScreen extends State<PictureScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Scaffold(

        body: Stack(

          children: [

            Image.file(File(imagePath))

          ],

        ),

      ),
    );
  }
}