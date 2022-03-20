

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
  import 'package:photo_view/photo_view.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AssessmentScreen extends StatefulWidget{


  _AssessmentScreen createState() => _AssessmentScreen();
}

class _AssessmentScreen extends State<AssessmentScreen>{

  @override
  Widget build(BuildContext context){

    return Scaffold(

      body: Column(

        children: [

          Container(
            color: Colors.blue,
            height: 120,
            padding: EdgeInsets.only(top: 65, right: 20, left: 20, bottom: 10),
          ),
          SizedBox(height: 20,),
      Container(
        height: 200,
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HeroPhotoViewRouteWrapper(
                    imageProvider: AssetImage(
                      "assets/images/cornBorder.jpeg",
                    ),
                  ),
                ),
              );
            },
            child: Container(
              child: Hero(
                tag: "someTag",
                child: Image.asset("assets/images/cornBorder.jpeg"),
              ),
            ),
          ),
        ),
      ),

          /*Container(
            margin: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 5.0,
            ),
            height: 250.0,
            child: ClipRect(
              child: PhotoView(
                imageProvider: const AssetImage("assets/images/cornBorder.jpeg"),
                maxScale: PhotoViewComputedScale.covered * 3.0,
                minScale: PhotoViewComputedScale.contained * 0.8,
                initialScale: PhotoViewComputedScale.covered,
              ),
            ),
          ),*/

          /*Container(
            //color: Colors.blue,
            height: 250,
            width: 400,
            //padding: EdgeInsets.only(top: 65, right: 20, left: 20, bottom: 10),
            child: PhotoView(
              imageProvider: AssetImage("assets/images/cornBorder.jpeg"),
            ),

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                //image: DecorationImage(
                    //image: AssetImage('assets/images/cornBorder.jpeg'),
                 //   fit: BoxFit.fill

            ),
          ),*/

          SizedBox(width: 20,),


          
          Container(
            //color: Colors.blue,
            padding: EdgeInsets.all(5),
            
            height: 300,
            width: 400,
            //padding: EdgeInsets.only(top: 65, right: 20, left: 20, bottom: 10),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               //SizedBox(width: 20,),
              /* Container(
                 color: Colors.red,
                 width: 100,
                 height: 100,
               ),*/

               SizedBox(height: 40),
               Text('EARTN  :',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue
                  ),),

               SizedBox(height: 40),
               Text('DLERN  :',
                 style: TextStyle(
                     fontSize: 20,
                     color: Colors.blue
                 ),),

               SizedBox(height: 40),
               Text('DLERP  :',
                 style: TextStyle(
                     fontSize: 20,
                     color: Colors.blue
                 ),),

               SizedBox(height: 40),
               Text('DRWAP :',
                 style: TextStyle(
                     fontSize: 20,
                     color: Colors.blue
                 ),),

             ],
           ),

          ),


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

class HeroPhotoViewRouteWrapper extends StatefulWidget {
  const HeroPhotoViewRouteWrapper({
    required this.imageProvider,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
  });

  final ImageProvider imageProvider;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;

  _HeroPhotoViewRouteWrapper createState() => _HeroPhotoViewRouteWrapper();

}

class _HeroPhotoViewRouteWrapper extends State<HeroPhotoViewRouteWrapper>{



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Test"),
      ),

      body: Stack(
        children: [

          Container(
            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height,
            ),
            child: PhotoView(
              imageProvider: widget.imageProvider,
              backgroundDecoration: widget.backgroundDecoration,
              minScale: widget.minScale,
              maxScale: widget.maxScale,
              heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),

            ),
          ),

          /*FlatButton(
            onPressed: () {
              print('test');

            },
            child: Text("Go to original size",style: TextStyle(
              color: Colors.white,
            ),),
            //onPressed: goBack,
          ),*/
        ],
      ),
    );

     ;
  }

}