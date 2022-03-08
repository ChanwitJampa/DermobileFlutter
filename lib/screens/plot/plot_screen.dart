import 'dart:convert';
import 'dart:io';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:der/entities/site/plot.dart';
import 'package:der/entities/site/trial.dart';
import 'package:der/main.dart';
import 'package:der/screens/select_Image.dart';
import 'package:der/screens/main/signup_screen.dart';
import 'package:der/utils/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';
import 'package:der/model/check_box.dart';
import 'package:der/screens/main/main_screen.dart';
import 'package:der/ui/widgets/label_below_icon.dart';
import 'package:der/utils/app_popup_menu.dart';
import 'package:der/utils/constants.dart';

import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;

import 'package:async/async.dart';
import 'package:http/http.dart' as http;

Box? _UserBox;

class PlotsScreen extends StatefulWidget {
  final String title;
  PlotsScreen({Key? key, required this.title}) : super(key: key);

  @override
  _PlotsScreen createState() => _PlotsScreen(int.parse(this.title));
}

class _PlotsScreen extends State<PlotsScreen> {
  var _image;

  final int title;
  Size? deviceSize;
  List<Widget> plotList = [];
  _PlotsScreen(this.title);

  @override
  void initState() {
    super.initState();
    _UserBox = Hive.box("Users");

    () async {
      var _permissionStatus = await Permission.storage.status;

      if (_permissionStatus != PermissionStatus.granted) {
        PermissionStatus permissionStatus = await Permission.storage.request();
        setState(() {
          _permissionStatus = permissionStatus;
        });
      }
    }();

    loadAllPlot();
  }

  final allChecked = CheckBoxModal(title: 'All Checked');

  final plotItems = [
    CheckBoxModal(title: 'CheckBox 1'),
    CheckBoxModal(title: 'CheckBox 2'),
    CheckBoxModal(title: 'CheckBox 3'),
  ];
  bool isLoading = false;

  Future _loadData() async {
    //await new Future.delayed(new Duration(seconds: 2));
    //print("testtest");
    //print("load more");
    // update data and loading status
    setState(() {
      plotItems.addAll([CheckBoxModal(title: 'Item1')]);
      //print('items: '+ items.toString());
      isLoading = false;
    });
  }

  Widget confirmLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          LabelBelowIcon(
            icon: FontAwesomeIcons.download,
            label: "ok",

            //onPressed ( print("test")),
          ),
          LabelBelowIcon(
            icon: FontAwesomeIcons.pause,
            label: "cancel",
            //onPressed ( print("test")),
          ),
        ],
      ),
    );
    /**/
  }

  Widget allLayout(BuildContext context) {
    return Column(
      children: <Widget>[
        listAllPlot(),
        SizedBox(
          height: deviceSize!.height * 0.01,
        ),
        confirmLayout(),
      ],
    );
  }

  Widget listAllPlot() {
    return Expanded(
        child: NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!isLoading &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          _loadData();
          // start loading data
          setState(() {
            isLoading = true;
          });
        }
        return isLoading;
      },
      child: ListView(
        children: [
          ListTile(
            onTap: () => onAllClicked(allChecked),
            leading: Checkbox(
                value: allChecked.value,
                onChanged: (value) => onAllClicked(allChecked)),
            title: Text(
              allChecked.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          ...plotItems.map((item) => ListTile(
                onTap: () => onItemClicked(item),
                leading: Checkbox(
                  value: item.value,
                  onChanged: (value) => onItemClicked(item),
                ),
                title: Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
        ],
      ),
    ));
  }

  Widget makePlot(
      {isLock,
      plotID,
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
                    margin: const EdgeInsets.all(10.0),
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
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        feedTime,
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
              InkWell(
                child: Container(
                  height: 30,
                  width: 30,
                  margin:
                      EdgeInsets.only(top: 0, right: 10, left: 0, bottom: 0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/arrow_curved_forward_right.png'),
                          fit: BoxFit.cover)),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(ASSESSMENT_ROUTE);
                },
              )

              /*IconButton(

                icon: Icon(Icons.more_horiz, size: 30, color: Colors.grey[600],),
                onPressed: () {

                }
                ,
              ),*/

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
            height: 10,
          ),
          Center(
              child: Text(
            feedText,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[800],
              height: 1.5,
              letterSpacing: .7,
            ),
          )),
          feedImage != "null"
              ? new RotationTransition(
                  turns: new AlwaysStoppedAnimation(90 / 360),
                  child: new Image.file(
                    File(feedImage),
                    // child: new Image.asset(
                    //   feedImage,
                    height: 500,
                    width: 700,
                  ),
                )
              // Container(
              //     height: 200,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         image: DecorationImage(
              //             image: AssetImage(feedImage), fit: BoxFit.cover)),
              //   )
              : Container(
                  margin: const EdgeInsets.all(50.0),
                  height: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: AssetImage("assets/images/img_not.png"),
                          fit: BoxFit.cover)),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  if (isLock == "Open") ...[
                    makeLock(isLock: false),
                  ] else ...[
                    makeLock(isLock: true)
                  ]

                  /*
                  makeLike(),
                  Transform.translate(
                      offset: Offset(-5, 0),
                      child: makeLove()
                  ),
                  SizedBox(width: 5,),
                  Text("2.5K", style: TextStyle(fontSize: 15, color: Colors.grey[800]),)
                  */
                ],
              ),
              //Text("400 Comments", style: TextStyle(fontSize: 13, color: Colors.grey[800]),)
            ],
          ),
          SizedBox(
            height: 20,
          ),
          //SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              makeCameraButton(plotID),
              makeGallryButton(plotID),
              if (isLock == "Open") ...[makeShareButton(plotID)]
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
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          color: (isLock) ? Colors.red : Colors.blue,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white)),
      child: Center(
        child: Icon((isLock) ? Icons.lock : Icons.thumb_up,
            size: 15, color: Colors.white),
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
  _upload(File imageFile, String plotID) async {
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("$SERVER_IP/syngenta/api/plot/upload");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: p.basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);
    request.fields['plot'] = plotID.toString();
    request.fields['username'] = userNameNow.toString();
    String token = _UserBox!.get(userNameNow).token;
    request.headers.addAll({"Authorization": "Bearer ${token}"});
    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  _getImage(ImageSource imageSource, String plotId) async {
    final _imageFile = await picker.pickImage(
      source: imageSource,
      maxWidth: 1000,
      maxHeight: 1000,
      //imageQuality: quality,
    );

//if user doesn't take any image, just return.
    if (_imageFile == null) {
      print("null");
      return;
    }
    setState(
      () {
        print("not null");
        _image = _imageFile;
        isSelected = true;
        saveExperiment(_image, plotId);
        //_imageFileList = pickedFile;
//Rebuild UI with the selected image.
        //print('$_image');
        //_image = File(pickedFile.path);
      },
    );
  }

  bool isSelected = false;

  Widget makeCameraButton(String plotId) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              size: 30,
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              child: InkWell(
                child: Container(
                  child: Text(
                    "Camera1",
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                ),
                onTap: () {
                  _getImage(ImageSource.camera, plotId);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Directory>?>? _externalStorageDirectories;

  Future<void> saveExperiment(XFile impath, String plotId) async {
    Directory? directory;
    String testpath = "";

    GallerySaver.saveImage(impath.path);

    final _filename = p.basename(impath.path);
    directory = await getExternalStorageDirectory();

    print("tempPath3 = " + directory!.path);
    print("FileName = " + _filename);

    int count1 = 0;

    if (count1 == 0) {
      galleryPath = "";
      for (int i = 0; i < directory.path.length; i++) {
        print(directory.path[i]);

        galleryPath = galleryPath + directory.path[i];

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

    _UserBox = Hive.box("Users");
    List<OnSiteTrial> ost = _UserBox?.get(userNameNow).onSiteTrials;
    int i = 0, j = 0;
    for (i = 0; i < ost.length; i++) {
      for (j = 0; j < ost[i].onSitePlots.length; j++) {
        print("${plotId}" +
            ost[i].onSitePlots[j].pltId.toString() +
            "    ${plotId == ost[i].onSitePlots[j].pltId.toString()}");
        if (plotId == ost[i].onSitePlots[j].pltId.toString()) {
          _UserBox?.get(userNameNow)
              .onSiteTrials[i]
              .onSitePlots[j]
              .plotImgPath = testpath;
          _UserBox?.get(userNameNow).save();
          print("this is save now ----------------------- " +
              _UserBox?.get(userNameNow)
                  .onSiteTrials[i]
                  .onSitePlots[j]
                  .plotImgPath);
        }
      }
    }
    setState(() {
      OnSiteTrial onSiteTrial = _UserBox?.get(userNameNow).onSiteTrials[title];
      plotList.clear();
      onSiteTrial.onSitePlots.forEach((e) {
        String isStatus = "";
        if (e.plotStatus == "Open") {
          isStatus = "Open";
        }
        plotList.addAll([
          makePlot(
            isLock: isStatus,
            plotID: e.pltId.toString(),
            feedTime: (new DateTime.fromMillisecondsSinceEpoch(e.uploadDate))
                .toString(),
            feedText:
                "Status : ${e.plotStatus}   repNO : ${e.repNo}      barcode : ${e.barcode}",
            feedImage: e.plotImgPath,
          )
        ]);
      });
    });

    // Navigator.of(context).pushNamed(PLOT_ROUTE);
  }

  Widget makeGallryButton(String plotID) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              size: 30,
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              child: InkWell(
                child: Container(
                  child: Text(
                    "Gallery",
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                ),
                onTap: () {
                  _getImage(ImageSource.gallery, plotID);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makeShareButton(String plotId) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFEEEEEE)),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.upload, color: Colors.grey, size: 30),
            SizedBox(
              width: 5,
            ),
            Container(
              child: InkWell(
                child: Container(
                  child: Text(
                    "upload1",
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                ),
                onTap: () {
                  List<OnSitePlot> ost = _UserBox?.get(userNameNow)
                      .onSiteTrials[title]
                      .onSitePlots;

                  int lenght = ost.length;

                  print("upload plot iD is" +
                      plotId.toString() +
                      " length :" +
                      lenght.toString());
                  String filePath = "";
                  for (int i = 0; i < lenght; i++) {
                    print("${ost[i].pltId} +++ ${plotId}");
                    if (ost[i].pltId.toString() == plotId.toString()) {
                      filePath = ost[i].plotImgPath;
                      print("${filePath}" + "plot id : " + plotId);
                    }
                  }

                  _upload(File(filePath), plotId);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print((int.parse(title) + 1));
    // String id = "1";
    // onGenerateRoute:
    // (settings) {
    //   id = settings.aruguments;
    // };
    //String id = ModalRoute.of(context)!.settings.arguments.toString();
    // print("== Test ==" + PlotsScreen.title);
    //print("conetext is :" + context.toString());
    // TODO: implement build
    deviceSize = MediaQuery.of(context).size;
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
                              Navigator.of(context).pushNamed(SCAN_QR_ROUTE);
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
                          size: 20,
                        ),
                        items: [
                          'all',
                          'have picture',
                          'not have picture on phone'
                        ],
                        onSelected: (value) {
                          //print(value);
                          OnSiteTrial ost =
                              _UserBox?.get(userNameNow).onSiteTrials[title];
                          int i = 0;
                          setState(() {
                            if (value == "all") {
                              loadAllPlot();
                            } else if (value == 'have picture') {
                              String isStatus = "";
                              plotList.clear();
                              ost.onSitePlots.forEach((e) {
                                isStatus = "";
                                if (e.plotStatus == "Open") {
                                  isStatus = "Open";
                                }
                                if (e.plotImgPath != "null") {
                                  plotList.addAll([
                                    makePlot(
                                      isLock: isStatus,
                                      plotID: e.pltId.toString(),
                                      feedTime: (new DateTime
                                                  .fromMillisecondsSinceEpoch(
                                              e.uploadDate))
                                          .toString(),
                                      feedText:
                                          "Status : ${e.plotStatus}   repNO : ${e.repNo}      barcode : ${e.barcode}",
                                      feedImage: e.plotImgPath,
                                    )
                                  ]);
                                }
                              });
                            } else if (value == 'not have picture on phone') {
                              plotList.clear();
                              String isStatus = "";
                              plotList.clear();
                              ost.onSitePlots.forEach((e) {
                                isStatus = "";
                                if (e.plotStatus == "Open") {
                                  isStatus = "Open";
                                }
                                if (e.plotImgPath == "null") {
                                  plotList.addAll([
                                    makePlot(
                                      isLock: isStatus,
                                      plotID: e.pltId.toString(),
                                      feedTime: (new DateTime
                                                  .fromMillisecondsSinceEpoch(
                                              e.uploadDate))
                                          .toString(),
                                      feedText:
                                          "Status : ${e.plotStatus}   repNO : ${e.repNo}      barcode : ${e.barcode}",
                                      feedImage: e.plotImgPath,
                                    )
                                  ]);
                                }
                              });
                            }
                          });
                        },
                        offset: const Offset(0, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
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
                children: plotList
                // [
                //   //SizedBox(height: 40,),
                //   Container(
                //     height: 3,
                //     color: Colors.grey[300],
                //   ),
                //   SizedBox(
                //     height: 15,
                //   ),
                //   makePlot(
                //       plotID: '54155',
                //       //userImage: 'assets/images/aiony-haust.jpg',
                //       feedTime: '1 hr ago',
                //       feedText:
                //           'All the Lorem Ipsum generators on the Internet tend to repeat predefined.',
                //       feedImage: 'assets/images/plot_corn.jpg'),
                //   makePlot(
                //       plotID: '54156',
                //       //userImage: 'assets/images/aiony-haust.jpg',
                //       feedTime: '1 hr ago',
                //       feedText:
                //           'All the Lorem Ipsum generators on the Internet tend to repeat predefined.',
                //       feedImage: 'assets/images/plot_corn.jpg'),
                //   makePlot(
                //       plotID: '54157',
                //       //userImage: 'assets/images/aiony-haust.jpg',
                //       feedTime: '1 hr ago',
                //       feedText:
                //           'All the Lorem Ipsum generators on the Internet tend to repeat predefined.',
                //       feedImage: 'assets/images/plot_corn.jpg'),
                // ]
                ,
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
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: Color(0xFF398AE5),
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.download, title: 'Download'),
          TabItem(icon: Icons.qr_code, title: 'Scan'),
          TabItem(icon: Icons.art_track, title: 'Trials'),
          TabItem(icon: Icons.bar_chart, title: 'Report'),
        ],
        initialActiveIndex: 3,
        onTap: (int i) => Navigator.of(context).pushNamed('$i'),
      ),
    );
  }

  onAllClicked(CheckBoxModal item) {
    final newValue = !item.value;
    setState(() {
      allChecked.value = !allChecked.value;
      plotItems.forEach((element) {
        element.value = newValue;
      });
    });
  }

  onItemClicked(CheckBoxModal item) {
    setState(() {
      item.value = !item.value;
    });
  }

  loadAllPlot() {
    _UserBox = Hive.box("Users");
    OnSiteTrial ost = _UserBox?.get(userNameNow).onSiteTrials[title];
    print("title is :" + ost.trialId);

    // print("build");
    int i = 0;

    String isStatus = "";
    plotList.clear();
    ost.onSitePlots.forEach((e) {
      isStatus = "";
      if (e.plotStatus == "Open") {
        isStatus = "Open";
      }
      plotList.addAll([
        makePlot(
          isLock: isStatus,
          plotID: e.pltId.toString(),
          feedTime: (new DateTime.fromMillisecondsSinceEpoch(e.uploadDate))
              .toString(),
          feedText:
              "Status : ${e.plotStatus}   repNO : ${e.repNo}      barcode : ${e.barcode}",
          feedImage: e.plotImgPath,
        )
      ]);
    });
  }
}
