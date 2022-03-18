import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:der/entities/objectlist.dart';
import 'package:der/entities/site/plot.dart';
import 'package:der/entities/site/trial.dart';
import 'package:der/entities/site/user.dart';
import 'package:der/entities/trial.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';
import 'package:der/screens/camera_screen.dart';
import 'package:der/screens/main/experiment_screen.dart';
import 'package:der/screens/main/download_screen.dart';
import 'package:der/screens/picture_screen.dart';
import 'package:der/screens/select_Image.dart';
import 'package:der/ui/page/dashboard/dashboard_one/dashboard_menu_row.dart';
import 'package:der/ui/widgets/label_below_icon.dart';
import '../../main.dart';
import '../main/signup_screen.dart';
import 'qr_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:der/utils/constants.dart';
import 'package:der/utils/router.dart';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as Http;

Box? _UserBox;
List<Trial>? trials;

class MainScreen extends StatefulWidget {
  //final List<CameraDescription> cameras;

  //({required this.cameras});

  @override
  _MainScreenState createState() => _MainScreenState();
}

// const color = const Color(0xffb74093);
const color = const Color(0xffb74093);

class _MainScreenState extends State<MainScreen> {
  Size? deviceSize;

  //final List<CameraDescription> cameras;

  late PageController _pageController;
  int _page = 0;

  _MainScreenState();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // final _UserBox = ModalRoute.of(context)!.settings.arguments as Box;
    // print("User Box len:" + _UserBox.length.toString());
    // print(_UserBox.get("Users").userName);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  dynamic _pickImageError;

  final ImagePicker _picker = ImagePicker();

  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
      );
      setState(() {
        final _imageFile = pickedFile;

        Navigator.of(context!).push(
          MaterialPageRoute(
            builder: (context) => DisplayPictureScreen(
              // Pass the automatically generated path to
              // the DisplayPictureScreen widget.
              imagePath: _imageFile!.path,
            ),
          ),
        );
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Widget makeDoughnutProgress({double? inProgress, double? finished}) {
    int fin = (finished! * 100).round();

    return Stack(children: <Widget>[
      CircularProgressIndicator(
        value: 1,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
      Center(
        child: Text('$fin' + ' '),
      ),
      CircularProgressIndicator(
        value: inProgress,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
      ),
      CircularProgressIndicator(
        value: finished,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      ),
    ]);
  }

  Widget makeMenu(
      {required String menuName,
      required String subMenuName,
      String? imageName,
      double? inProgress = 0,
      double? finished = 0,
      double? third = 0}) {
    return Container(
      height: 140,
      //width: 164,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFEEEEEE),
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFEEEEEE).withOpacity(0.5),
            ),
            child: Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: (imageName != null
                    ? Image.asset(
                        imageName,
                        fit: BoxFit.fitHeight,
                      )
                    : makeDoughnutProgress(
                        inProgress: inProgress, finished: finished)),
              ),
            ),
          ),
          SizedBox(
            width: 25,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                menuName,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subMenuName,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget makeMenuCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Card(
        elevation: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Menu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // color: Colors.blue[600],
                    color: Colors.blue[600],
                    fontWeight: FontWeight.normal,
                    fontSize: 40,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            width: 280,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(PRETEST_PLOT_ROUTE);
                              },
                              child: makeMenu(
                                  menuName: "PreTest",
                                  subMenuName: "Rating",
                                  imageName: "assets/images/unknown_user.png"),
                            )),
                        Container(
                            width: 280,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(UNMATCH_PLOT_ROUTE);
                              },
                              child: makeMenu(
                                  menuName: "UnMatch",
                                  subMenuName: "Plot",
                                  imageName: "assets/images/unknown_user.png"),
                            )),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 280,
                        child: InkWell(
                          child: makeMenu(
                              menuName: "Trials",
                              subMenuName: "Progress",
                              inProgress: 0.8,
                              finished: 0.3),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(EXPERIMENT_DASHBOARD_ROUTE);
                          },
                        ),
                      ),
                      Container(
                        width: 280,
                        child: InkWell(
                          child: makeMenu(
                              menuName: "Plot",
                              subMenuName: "Progress",
                              finished: 0.6),
                          onTap: () {
                            Navigator.of(context).pushNamed(PLOT_ROUTE);
                          },
                        ),
                      ),
                    ],
                  )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 280,
                        child: InkWell(
                          child: makeMenu(
                              menuName: "Uploaded",
                              subMenuName: "",
                              finished: 0.2),
                          onTap: () {
                            Navigator.of(context).pushNamed(NONE_UPLOAD_ROUTE);
                          },
                        ),
                      ),
                      Container(
                        width: 280,
                        child: InkWell(
                          child: makeMenu(
                              menuName: "Info",
                              subMenuName: "SYNDERRARA",
                              imageName: "assets/images/unknown_user.png"),
                          onTap: () {
                            Navigator.of(context).pushNamed(EXISTED_ROUTE);
                            //Navigator.of(context).pushNamed(UNMATCH_PLOT_ROUTE);
                          },
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget actionMenuCard() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  DashboardMenuRow(
                    firstIcon: FontAwesomeIcons.solidUser,
                    firstLabel: "Friends",
                    firstIconCircleColor: Colors.blue,
                    secondIcon: FontAwesomeIcons.userFriends,
                    secondLabel: "Groups",
                    secondIconCircleColor: Colors.orange,
                    thirdIcon: FontAwesomeIcons.mapMarkerAlt,
                    thirdLabel: "Nearby",
                    thirdIconCircleColor: Colors.purple,
                    fourthIcon: FontAwesomeIcons.locationArrow,
                    fourthLabel: "Moment",
                    fourthIconCircleColor: Colors.indigo,
                  ),
                  DashboardMenuRow(
                    firstIcon: FontAwesomeIcons.images,
                    firstLabel: "Albums",
                    firstIconCircleColor: Colors.red,
                    secondIcon: FontAwesomeIcons.solidHeart,
                    secondLabel: "Likes",
                    secondIconCircleColor: Colors.teal,
                    thirdIcon: FontAwesomeIcons.solidNewspaper,
                    thirdLabel: "Articles",
                    thirdIconCircleColor: Colors.lime,
                    fourthIcon: FontAwesomeIcons.solidCommentDots,
                    fourthLabel: "Reviews",
                    fourthIconCircleColor: Colors.amber,
                  ),
                  DashboardMenuRow(
                    firstIcon: FontAwesomeIcons.footballBall,
                    firstLabel: "Sports",
                    firstIconCircleColor: Colors.cyan,
                    secondIcon: FontAwesomeIcons.solidStar,
                    secondLabel: "Fav",
                    secondIconCircleColor: Colors.redAccent,
                    thirdIcon: FontAwesomeIcons.blogger,
                    thirdLabel: "Blogs",
                    thirdIconCircleColor: Colors.pink,
                    fourthIcon: FontAwesomeIcons.wallet,
                    fourthLabel: "Wallet",
                    fourthIconCircleColor: Colors.brown,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget allCards(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: deviceSize!.height * 0.01,
            ),
            actionMenuCard(),
            SizedBox(
              height: deviceSize!.height * 0.01,
            ),
            //balanceCard(),
          ],
        ),
      );

  Widget makeRecentExperiment({storyImage, userImage, userName}) {
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 1.6 / 2,
        child: Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: AssetImage(storyImage), fit: BoxFit.cover),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                  Colors.black.withOpacity(.9),
                  Colors.black.withOpacity(.1),
                ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      image: DecorationImage(
                          image: AssetImage(userImage), fit: BoxFit.cover)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    print("ONWILPOP CALLL!!!!!!!!!!!!!!!!!!");

    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  DateTime _lastExitTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    print("ttest");
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          /*appBar: AppBar(
        centerTitle: true,
        title: Text("Home",
        style: TextStyle(
          color: Colors.blue
        ),),
        backgroundColor: Colors.white,
        leading: Container(),
      ),*/
          //Adding SpinCircleBottomBarHolder to body of Scaffold
          body: Stack(
            fit: StackFit.expand,
            //child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    // color: Colors.cyan[700],
                    color: Color(0xFF398AE5),
                    //color top bar
                    height: 100,
                    padding: EdgeInsets.only(
                        top: 15, right: 20, left: 20, bottom: 0),

                    child: Center(
                        child: Image.asset(
                      'assets/images/Syngenta-Logo.png',
                      width: 200,
                      height: 200,
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 200,
                      //color:Colors.red,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            makeRecentExperiment(
                                storyImage: 'assets/images/corn.png',
                                userImage: 'assets/images/unknown_user.png',
                                userName: 'Aatik Tasneem'),
                            makeRecentExperiment(
                                storyImage: 'assets/images/corn.png',
                                userImage: 'assets/images/unknown_user.png',
                                userName: 'Aiony Haust'),
                            makeRecentExperiment(
                                storyImage: 'assets/images/corn.png',
                                userImage: 'assets/images/unknown_user.png',
                                userName: 'Aiony Haust'),
                            makeRecentExperiment(
                                storyImage: 'assets/images/corn.png',
                                userImage: 'assets/images/unknown_user.png',
                                userName: 'Aiony Haust'),
                            makeRecentExperiment(
                                storyImage: 'assets/images/corn.png',
                                userImage: 'assets/images/unknown_user.png',
                                userName: 'Aiony Haust'),
                          ],
                        ),
                      )),
                  SizedBox(
                    width: 20,
                  ),

                  /*Container(
                    height: 150,
                    child: TextButton(
                      child: Text('Click to show full example'),
                      onPressed: () => Navigator.of(context).pushNamed(HOME_ROUTE),
                    ),
                  ),*/

                  makeMenuCard(),
                ],
              ),
            ],
          ),
          bottomNavigationBar: ConvexAppBar(
            style: TabStyle.react,
            //color menubar
            backgroundColor: Color(0xFF398AE5),
            items: [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.download, title: 'Download'),
              TabItem(icon: Icons.qr_code, title: 'Scan'),
              TabItem(icon: Icons.art_track, title: 'Trials'),
              TabItem(icon: Icons.bar_chart, title: 'Report'),
            ],
            initialActiveIndex: 0,
            onTap: (int i) =>
                Navigator.of(context).pushNamed('$i', arguments: _UserBox),
          ),

          /*(
        bottomNavigationBar: SCBottomBarDetails(

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

              }),
              SCBottomBarItem(icon: Icons.details, title: "New Data", onPressed: () {

               // Navigator.pushReplacementNamed(context, LoadDataScreen(title: 'Load Experiment')));
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoadDataScreen(title: 'Load Experiment')));

              }),
              SCBottomBarItem(icon: Icons.upload_file_sharp, title: "Upload", onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ExperimentScreen()));
              }),
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
        ),
        child: Stack(
          fit: StackFit.expand,
          children:[
            LabelBelowIcon(
              icon: FontAwesomeIcons.solidUser,
              label: "Friends" ,
              //onPressed ( print("test")),
            ),
          ],
        ),
      ),*/

          //),
        ));
    // TODO: implement build
    throw UnimplementedError();
  }
}
