import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:der/main.dart';
import 'package:der/utils/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';
import 'package:der/model/check_box.dart';
import 'package:der/screens/main/main_screen.dart';
import 'package:der/ui/widgets/label_below_icon.dart';
import 'package:der/utils/app_popup_menu.dart';
import 'package:der/utils/constants.dart';

class PlotsScreen extends StatefulWidget {
  final String title;
  PlotsScreen({Key? key, required this.title}) : super(key: key);

  @override
  _PlotsScreen createState() => _PlotsScreen(this.title);
}

class _PlotsScreen extends State<PlotsScreen> {
  final String title;
  Size? deviceSize;

  _PlotsScreen(this.title);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(title);
  }

  final allChecked = CheckBoxModal(title: 'All Checked');

  final plotItems = [
    CheckBoxModal(title: 'CheckBox 1'),
    CheckBoxModal(title: 'CheckBox 2'),
    CheckBoxModal(title: 'CheckBox 3'),
  ];
  bool isLoading = false;

  Future _loadData() async {
    await new Future.delayed(new Duration(seconds: 2));

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
              InkWell(
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/arrow_curved_forward_right_2.png'),
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
            Icon(Icons.upload, color: Colors.grey, size: 18),
            SizedBox(
              width: 5,
            ),
            Text(
              "Upload",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                color: Colors.blue,
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
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.download, title: 'Download'),
          TabItem(icon: Icons.qr_code, title: 'Scan'),
          TabItem(icon: Icons.art_track, title: 'Experiment'),
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
}
