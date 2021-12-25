import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:der/screens/plot/plot_screen.dart';
import 'package:der/utils/constants.dart';

class ExperimentScreen extends StatefulWidget {
  _ExperimentScreen createState() => _ExperimentScreen();
}

class _ExperimentScreen extends State<ExperimentScreen> {
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
                )
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
            Stack(
              children: [
                feedImage != ''
                    ? Container(
                        height: 200,
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
                makeDoughnutProgress(inProgress: 0.6, finished: 0.6),
              ],
            ),
            SizedBox(
              height: 20,
            ),
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
            SizedBox(
              height: 20,
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

  @override
  Widget build(context) {
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
                      color: Colors.grey[200]),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "Search Experiment",
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
                  children: [
                    makeExperiment(
                        experimentID: '54155',
                        //userImage: 'assets/images/aiony-haust.jpg',
                        feedTime: '1 hr ago',
                        feedText:
                            'All the Lorem Ipsum generators on the Internet tend to repeat predefined.',
                        feedImage: 'assets/images/corn.png'),

                    // makeExperiment(
                    //     experimentID: '54156',
                    //     //userImage: 'assets/images/aiony-haust.jpg',
                    //     feedTime: '1 hr ago',
                    //     feedText: 'All the Lorem Ipsum generators on the Internet tend to repeat predefined.',
                    //     feedImage: 'assets/images/corn.png'
                    // ),

                    // makeExperiment(
                    //     experimentID: '54159',
                    //     //userImage: 'assets/images/aiony-haust.jpg',
                    //     feedTime: '1 hr ago',
                    //     feedText: 'All the Lorem Ipsum generators on the Internet tend to repeat predefined.',
                    //     feedImage: 'assets/images/corn.png'
                    // ),
                  ],
                ),
              ),
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
          TabItem(icon: Icons.art_track, title: 'Experiment'),
          TabItem(icon: Icons.bar_chart, title: 'Report'),
        ],
        initialActiveIndex: 3,
        onTap: (int i) => Navigator.of(context).pushNamed('$i'),
      ),
    );
  }
}
