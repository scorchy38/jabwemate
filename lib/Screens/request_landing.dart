import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Screens/reqs2.dart';
import 'package:jabwemate/Screens/reqs3.dart';
import 'package:jabwemate/Screens/requests_screen.dart';
import 'package:jabwemate/Widgets/appbar.dart';
import 'package:jabwemate/style/theme.dart' as Theme;

class Reqs extends StatefulWidget {
  @override
  _ReqsState createState() => _ReqsState();
}

class _ReqsState extends State<Reqs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Jab We Mate',
          style: GoogleFonts.k2d(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                Theme.MyColors.loginGradientStart,
                Theme.MyColors.loginGradientEnd
              ])),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        height: double.infinity,
        child: GFTabs(
          tabBarColor: Theme.MyColors.loginGradientEnd,
          tabBarHeight: 70,
          indicatorColor: Colors.white,

          initialIndex: 0,
          length: 3,
//      shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.only(
//              bottomRight: Radius.circular(10),
//              bottomLeft: Radius.circular(10))),
          tabs: <Widget>[
            Tab(
              child: Text(
                "Incoming",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "nunito",
                ),
              ),
            ),
            Tab(
              child: Text(
                "Recent",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "nunito",
                ),
              ),
            ),
            Tab(
              child: Text(
                "Sent",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "nunito",
                ),
              ),
            ),
          ],
          tabBarView: GFTabBarView(
            children: <Widget>[Requests(), Recents(), Sent()],
          ),
        ),
      )),
    );
  }
}
