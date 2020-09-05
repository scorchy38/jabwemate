import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/components/drawer/gf_drawer.dart';
import 'package:jabwemate/Screens/FirstScreen.dart';
import 'package:jabwemate/style/theme.dart' as Theme;
import 'package:jabwemate/ui/login_page.dart';
import 'package:jabwemate/Screens/allAppointmentsMain.dart';
import 'package:jabwemate/FeedbackOrQuery.dart';
import 'package:jabwemate/Abuse.dart';

class DocCustomDrawer extends StatefulWidget {
  @override
  _DocCustomDrawerState createState() => _DocCustomDrawerState();
}

class _DocCustomDrawerState extends State<DocCustomDrawer> {
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    print('out');
  }

  FirebaseAuth mAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GFDrawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Theme.MyColors.loginGradientStart,
                Theme.MyColors.loginGradientEnd
              ])),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.MyColors.loginGradientStart,
              Theme.MyColors.loginGradientEnd
            ])),
            height: 150,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GFAvatar(
                    size: 65,
                    backgroundColor: Theme.MyColors.loginGradientStart,
                    backgroundImage: AssetImage('assets/img/dog-2.png'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Appointments',
                      style: TextStyle(
                          fontFamily: 'nunito',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      'support@jwm.com',
                      style: TextStyle(
                          fontFamily: 'nunito',
                          fontSize: 12,
                          color: Color(0xFFFFE600)),
                    )
                  ],
                )
              ],
            ),
          ),
          ListTile(
            title: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Text(
                'Main Home',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'nunito',
                    fontWeight: FontWeight.w600),
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => FirstScreen()),
              );
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 0.5,
            color: Colors.black26,
          ),
          ListTile(
            title: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Text(
                'Home',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'nunito',
                    fontWeight: FontWeight.w600),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop(true);
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 0.5,
            color: Colors.black26,
          ),
          ListTile(
            title: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Text(
                'All Appointments',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'nunito',
                    fontWeight: FontWeight.w600),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentMainPage(),
                  ));
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 0.5,
            color: Colors.black26,
          ),
          ListTile(
            title: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Text(
                'Send Feedback Or Query',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'nunito',
                    fontWeight: FontWeight.w600),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedbackQuery(),
                ),
              );
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 0.5,
            color: Colors.black26,
          ),
          ListTile(
            title: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Text(
                'Report Abuse',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'nunito',
                    fontWeight: FontWeight.w600),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Abuse(),
                ),
              );
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 0.5,
            color: Colors.black26,
          ),
          ListTile(
            title: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Text(
                'Log Out',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'nunito',
                    fontWeight: FontWeight.w600),
              ),
            ),
            onTap: () async {
              await signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 0.5,
            color: Colors.black26,
          ),
        ],
      ),
    );
  }
}
