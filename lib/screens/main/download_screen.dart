//use to dowload data from http
import 'dart:io';

import 'package:der/entities/site/user.dart';
import 'package:der/screens/main/main_screen.dart';
import 'package:http/http.dart' as Http;
import 'dart:convert';
import 'package:der/entities/objectlist.dart';
import 'package:der/entities/trial.dart';

//hive
import 'package:hive/hive.dart';
import 'package:der/entities/site/trial.dart';
import 'package:der/entities/site/plot.dart';
import 'package:der/entities/site/enum.dart';
import 'package:der/screens/signup_screen.dart';

import 'package:path_provider/path_provider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:der/main.dart';
import 'package:flutter/material.dart';
import 'package:der/model/check_box.dart';
import 'package:der/screens/plot/plot_screen.dart';

import 'package:der/screens/signup_screen.dart';

import 'package:der/screens/signup_screen.dart';
import 'package:der/screens/main/qr_screen.dart';

//check internet
import 'package:connectivity_plus/connectivity_plus.dart';

int i = 0;
Box? _UserBox;
bool _isConnectionSuccessful = false;

List<Trial> trials = [];
//String? userNameNow;

class DownloadScreen extends StatefulWidget {
  @override
  _DownloadScreen createState() => _DownloadScreen();

  //DownloadScreen({Key? key, required this.title}) : super(key: key);

  //final String title;

}

class _DownloadScreen extends State<DownloadScreen> {
  initState() {
    super.initState();

    _UserBox = Hive.box("Users");
    _tryConnection().then((value) => {
          if (!_isConnectionSuccessful)
            {useShowDialog("no internet connection", context)}
        });

    loadData();
  }

  bool isLoading = false;

  Widget makeMe() {
    return Column();
  }

  static List<WidgetCheckBoxModel>? experimentItems = [];

  _LoadDataScreen() {}

  Future loadData() async {
    int i, page = 1;

    String token = _UserBox!.get(userNameNow).token;
    await _tryConnection();
    if (_isConnectionSuccessful) {
      String url = "$SERVER_IP/syngenta/api/trial/user/trials";
      var response = await Http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${token}'
        },
      );
      var json = jsonDecode(response.body);
      trials = ObjectList<Trial>.fromJson(
          jsonDecode(response.body), (body) => Trial.fromJson(body)).list;
    } else {
      trials = [];
    }
    //trial on phone
    List<OnSiteTrial> trialsUser = _UserBox?.get(userNameNow).onSiteTrials;

    /////////////////////////////more faster if sorting////////////////////////////////////////////////////////////////////////////////////
    trialsUser.forEach((e) {
      for (int i = 0; i < trials.length; i++) {
        if (trials[i].trialId == e.trialId) {
          //check id
          // if (trials[i].lastUpdate <= e.lastUpdate) {
          //check last uupdate
          trials.removeAt(i);
          // }
        }
      }
    });

    setState(() {
      experimentItems!.clear();

      for (i = 0; i < trials.length; i++) {
        experimentItems!.addAll([
          WidgetCheckBoxModel(
              title: '$page',
              trial:
                  '${trials[i].trialId}\n${(new DateTime.fromMillisecondsSinceEpoch(trials[i].lastUpdate)).toString()}')
        ]);
        page++;
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
        children: [
          Expanded(
            child: Align(
              alignment: AlignmentDirectional(-0.95, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.05, 0.05),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.asset(
                        userImage,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 490,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
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
                'Trial' + experimentItems![index].title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
              //               SizedBox(height: 20),

              subtitle: Text(
                experimentItems![index].trial,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
              tileColor: Colors.white,
              dense: false,
              controlAffinity: ListTileControlAffinity.trailing,
            ),
          ),
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
          Container(
            color: Color(0xFF398AE5),
            height: 100,
            padding: EdgeInsets.only(top: 40, right: 20, left: 20, bottom: 10),
            child: Row(
              children: <Widget>[
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
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                      hintText: "Search trail",
                    ),
                  ),
                )),
                //SizedBox(width: 10,),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          " Trials on sever",
                          //"Plot ID = " + dataCode,
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              letterSpacing: 1),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Checkbox(
                              value: allChecked.value,
                              checkColor: Colors.grey[200],
                              onChanged: (value) => onAllClicked(allChecked)),
                        ),
                      ],
                    ),
                    Container(
                      height: 2,
                      color: Colors.grey[300],
                    ),
                    //SizedBox(height: 20,),
                    Container(
                      height: 660,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          // if (!isLoading) {
                          //   if (_isConnectionSuccessful == false) {
                          //     showDialog<void>(
                          //       context: context,
                          //       builder: (BuildContext context) {
                          //         return AlertDialog(
                          //           title: const Text('Internet have problem'),
                          //           content: Text('Please try again'),
                          //           actions: <Widget>[
                          //             TextButton(
                          //               onPressed: () {
                          //                 Navigator.pop(context);
                          //               },
                          //               child: const Text('OK'),
                          //             ),
                          //           ],
                          //         );
                          //       },
                          //     );
                          //   }
                          // }
                          if (!isLoading &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            _tryConnection();
                            if (!_isConnectionSuccessful) {
                              useShowDialog("no internet connection", context);
                            }

                            loadData();

                            // if (!_isConnectionSuccessful) {
                            //   useShowDialog("no internet connection", context);
                            // }
                            setState(() {
                              print("isloading");
                              isLoading = true;
                            });
                          }

                          return isLoading;
                        },
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
                              child: Column(
                                children: [
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
          //loadNewData(),
          Container(
            height: isLoading ? 50.0 : 0,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          ),
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
        initialActiveIndex: 1,
        onTap: (int i) => Navigator.of(context).pushNamed('$i'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onDownload,
        icon: Icon(Icons.save),
        label: Text("Load"),
      ),
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
    // List<String> un_match_onload = _UserBox!.get(userNameNow).unMatchPlots;
    List<OnSiteTrial> allTrialOnLoad = [];
    // String userNameNow = await getUserFromSF();
    //await new Future.delayed(new Duration(seconds: 2));

    for (int k = 0; k < experimentItems!.length; k++) {
      if (experimentItems![k].value) {
        List<OnSitePlot> osps = [];
        if (trials[k].plots.isNotEmpty) {
          trials[k].plots.forEach((e) {
            osps.add(OnSitePlot(
                e.plotId,
                e.barcode,
                e.repNo,
                e.abbrc,
                e.entno,
                e.notet,
                e.plotImgPath,
                e.plotImgPathS,
                e.plotImgBoxPath,
                e.plotImgBoxPathS,
                e.uploadDate,
                e.eartnA,
                e.dlernA,
                e.dlerpA,
                e.drwapA,
                e.eartnM,
                e.dlernM,
                e.dlerpM,
                e.drwapM,
                e.approveDate,
                e.plotProgress,
                e.plotStatus,
                e.plotActive));
          });
        }
        OnSiteTrial ost = OnSiteTrial(
            trials[k].trialId,
            trials[k].aliasName,
            trials[k].trialActive,
            trials[k].trialStatus,
            trials[k].createDate,
            trials[k].lastUpdate,
            osps);
        removeTrialsOnPhoneMatch(ost);
        allTrialOnLoad.add(ost);
      }
    }
    _UserBox?.get(userNameNow).onSiteTrials.addAll(allTrialOnLoad);
    _UserBox?.get(userNameNow).save();
    // if (un_match_onload.length > 0) {

    //     print("plots on load is match on unmatch plots :   ${un_match_onload}");
    // }

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

  useShowDialog(String title, BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text('Please try again'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  removeTrialsOnPhoneMatch(OnSiteTrial ost) {
    List<OnSiteTrial> trialOnPhone = _UserBox?.get(userNameNow).onSiteTrials;
    for (int z = 0; z < trialOnPhone.length; z++) {
      if (ost.trialId == trialOnPhone[z].trialId) {
        _UserBox?.get(userNameNow).onSiteTrials.removeAt(z);
        print("remove trial on phone :${ost.trialId}");
      }
    }
    _UserBox?.get(userNameNow).save();
  }

  onItemClicked(CheckBoxModal item) {
    setState(() {
      item.value = !item.value;
    });
  }

  Future<void> _tryConnection() async {
    try {
      final response = await InternetAddress.lookup('www.google.com');

      setState(() {
        _isConnectionSuccessful = response.isNotEmpty;
      });
    } on SocketException catch (e) {
      _isConnectionSuccessful = false;
    }
  }
}
