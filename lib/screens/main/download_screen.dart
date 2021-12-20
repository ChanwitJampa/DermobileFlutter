//use to dowload data from http
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
import 'package:shared_preferences/shared_preferences.dart';

import 'package:der/screens/signup_screen.dart' as a;

int i = 0;
// Box? _UserBox;

class DownloadScreen extends StatefulWidget {
  @override
  _DownloadScreen createState() => _DownloadScreen();

  //DownloadScreen({Key? key, required this.title}) : super(key: key);

  //final String title;

}

class _DownloadScreen extends State<DownloadScreen> {
  void initState() {
    super.initState();
    // final _UserBox = ModalRoute.of(context)?.settings.arguments as Box;
    // _openBox();
    // print(_UserBox?.length);
    // _UserBox?.get("Users");
    // print("userName IS:");
    // print(_UserBox?.getAt(0).userName.toString());
    //print("-----now is dowload sceen---- #initState");
  }

  // void _openBox() async {
  //   var dir = await getApplicationDocumentsDirectory();
  //   Hive.init(dir.path);
  //   // print('[Debug] Hive path: ${dir.path}');
  //   // _UserBox = await Hive.openBox('User');
  // }

  bool isLoading = false;

  Widget makeMe() {
    return Column();
  }

  static List<WidgetCheckBoxModel>? experimentItems = [];

  _LoadDataScreen() {}

  Future _loadData() async {
    int i, page = 1;
    var token = await getTokenFromSF();
    print("token :" + token.toString());
    var url = 'http://10.0.2.2:8080/syngenta/api/trial/user/trials';
    var response = await Http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    var json = jsonDecode(response.body);

    print(response.body);

    List<Trial> trials = ObjectList<Trial>.fromJson(
        jsonDecode(response.body), (body) => Trial.fromJson(body)).list;
    //print(trials[0].plots.length);
    print("Trial length : " + trials.length.toString());
    print(_UserBox?.length.toString());

    await new Future.delayed(new Duration(seconds: 1));

    //print("load more");
    // update data and loading status
    setState(() {
      experimentItems!.clear();

      //Rest Service
      //print("page : $page    index : $index      i: $i   j:$j   ");
      for (i = 0; i < trials.length; i++) {
        experimentItems!.addAll([
          WidgetCheckBoxModel(
              //title: '${_TrialBox?.getAt(i).onSitePlots[j].plotId.toString()}')
              title: '$page',
              trial: '${trials[i].trialId}')
        ]);

        page++;
      }
      //experimentItems!.removeAt(experimentItems!.length-1);
      //print('push');

      isLoading = false;
    });
  }

  late List<bool> _isChecked;

  Widget makeExperiment(
      {userImage = "assets/images/unknown_user.png",
      experimentImage = "assets/images/corn.png",
      userName,
      index = 0}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      //borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          image: AssetImage(userImage), fit: BoxFit.cover)),
                ),
              ],
            ),
            Container(
              child: Checkbox(
                  value: experimentItems![index].value,
                  checkColor: Colors.grey[200],
                  onChanged: (value) {
                    setState(() {
                      experimentItems![index].value =
                          !experimentItems![index].value;
                    });
                  }),
            ),
          ],
        ),
        Container(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    //borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        image: AssetImage(experimentImage), fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   userName,
                  //   style: TextStyle(
                  //       fontSize: 15,
                  //       color: Colors.grey[800],
                  //       height: 1.5,
                  //       letterSpacing: .7),
                  // ),
                  Text(
                    "Trial No. = " + experimentItems![index].title,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[800],
                        height: 1.5,
                        letterSpacing: .7),
                  ),
                  // Text(
                  //   //trial ID
                  //   "plot Id :"
                  //   '${experimentItems![index].plot}',
                  //   style: TextStyle(
                  //       fontSize: 15,
                  //       color: Colors.grey[800],
                  //       height: 1.5,
                  //       letterSpacing: .7),
                  // ),
                  Text(
                    experimentItems![index].trial,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[800],
                        height: 1.5,
                        letterSpacing: .7),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

/*
  Widget loadNewData(){
    return Expanded(
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo)  {

          if (!isLoading && scrollInfo.metrics.pixels ==
              scrollInfo.metrics.maxScrollExtent) {
            _loadData();
            // start loading data
            setState(() {
              isLoading = true;
            });
          }
          return isLoading;
        },
        child: ListView.builder(
          itemCount: experimentItems!.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("test"),
              subtitle: Text("Sample Subtitle. \nSubtitle line 3"),
              trailing: Icon(Icons.home),
              onTap: (){
                //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ExperimentScreen(title: experimentItems[index].title)));
              },
              //value: items[index].isChecked,
              //onChanged: (val) {
              //  setState(
              //        () {
              //          items[index].isChecked = val! ;
              //    },
            );
          },
          //  );
          // },
        ),
      ),
    );
  }

 */
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
            color: Colors.blue,
            height: 135,
            padding: EdgeInsets.only(top: 50, right: 20, left: 20, bottom: 10),
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
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "Search",
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
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          "Trial",
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              letterSpacing: 1.2),
                        ),
                        Container(
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
                      height: 500,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!isLoading &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            _loadData();
                            setState(() {
                              isLoading = true;
                            });
                          }
                          return isLoading;
                        },
                        child: RefreshIndicator(
                          onRefresh: _pullRefresh,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                              color: Colors.black,
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
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.download, title: 'Download'),
          TabItem(icon: Icons.qr_code, title: 'Scan'),
          TabItem(icon: Icons.art_track, title: 'Trial'),
          TabItem(icon: Icons.bar_chart, title: 'Report'),
        ],
        initialActiveIndex: 1,
        onTap: (int i) => Navigator.of(context).pushNamed('$i'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onDownload,
        icon: Icon(Icons.save),
        label: Text("Load1"),
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
    await new Future.delayed(new Duration(seconds: 2));

    setState(() {
      for (int k = 0; k < experimentItems!.length; k++) {
        if (experimentItems![k].value) {
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

getTokenFromSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String tokenValue = prefs.getString('token').toString();
  return tokenValue;
}
