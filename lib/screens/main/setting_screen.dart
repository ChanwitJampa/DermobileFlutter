import 'package:der/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreen createState() => _SettingScreen();
}

class _SettingScreen extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Body(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: Colors.blueAccent,
            title: Text("Setting Profile", style: TextStyle(fontSize: 32)),
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(HOME_ROUTE);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 30,
              ),
            ),
          ),
        ));
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 160,
              width: 160,
              margin: EdgeInsets.only(top: 25),
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 80.0,
                    backgroundImage: AssetImage('assets/images/user1.png'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Text(
              'Thanapat Wongtungjaroensuk',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'dream_007@gmail.com',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 20),
          ],
        ),
      ],
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfileScreen(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Edit Profile",
            icon: FontAwesomeIcons.userEdit,
            press: () {},
          ),
          ProfileMenu(
            text: "Change Pincode",
            icon: FontAwesomeIcons.lock,
            press: () => {},
          ),
          ProfileMenu(
            text: "Language",
            icon: FontAwesomeIcons.language,
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: FontAwesomeIcons.user,
            press: () {},
          ),
          ProfileMenu(
            text: "About System",
            icon: FontAwesomeIcons.infoCircle,
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: FontAwesomeIcons.signOutAlt,
            press: () {},
          ),
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          //primary: Color(0xFFFF7643),
          primary: Colors.blueAccent,
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              this.icon,
              size: 30,
            ),
            SizedBox(width: 20),
            Expanded(child: Text(text, style: TextStyle(fontSize: 25))),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
