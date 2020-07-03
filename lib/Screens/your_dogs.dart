import 'package:flutter/material.dart';
import 'package:jabwemate/Screens/add_dog_screen.dart';
import 'package:jabwemate/Widgets/custom_drawer.dart';
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
      appBar: CustomAppBar(
        action: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => AddDogScreen()));
          },
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
          child: Container(
        child: Text('Your Dogs'),
      )),
    );
  }
}
