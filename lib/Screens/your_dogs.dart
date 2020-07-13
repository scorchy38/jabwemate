import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jabwemate/Classes/dog_profile.dart';
import 'package:jabwemate/Screens/add_dog_screen.dart';
import 'package:jabwemate/Screens/home_screen.dart';
import 'package:jabwemate/Widgets/custom_drawer.dart';
import 'package:jabwemate/Widgets/appbar.dart';
import 'package:jabwemate/Widgets/my_dog_card.dart';

class YourDogs extends StatefulWidget {
  @override
  _YourDogsState createState() => _YourDogsState();
}

final databaseReference = Firestore.instance;
List dogList = [];
FirebaseAuth mAuth;
bool loading = true;
Widget loader = CircularProgressIndicator();

class _YourDogsState extends State<YourDogs> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    dogList.clear();
    print('started loading');
    await databaseReference
        .collection("Dogs")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) async {
        if (f['ownerID'] == uid) {
          await dogList.add(DogProfile(f['profileImage'], f['name'], f['city'],
              f['age'], f['breed'], f['gender'], f['owner'],
              otherImages: f['imageLinks']));
          await dogCardsList.add(MyDogCard(
              DogProfile(f['profileImage'], f['name'], f['city'], f['age'],
                  f['breed'], f['gender'], f['owner'],
                  otherImages: f['imageLinks']),
              Scaffold.of(context),
              width,
              height));
          print('Dog added');
          print(f['imageLinks'].toString());
        }
      });
    });
    setState(() {
      print(dogList.length.toString());
      print(dogCardsList.length.toString());
    });
  }

  double width, height;
  List<Widget> dogCardsList = [];
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 10), () {
      setState(() {
        loader = Center(child: Text('No dogs'));
      });

      //pop dialog
    });
    BuildContext cxt = context;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
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
          child: dogCardsList.length != 0
              ? ListView(
                  children: dogCardsList,
                )
              : loader),
    );
  }
}
