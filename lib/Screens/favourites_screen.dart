import 'package:flutter/material.dart';
import 'package:jabwemate/Widgets/CustomDrawer.dart';
import 'package:jabwemate/Widgets/appbar.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: CustomAppBar(),
      body: Center(
          child: Container(
        child: Text('Favourites'),
      )),
    );
  }
}
