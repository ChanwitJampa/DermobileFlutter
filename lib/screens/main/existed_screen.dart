//use to dowload data from http
import 'package:der/entities/site/user.dart';
import 'package:der/utils/constants.dart';
import 'package:http/http.dart' as Http;
import 'dart:convert';
import 'package:der/entities/objectlist.dart';
import 'package:der/entities/trial.dart';

//hive
import 'package:hive/hive.dart';
import 'package:der/entities/site/trial.dart';
import 'package:der/entities/site/plot.dart';
import 'package:der/entities/site/enum.dart';
import 'package:der/screens/main/signup_screen.dart';

import 'package:path_provider/path_provider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:der/main.dart';
import 'package:flutter/material.dart';
import 'package:der/model/check_box.dart';
import 'package:der/screens/plot/plot_screen.dart';

int i = 0;
Box? _UserBox;

List<Trial>? trials;
//String? userNameNow;

class ExistedScreen extends StatefulWidget {
  @override
  _ExistedScreen createState() => _ExistedScreen();

  //DownloadScreen({Key? key, required this.title}) : super(key: key);

  //final String title;

}

class _ExistedScreen extends State<ExistedScreen> {
  initState() {
    super.initState();
    getBox();
    _UserBox = Hive.box("Users");

    _loadData().then((value) => {
          experimentItems!.clear(),
          for (i = 0; i < _UserBox!.length; i++)
            {
              experimentItems!.addAll([
                WidgetCheckBoxModel(
                    title: '${_UserBox!.getAt(i).userName}', trial: '')
              ])
            }
        });
  }

  bool isLoading = false;

  Widget makeMe() {
    return Column();
  }

  static List<WidgetCheckBoxModel>? experimentItems = [];

  _LoadDataScreen() {}

  Future _loadData() async {
    _UserBox = Hive.box("Users");
    print("------ all user is  ${_UserBox!.length}");

    //await new Future.delayed(new Duration(seconds: 1));

    setState(() {
      experimentItems!.clear();

      for (i = 0; i < _UserBox!.length; i++) {
        experimentItems!.addAll([
          WidgetCheckBoxModel(
              title: '${_UserBox!.getAt(i).userName}', trial: '')
        ]);
      }

      isLoading = false;
    });
  }

  late List<bool> _isChecked;

  Widget makeExperiment(
      {userImage = "assets/images/unknown_user.png",
      experimentImage = "assets/images/corn.png",
      userName,
      index = 0}) {
    return Align(
      alignment: AlignmentDirectional(0, 0.25),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Container(
              width: 530,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFF398AE5),
                  width: 5,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: CheckboxListTile(
                value: experimentItems![index].value,
                onChanged: (value) {
                  setState(() {
                    experimentItems![index].value =
                        !experimentItems![index].value;
                  });
                },
                title: Text(
                  experimentItems![index].title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
                //               SizedBox(height: 20),
                subtitle: Text(
                  "Last Time Login " + experimentItems![index].trial,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
                tileColor: Colors.white,
                dense: false,
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ),
          )
        ],
      ),
    );
  }

  final allChecked = CheckBoxModal(title: 'All Checked');

  int index = 0;

  Future<void> _pullRefresh() async {
    //List<WordPair> freshWords = await WordDataSource().getFutureWords(delay: 2);
    setState(() {
      print('pull');
    });
    // why use freshWords var? https://stackoverflow.com/a/52992836/2301224
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(60, 50, 0, 0),
                          child: Text(
                            "EXISTED USER",
                            //"Plot ID = " + dataCode,
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w400,
                                fontSize: 50,
                                fontFamily: 'Poppins',
                                letterSpacing: 1),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    //SizedBox(height: 20,),
                    Container(
                      height: 640,
                      child: Container(
                        child: RefreshIndicator(
                          onRefresh: _pullRefresh,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                              color: Colors.grey[200],
                              thickness: 2,
                            ),
                            itemCount: experimentItems!.length,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.all(8.0),
                              /*child: makeExperiment(
                                storyImage: 'assets/images/story/story-1.jpg',
                                userImage: 'assets/images/corn.png',
                                userName: 'Aatik Tasneem',
                                index:index ),
                              ),*/
                              child: Column(
                                children: [
                                  makeExperiment(
                                    //userImage: 'assets/images/corn.png',
                                    //experimentImage: 'assets/images/corn.png',
                                    userName: experimentItems![index].title,
                                    index: index,
                                  ),
                                  makeExperiment(
                                    //userImage: 'assets/images/corn.png',
                                    //experimentImage: 'assets/images/corn.png',
                                    userName: experimentItems![index].title,
                                    index: index,
                                  ),
                                  makeExperiment(
                                    //userImage: 'assets/images/corn.png',
                                    //experimentImage: 'assets/images/corn.png',
                                    userName: experimentItems![index].title,
                                    index: index,
                                  ),
                                  makeExperiment(
                                    //userImage: 'assets/images/corn.png',
                                    //experimentImage: 'assets/images/corn.png',
                                    userName: experimentItems![index].title,
                                    index: index,
                                  ),
                                  makeExperiment(
                                    //userImage: 'assets/images/corn.png',
                                    //experimentImage: 'assets/images/corn.png',
                                    userName: experimentItems![index].title,
                                    index: index,
                                  ),
                                  makeExperiment(
                                    //userImage: 'assets/images/corn.png',
                                    //experimentImage: 'assets/images/corn.png',
                                    userName: experimentItems![index].title,
                                    index: index,
                                  ),
                                  makeExperiment(
                                    //userImage: 'assets/images/corn.png',
                                    //experimentImage: 'assets/images/corn.png',
                                    userName: experimentItems![index].title,
                                    index: index,
                                  ),
                                  makeExperiment(
                                    //userImage: 'assets/images/corn.png',
                                    //experimentImage: 'assets/images/corn.png',
                                    userName: experimentItems![index].title,
                                    index: index,
                                  ),
                                  makeExperiment(
                                    //userImage: 'assets/images/corn.png',
                                    //experimentImage: 'assets/images/corn.png',
                                    userName: experimentItems![index].title,
                                    index: index,
                                  ),
                                  makeExperiment(
                                    //userImage: 'assets/images/corn.png',
                                    //experimentImage: 'assets/images/corn.png',
                                    userName: experimentItems![index].title,
                                    index: index,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: const Color(0xff03dac6),
      //   foregroundColor: Colors.black,
      //   onPressed: () {
      //     Navigator.of(context).pushNamed(SIGNUP_ROUTE);
      //   },
      //   label: Text(
      //     "New User",
      //     style: TextStyle(
      //         color: Colors.black,
      //         fontWeight: FontWeight.w400,
      //         fontSize: 20,
      //         fontFamily: 'Poppins',
      //         letterSpacing: 1),
      //   ),
      // ),
    );
  }

  onAllClicked(CheckBoxModal item) {
    final newValue = !item.value;

    setState(() {
      allChecked.value = !allChecked.value;
      experimentItems!.forEach((element) {
        element.value = newValue;
      });
    });
  }

  Future onDownload() async {
    // String userNameNow = await getUserFromSF();
    //await new Future.delayed(new Duration(seconds: 2));
    ////////////////////////////more faster if sorting with "value" //////////////////////////////

    //////////////////////////////////////////////////////////////////////////////////////////
    setState(() {
      for (int k = 0; k < experimentItems!.length; k++) {
        if (experimentItems![k].value) {
          // print("${trials?[k].trialId} -- " +experimentItems![k].trial.toString());
          //print("remove is :" + experimentItems![k].trial.toString());
          experimentItems!.removeAt(k--);
        }
      }
    });
  }

  onItemClicked(CheckBoxModal item) {
    setState(() {
      item.value = !item.value;
    });
  }
}

// getUserFromSF() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String username = prefs.getString('userNow').toString();
//   //print("get userName :" + username);
//   return username;
// }

getBox() async {
  //String user = await getUserFromSF();
  // String userNameNow = await getUserFromSF();

  _UserBox = Hive.box("Users");

  // print(
  //     "OpenBox username $userNameNow:${_UserBox?.get(userNameNow).userName.toString()}");
}
