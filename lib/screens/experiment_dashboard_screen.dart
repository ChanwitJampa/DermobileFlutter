import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:der/utils/constants.dart';
import 'package:der/utils/scroll_to_index.dart';

import 'package:visibility_detector/visibility_detector.dart';
import 'package:hive/hive.dart';

import 'dart:math' as math;

Box? _UserBox;

class ExperimanetDashBoardScreen extends StatefulWidget {
  _ExperimanetDashBoardScreen createState() => _ExperimanetDashBoardScreen();
}

class _ExperimanetDashBoardScreen extends State<ExperimanetDashBoardScreen> {
  late AutoScrollController controller;

  late List<List<int>> randomList;

  static const maxCount = 100;
  final random = math.Random();

  @override
  void initState() {
    super.initState();
    _UserBox = Hive.box('Users');

    print('test');
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.horizontal);
    randomList = List.generate(maxCount,
        (index) => <int>[index, (1000 * random.nextDouble()).toInt()]);
  }

  Widget _wrapScrollTag({required int index, required Widget child}) =>
      AutoScrollTag(
        key: ValueKey(index),
        controller: controller,
        index: index,
        child: child,
        highlightColor: Colors.black.withOpacity(0.1),
      );

  Widget _getRow(int index, double height) {
    return _wrapScrollTag(
      index: index,
      child: InkWell(
        onTap: () {
          setState(() {
            counter = index;
          });
        },
        child: Container(
          width: 300,
          padding: EdgeInsets.all(8),
          alignment: Alignment.topCenter,
          height: height,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlue, width: 4),
              borderRadius: BorderRadius.circular(12)),
          child: Text('index: $index, height: $height'),
        ),
      ),
    );
  }

  int _currentItem = 0;

  Widget makeDoughnutProgress({double? inProgress, double? finished}) {
    int fin = (finished! * 100).round();

    return Stack(children: <Widget>[
      //SizedBox(width: 10,),
      CircularProgressIndicator(
        value: 1,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
      Positioned(right: 6, bottom: 10, child: Text('$fin' + ' ')),

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
      {experimentID,
      userImage = "assets/images/unknown_user.jpg",
      feedTime,
      feedText,
      feedImage}) {
    return GestureDetector(
      onTap: () {
        //Navigator.pushNamedAndRemoveUntil(context, PLOT_ROUTE, (route) => false,arguments: experimentID);
        //Navigator.of(context).pushNamed('$i')
        // Navigator.pushReplacementNamed(context, PLOT_ROUTE,(Route<dynamic> route) => false,arguments: experimentID);
        Navigator.pushNamed(context, PLOT_ROUTE, arguments: experimentID);
        //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlotsScreen(title: experimentID)));
      },
      child: Container(
        //margin: EdgeInsets.only(bottom: 20),
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
                    //SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          experimentID,
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1),
                        ),
                        SizedBox(
                          height: 10,
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
                )
              ],
            ),
            //SizedBox(height: 20,),
            Text(
              feedText,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[800],
                  height: 1.5,
                  letterSpacing: .7),
            ),
            //SizedBox(height: 20,),

            Stack(
              children: [
                makeDoughnutProgress(inProgress: 0.6, finished: 0.6),
                feedImage != ''
                    ? Container(
                        height: 160,
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
          ],
        ),
      ),
    );
  }

  Widget makeExperimentDatail() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            color: Colors.blue,
          ),
          Container(
            height: 265,
            width: 400,
            //color: Colors.blue,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return VisibilityDetector(
                    key: Key(index.toString()),
                    onVisibilityChanged: (VisibilityInfo info) {
                      if (info.visibleFraction == 1)
                        setState(() {
                          _currentItem = index;
                          print(_currentItem);
                        });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: Container(
                        //color: Colors.blue,
                        decoration: BoxDecoration(
                            //color: Colors.blue[200],
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                colors: [
                                  Colors.black.withOpacity(.9),
                                  Colors.black.withOpacity(.1),
                                ])),
                        width: 310,
                        height: 140,
                        //margin: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: makeExperiment(
                            experimentID: '54155',
                            //userImage: 'assets/images/aiony-haust.jpg',
                            feedTime: '1 hr ago',
                            feedText:
                                'All the Lorem Ipsum generators on the Internet tend to repeat predefined.',
                            feedImage: 'assets/images/corn.png'),
                      ),
                    ));
              },
              scrollDirection: Axis.horizontal,
            ),

            /*ListView(
                  controller: controller,

                  scrollDirection: Axis.horizontal,


                  children: randomList.map<Widget>((data) {
                    return Padding(
                      padding: EdgeInsets.all(8),

                      child: _getRow(data[0], math.max(data[1].toDouble(), 50.0)),
                    );
                  }).toList(),

                ),*/
          ),
          Container(
            height: 3,
            color: Colors.grey[300],
          ),
          Padding(
            padding: EdgeInsets.all(2),
            child: Container(
              //color: Colors.red,
              height: 200,
              width: 390,
              //color: Colors.red,

              //  child: Expanded(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Plot',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            width: 300,
                            height: 20,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                value: 0.7,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.green),
                                backgroundColor: Color(0xffD6D6D6),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(left: 200, bottom: 22, child: Text('70/100')),
                    ],
                  ),
                  Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Uploaded',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 0,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            width: 300,
                            height: 20,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                value: 0.7,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.green),
                                backgroundColor: Color(0xffD6D6D6),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(left: 200, bottom: 22, child: Text('70/100')),
                    ],
                  ),
                  Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Approved',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 0,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            width: 300,
                            height: 20,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                value: 0.7,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.green),
                                backgroundColor: Color(0xffD6D6D6),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(left: 200, bottom: 22, child: Text('70/100')),
                    ],
                  ),
                ],
              ),

              //   ),
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
          TabItem(icon: Icons.art_track, title: 'Experiment'),
          TabItem(icon: Icons.bar_chart, title: 'Report'),
        ],
        initialActiveIndex: 0,
        onTap: (int i) => Navigator.of(context).pushNamed('$i'),
      ),
    );
  }

  int counter = -1;
  Future _scrollToIndex() async {
    setState(() {
      counter++;

      if (counter >= maxCount) counter = 0;
    });

    await controller.scrollToIndex(counter,
        preferPosition: AutoScrollPosition.begin);
    controller.highlight(counter);
  }
}

fetchHiveBox() async {
  _UserBox = Hive.box('Users');
}
