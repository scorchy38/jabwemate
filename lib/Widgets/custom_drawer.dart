import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jabwemate/Screens/filtered_search_screen.dart';
import 'package:jabwemate/Screens/home_screen.dart';
import 'package:jabwemate/Screens/your_dogs.dart';
import 'package:jabwemate/ui/login_page.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  FirebaseAuth mAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Home"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen()));
            },
          ),
          ListTile(
            title: Text("Filtered Search"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => FilteredSearch()));
            },
          ),
          ListTile(
            title: Text("Your Dogs"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => YourDogs()));
            },
          ),
          ListTile(
            title: Text("Your Favourites"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => FilteredSearch()));
            },
          ),
          ListTile(
            title: Text("Requests"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => FilteredSearch()));
            },
          ),
          ListTile(
            title: Text("Sign Out"),
            onTap: () {
              Navigator.of(context).pop();
              mAuth.signOut();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
