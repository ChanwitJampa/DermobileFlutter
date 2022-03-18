import 'dart:io';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:der/entities/site/plot.dart';

import 'package:der/entities/site/trial.dart';
import 'package:flutter/material.dart';
import 'package:der/screens/plot/plot_screen.dart';
import 'package:der/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import 'package:der/entities/site/trial.dart';
import 'package:der/entities/trial.dart';

import 'package:der/screens/main/signup_screen.dart';

import 'package:der/screens/main/main_screen.dart';
import 'package:http/http.dart' as Http;
import 'dart:convert';
import 'package:der/entities/objectlist.dart';
import 'package:der/entities/trial.dart';

final _formKey = GlobalKey<FormState>();

class ExperimentScreen extends StatefulWidget {
  _ExperimentScreen createState() => _ExperimentScreen();
}

Box? _UserBox;

List<Widget> makeExperiments = [];
bool _isConnectionSuccessful = false;

class _ExperimentScreen extends State<ExperimentScreen> {
  List<OnSiteTrial>? ost;
  initState() {
    super.initState();
    _UserBox = Hive.box("Users");

    fetchTrialsOnSever()
        .then((e) => {loadAllTrials(_UserBox?.get(userNameNow).onSiteTrials)});
  }

  Widget makeDoughnutProgress({double? inProgress, double? finished}) {
    int fin = (finished! * 100).round();

    return Stack(children: <Widget>[
      CircularProgressIndicator(
        value: 1,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
      Positioned(right: 6, top: 10, child: Text('$fin' + ' ')),
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

  Widget makeExperiment(
      {index,
      experimentID,
      userImage = "assets/images/unknown_user.jpg",
      feedTime,
      feedText,
      feedImage,
      finishPercent = 0.5,
      inprogressPercent = 0.9,
      percentText}) {
    return GestureDetector(
      onTap: () {
        //Navigator.pushNamedAndRemoveUntil(context, PLOT_ROUTE, (route) => false,arguments: experimentID);
        //Navigator.of(context).pushNamed('$i')
        // Navigator.pushReplacementNamed(context, PLOT_ROUTE,(Route<dynamic> route) => false,arguments: experimentID);
        //print("Test 1 :" + experimentID);
        //print("testtest: " + context.toString());
        Navigator.pushNamed(context, PLOT_ROUTE, arguments: index);

        //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlotsScreen(title: experimentID)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    /*Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(userImage),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),*/
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          experimentID,
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          feedTime,
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    size: 30,
                    color: Colors.red[900],
                    // color: Colors.grey[600],
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Delete trial'),
                            content: Text('Confirm to delete this trial'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  //--------------------------------delete trial-------------------------------------
                                  // print(index);
                                  _UserBox!
                                      .get(userNameNow)
                                      .onSiteTrials
                                      .removeAt(index);
                                  _UserBox!.get(userNameNow).save();
                                  loadAllTrials(
                                      _UserBox?.get(userNameNow).onSiteTrials);
                                  Navigator.pop(context);
                                },
                                child: Text('Delete'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancle'),
                              )
                            ],
                          );
                        });
                  },
                )
              ],
            ),
            SizedBox(
              height: 0,
            ),
            Text(
              feedText,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[800],
                  height: 1.5,
                  letterSpacing: .7),
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                feedImage != ''
                    ? Container(
                        height: 300,
                        child: Stack(
                          children: [Container()],
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(feedImage),
                                fit: BoxFit.cover)),
                      )
                    : Container(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      makeDoughnutProgress(
                          inProgress: inprogressPercent,
                          finished: finishPercent),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        percentText,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[800],
                            height: 1.5,
                            letterSpacing: .7),
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //makeCameraButton(),
                //makeGallryButton(),
                //makeShareButton(),
              ],
            ),
            Container(
              height: 3,
              color: Colors.grey[300],
            )
          ],
        ),
      ),
    );
  }

Future<bool> _onWillPop() async {


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

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop:  _onWillPop,
        child:Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            // color: Colors.blue,
            color: Color(0xFF398AE5),
            height: 100,
            padding: EdgeInsets.only(top: 40, right: 20, left: 20, bottom: 10),
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
                        color: Colors.grey[600],
                      ),
                      border: InputBorder.none,
                      hintStyle:
                          TextStyle(color: Colors.grey[600], fontSize: 20),
                      hintText: "Search Trials",
                    ),
                  ),
                )),
              ],
            ),
          ),
          Container(
            height: 3,
            color: Colors.grey[300],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: makeExperiments,
                ),
              ),
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
        initialActiveIndex: 3,
        onTap: (int i) => Navigator.of(context).pushNamed('$i'),
      ),
    ))
    ;
  }

  int numPlot = 0;
  int numImg = 0 ; 

  double percentPath = 0.00;

  List<double> listPercent = [];

  loadAllTrials(List<OnSiteTrial> ost) {
    //print("load All");
    //print(ost.length);

    List<OnSiteTrial> ListTrial = _UserBox?.get(userNameNow).onSiteTrials;

    for (int i = 0; i < ListTrial.length; i++) {
      numPlot = 0 ;
      numImg = 0 ;
      print("Trial = " + (i+1).toString());

      for (int j = 0; j < ListTrial[i].onSitePlots.length; j++) {

        // print("trial[i] = " +(i+1).toString() +" plot[j] = " + (j+1).toString() +" path : " + ListTrial[i].onSitePlots[j].plotImgPath);

        numPlot++;

        if(ListTrial[i].onSitePlots[j].plotImgPath != "null")
        {
          numImg++;

        }

        // print("numplot :" + numPlot.toString() + " numImg :" + numImg.toString());

      }
      percentPath = numImg.toDouble()/numPlot.toDouble();
      listPercent.add(percentPath);

      // print("percent Trial " + (i+1).toString() + " : " + percentPath.toString() + "%");
    }

  print(listPercent);
    
    int i = 0;
    setState(() {
      makeExperiments.clear();
      ost.forEach((e) {
        makeExperiments.addAll([
          makeExperiment(
              index: i,
              experimentID: e.trialId,
              userImage: 'assets/images/aiony-haust.jpg',
              feedTime: 'last update ' +
                  (new DateTime.fromMillisecondsSinceEpoch(e.lastUpdate))
                      .toString(),
              feedText: '  index : ${i}  plots = ${e.onSitePlots.length}',
              feedImage: 'assets/images/corn.png',
              inprogressPercent: listPercent[i],
              finishPercent: listPercent[i],
              // percentText: 'inprogress: 90 % finished: 50 %')
              percentText: "percent of work = " + listPercent[i].toString())
        ]);
        i++;
      });
    });
  }

  fetchTrialsOnSever() async {
    String token = _UserBox!.get(userNameNow).token;
    List<Trial> trials = [];
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
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        trials = ObjectList<Trial>.fromJson(
            jsonDecode(response.body), (body) => Trial.fromJson(body)).list;

        // print(trials.length);
        List<OnSiteTrial> trialsUser = _UserBox?.get(userNameNow).onSiteTrials;

        //update trials on phone
        for (int i = 0; i < trials.length; i++) {
          for (int j = 0; j < trialsUser.length; j++) {
            if (trials[i].trialId == trialsUser[j].trialId) {
              if (trials[i].lastUpdate > trialsUser[j].lastUpdate) {
                OnSiteTrial trial = createOnSiteTrialsWithTrials(trials[i]);
                _UserBox?.get(userNameNow).onSiteTrials[j] =
                    compareAndUpdateTrial(trial, trialsUser[j]);
                print("Update Trials ${j}: ${trials[i].trialId}");
                break;
              }
            }
          }
        }
        _UserBox?.get(userNameNow).save();
      }
    }
  }

  OnSiteTrial compareAndUpdateTrial(
      OnSiteTrial trialsOnSever, OnSiteTrial trialOnPhone) {
    for (int i = 0; i < trialOnPhone.onSitePlots.length; i++) {
      for (int j = 0; j < trialsOnSever.onSitePlots.length; j++) {
        if (trialOnPhone.onSitePlots[i].pltId ==
            trialsOnSever.onSitePlots[j].pltId) {
          trialsOnSever.onSitePlots[j].plotImgPath =
              trialOnPhone.onSitePlots[i].plotImgPath;
        }
      }
    }
    return trialsOnSever;
  }

  Future<void> _tryConnection() async {
    try {
      final response = await InternetAddress.lookup('www.google.com');

      setState(() {
        _isConnectionSuccessful = response.isNotEmpty;
      });
    } on SocketException catch (e) {
      setState(() {
        _isConnectionSuccessful = false;
      });
    }
  }

  OnSiteTrial createOnSiteTrialsWithTrials(Trial trial) {
    List<OnSitePlot> osps = [];
    OnSiteTrial ost = OnSiteTrial(
        trial.trialId,
        trial.aliasName,
        trial.trialActive,
        trial.trialStatus,
        trial.createDate,
        trial.lastUpdate,
        osps);
    if (trial.plots.isNotEmpty) {
      trial.plots.forEach((e) {
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
            e.plotActive,
            0));
      });
    }
    return ost;
  }
}
