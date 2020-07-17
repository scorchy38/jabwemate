import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:jabwemate/Screens/reqs2.dart';
import 'package:jabwemate/Screens/reqs3.dart';
import 'package:jabwemate/Screens/requests_screen.dart';
import 'package:jabwemate/Widgets/appbar.dart';
import 'package:jabwemate/adoption_sell_module/add_adoption.dart';
import 'package:jabwemate/adoption_sell_module/add_sell.dart';
import 'package:jabwemate/adoption_sell_module/adopt.dart';
import 'package:jabwemate/adoption_sell_module/sell.dart';

class Reqs extends StatefulWidget {
  @override
  _ReqsState createState() => _ReqsState();
}

class _ReqsState extends State<Reqs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: GFTabs(
        tabBarColor: Color(0xFFf7418c),
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
      )),
    );
  }
}
