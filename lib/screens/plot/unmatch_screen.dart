

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UnMatchPlotScreen extends StatefulWidget {

  _UnMatchPlotScreen createState() => _UnMatchPlotScreen();

}


class _UnMatchPlotScreen extends State<UnMatchPlotScreen>{

  final  picker = ImagePicker();
  var _image;

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
  bool isSelected = false ;

  Widget makeCameraButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFEEEEEE)),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,


          children: <Widget>[
            Icon(Icons.camera, color: Colors.blue ,size: 18,),
            SizedBox(width: 5,),
            Container(
              child: InkWell(
                child: Container(
                  child: Text("Camera", style: TextStyle(color:  Colors.blue),),
                ),
                onTap: (){
                  _getImage(ImageSource.camera);
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
  Widget makeGallryButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFEEEEEE)),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.photo, color: Colors.blue ,size: 18,),
            SizedBox(width: 5,),
            Container(
              child: InkWell(
                child: Container(
                  child: Text("Gallery", style: TextStyle(color:  Colors.blue),),
                ),
                onTap: (){
                  _getImage(ImageSource.gallery);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget makeShareButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFEEEEEE)),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.delete, color: Colors.blue, size: 18),
            SizedBox(width: 5,),
            Text("Delete", style: TextStyle(color: Colors.blue),)
          ],
        ),
      ),
    );
  }


  Widget makePlot({plotID, userImage="assets/images/unknown_user.png", feedTime, feedText, feedImage}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(userImage),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(plotID, style: TextStyle(color: Colors.grey[900], fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1),),
                      SizedBox(height: 3,),
                      Text(feedTime, style: TextStyle(fontSize: 15, color: Colors.grey),),
                    ],
                  )
                ],
              ),
              IconButton(
                icon: Icon(Icons.more_horiz, size: 30, color: Colors.grey[600],),
                onPressed: () {

                },
              )
            ],
          ),
          SizedBox(height: 20,),
          Text(feedText, style: TextStyle(fontSize: 15, color: Colors.grey[800], height: 1.5, letterSpacing: .7),),
          SizedBox(height: 20,),
          feedImage != '' ?
          Container(
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(feedImage),
                    fit: BoxFit.cover
                )
            ),
          ) : Container(),
          SizedBox(height: 30,),
          /*    Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  makeLike(),
                  Transform.translate(
                      offset: Offset(-5, 0),
                      child: makeLove()
                  ),
                  SizedBox(width: 5,),
                  Text("2.5K", style: TextStyle(fontSize: 15, color: Colors.grey[800]),)
                ],
              ),
              //Text("400 Comments", style: TextStyle(fontSize: 13, color: Colors.grey[800]),)
            ],
          ),*/
          //SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              makeCameraButton(),
              makeGallryButton(),
              makeShareButton(),
            ],
          ),
          Container(
            height: 3,
            color: Colors.grey[300],
          ),

        ],
      ),
    );
  }


  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Container(
            color: Colors.blue,
            height: 125,
            padding: EdgeInsets.only(top: 65, right: 20, left: 20, bottom: 10),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[200]
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.grey,),
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: "Search Unmatch Plot",
                          suffixIcon: InkWell(
                            child:Icon(Icons.qr_code, color: Colors.grey,),
                            onTap: (){
                              print('test');
                            },
                          ),
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      //SizedBox(height: 40,),
                      Container(
                        height: 3,
                        color: Colors.grey[300],
                      ),
                      SizedBox(height: 15,),
                      makePlot(
                          plotID: '54155',
                          //userImage: 'assets/images/aiony-haust.jpg',
                          feedTime: '1 hr ago',
                          feedText: 'All the Lorem Ipsum generators on the Internet tend to repeat predefined.',
                          feedImage: 'assets/images/plot_corn.jpg'
                      ),
                      makePlot(
                          plotID: '54156',
                          //userImage: 'assets/images/aiony-haust.jpg',
                          feedTime: '1 hr ago',
                          feedText: 'All the Lorem Ipsum generators on the Internet tend to repeat predefined.',
                          feedImage: 'assets/images/plot_corn.jpg'
                      ),
                      makePlot(
                          plotID: '54157',
                          //userImage: 'assets/images/aiony-haust.jpg',
                          feedTime: '1 hr ago',
                          feedText: 'All the Lorem Ipsum generators on the Internet tend to repeat predefined.',
                          feedImage: 'assets/images/plot_corn.jpg'
                      ),
                    ],
                  ),
                ),
              )
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
        initialActiveIndex: 3,
        onTap: (int i) => Navigator.of(context).pushNamed('$i'),

      ),
    );
  }


}