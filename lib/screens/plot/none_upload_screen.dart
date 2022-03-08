import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:der/utils/app_popup_menu.dart';

class NoneUploadScreen extends StatefulWidget {
  _NoneUploadScreen createState() => _NoneUploadScreen();
}

class _NoneUploadScreen extends State<NoneUploadScreen> {
  Widget makePlot(
      {plotID,
      userImage = "assets/images/unknown_user.png",
      feedTime,
      feedText,
      feedImage}) {
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
                            image: AssetImage(userImage), fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        plotID,
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        feedTime,
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  size: 30,
                  color: Colors.grey[600],
                ),
                onPressed: () {},
              ),

              /*PopupMenuButton(itemBuilder: (BuildContext context) {
                        var list =  <PopupMenuEntry<Object>>[

                          PopupMenuItem(
                            value:1,
                            child: Text('test'),

                          ),


                          PopupMenuItem(
                            value:1,
                            child: Text('test'),

                          ),

                        ];
                        return list ;
              },

              ),*/
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            feedText,
            style: TextStyle(
                fontSize: 15,
                color: Colors.grey[800],
                height: 1.5,
                letterSpacing: .7),
          ),
          SizedBox(
            height: 20,
          ),
          feedImage != ''
              ? Container(
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(feedImage), fit: BoxFit.cover)),
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  makeLock(isLock: true),
                ],
              ),
              //Text("400 Comments", style: TextStyle(fontSize: 13, color: Colors.grey[800]),)
            ],
          ),
          //SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              makeCameraButton(),
              makeGallryButton(),
              makeShareButton(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 3,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  Widget makeLock({required bool isLock}) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          color: (isLock) ? Colors.red : Colors.blue,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white)),
      child: Center(
        child: Icon((isLock) ? Icons.lock : Icons.thumb_up,
            size: 12, color: Colors.white),
      ),
    );
  }

  Widget makeLike() {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white)),
      child: Center(
        child: Icon(Icons.thumb_up, size: 12, color: Colors.white),
      ),
    );
  }

  Widget makeLove() {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white)),
      child: Center(
        child: Icon(Icons.lock, size: 12, color: Colors.white),
      ),
    );
  }

  final picker = ImagePicker();
  var _image;

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
            Icon(
              Icons.camera,
              color: Colors.blue,
              size: 18,
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              child: InkWell(
                child: Container(
                  child: Text(
                    "Camera",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                onTap: () {
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
            Icon(
              Icons.photo,
              color: Colors.blue,
              size: 18,
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              child: InkWell(
                child: Container(
                  child: Text(
                    "Gallery",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                onTap: () {
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
            Icon(Icons.upload, color: Colors.blue, size: 18),
            SizedBox(
              width: 5,
            ),
            Text(
              "Upload",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                // color: Colors.blue,
                color: Color(0xFF398AE5),

                height: 135,
                padding:
                    EdgeInsets.only(top: 65, right: 20, left: 20, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[200]),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: "Search Plot",
                          suffixIcon: InkWell(
                            child: Icon(
                              Icons.qr_code,
                              color: Colors.grey,
                            ),
                            onTap: () {
                              print('test');
                            },
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              Positioned(
                right: -10.0,
                top: 100.0,
                child: Container(
                  height: 50,
                  child: Column(
                    //height: 10,
                    children: [
                      AppPopupMenu(
                        icon: Icon(
                          Icons.filter_list,
                          size: 25,
                        ),
                        items: ['test', 'test'],
                        offset: const Offset(0, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          /*Container(
               height: 50,
                child: Column(

                  //height: 10,
                  children: [
                    AppPopupMenu(

                      icon: Icon(Icons.filter_list,size: 15,),
                    ),
                  ],

                ),
             ),*/

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
                  SizedBox(
                    height: 15,
                  ),
                  makePlot(
                      plotID: '54155',
                      //userImage: 'assets/images/aiony-haust.jpg',
                      feedTime: '1 hr ago',
                      feedText:
                          'All the Lorem Ipsum generators on the Internet tend to repeat predefined.',
                      feedImage: 'assets/images/plot_corn.jpg'),
                  makePlot(
                      plotID: '54156',
                      //userImage: 'assets/images/aiony-haust.jpg',
                      feedTime: '1 hr ago',
                      feedText:
                          'All the Lorem Ipsum generators on the Internet tend to repeat predefined.',
                      feedImage: 'assets/images/plot_corn.jpg'),
                  makePlot(
                      plotID: '54157',
                      //userImage: 'assets/images/aiony-haust.jpg',
                      feedTime: '1 hr ago',
                      feedText:
                          'All the Lorem Ipsum generators on the Internet tend to repeat predefined.',
                      feedImage: 'assets/images/plot_corn.jpg'),
                ],
              ),
            ),
          )),
          /*Container(
               height: 600,
               child:ListView(
                 scrollDirection: Axis.vertical,

               ),*/

          //allLayout(context),

          //),

          //SpinCircleBottomBarHolder(
          /*bottomNavigationBar: SCBottomBarDetails(
               circleColors: [Colors.white, Colors.orange, Colors.redAccent],
               iconTheme: IconThemeData(color: Colors.black45),
               activeIconTheme: IconThemeData(color: Colors.orange),
               backgroundColor: Colors.white,
               titleStyle: TextStyle(color: Colors.black45,fontSize: 12),
               activeTitleStyle: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),
               actionButtonDetails: SCActionButtonDetails(
                   color: Colors.redAccent,
                   icon: Icon(
                     Icons.expand_less,
                     color: Colors.white,
                   ),
                   elevation: 2
               ),
               elevation: 2.0,
               items: [
                 // Suggested count : 4
                 SCBottomBarItem(icon: Icons.home, title: "Home", onPressed: () {

                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MainScreen()));

                 }),
                 SCBottomBarItem(icon: Icons.details, title: "New Data", onPressed: () {

                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DownloadScreen()));

                 }),
                 SCBottomBarItem(icon: Icons.upload_file_sharp, title: "Upload", onPressed: () {}),
                 SCBottomBarItem(icon: Icons.details, title: "New Data", onPressed: () {}),
               ],
               circleItems: [
                 //Suggested Count: 3
                 SCItem(icon: Icon(Icons.search), onPressed: () async  {

                   //WidgetsFlutterBinding.ensureInitialized();

                   //final firstCamera = cameras.first;
                   // _onImageButtonPressed(ImageSource.camera, context: context);
                   //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CameraScreen(camera:cameras.first)));

                 }),

                 SCItem(icon: Icon(Icons.qr_code_outlined), onPressed: () async  {

                   //WidgetsFlutterBinding.ensureInitialized();
                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>QRScreen()));
                   //final firstCamera = cameras.first;
                   //_onImageButtonPressed(ImageSource.camera, context: context);
                   //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CameraScreen(camera:cameras.first)));

                 }),
                 SCItem(icon: Icon(Icons.camera), onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SelectedImage()));
                 })
               ],
               bnbHeight: 80 // Suggested Height 80
           ),*/

          //),
        ],
      ),
    );
  }
}
