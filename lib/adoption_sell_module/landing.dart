import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:jabwemate/Widgets/appbar.dart';
import 'package:jabwemate/adoption_sell_module/add_adoption.dart';
import 'package:jabwemate/adoption_sell_module/add_sell.dart';
import 'package:jabwemate/adoption_sell_module/adopt.dart';
import 'package:jabwemate/adoption_sell_module/sell.dart';

class IdeasPage extends StatefulWidget {
  @override
  _IdeasPageState createState() => _IdeasPageState();
}

class _IdeasPageState extends State<IdeasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        action: IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Add a dog"),
                    actions: [
                      FlatButton(
                        child: Text("For Adoption"),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AddDogAdopt()));
                        },
                      ),
                      FlatButton(
                        child: Text("For sale"),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => AddDogSell()));
                        },
                      )
                    ],
                  );
                });
          },
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: GFTabs(
        tabBarColor: Color(0xFFf7418c),
        tabBarHeight: 70,
        indicatorColor: Colors.white,

        initialIndex: 0,
        length: 2,
//      shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.only(
//              bottomRight: Radius.circular(10),
//              bottomLeft: Radius.circular(10))),
        tabs: <Widget>[
          Tab(
            child: Text(
              "Adoption",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: "nunito",
              ),
            ),
          ),
          Tab(
            child: Text(
              "Sell",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: "nunito",
              ),
            ),
          ),
        ],
        tabBarView: GFTabBarView(
          children: <Widget>[Adoption(), Sell()],
        ),
      )),
    );
  }
}
