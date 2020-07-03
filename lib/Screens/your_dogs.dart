import 'package:flutter/material.dart';
import 'package:jabwemate/Widgets/CustomDrawer.dart';
import 'package:jabwemate/Widgets/appbar.dart';

class YourDogs extends StatefulWidget {
  @override
  _YourDogsState createState() => _YourDogsState();
}

class _YourDogsState extends State<YourDogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: CustomAppBar(),
      body: Center(
          child: Container(
        child: Text('Your Dogs'),
      )),
    );
  }
}
