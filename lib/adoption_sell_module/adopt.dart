import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jabwemate/Classes/dog_profile.dart';
import 'package:jabwemate/Screens/home_screen.dart';
import 'package:jabwemate/Widgets/appbar.dart';
import 'package:jabwemate/Widgets/custom_drawer.dart';
import 'package:jabwemate/Widgets/my_dog_card.dart';
import 'package:jabwemate/adoption_sell_module/add_adoption.dart';

class Adoption extends StatefulWidget {
  @override
  _AdoptionState createState() => _AdoptionState();
}

class _AdoptionState extends State<Adoption> {
  void getUser() async {
    final FirebaseUser user = await auth.currentUser();
    uid = user.uid;
    print(uid);
    // here you write the codes to input the data into firestore
  }

  final databaseReference = Firestore.instance;
  double width, height;
  List<Widget> dogCardsList = [];

  void getData() async {
    dogList.clear();
    await databaseReference
        .collection("AdoptionDogs")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        dogList.add(DogProfile(f['profileImage'], f['name'], f['city'],
            f['age'], f['breed'], f['gender'], f['owner']));
        dogCardsList.add(MyDogCard(
            DogProfile(f['profileImage'], f['name'], f['city'], f['age'],
                f['breed'], f['gender'], f['owner'],
                otherImages: f['imageLinks']),
            Scaffold.of(context),
            width,
            height));
        print('Dog added');
        print(f['imageLinks'].toString());
        print('Dog added');
        print(f['profileImage'].toString());
      });
    });
    setState(() {
      print(dogList.length.toString());
    });
  }

  @override
  void initState() {
    getUser();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BuildContext cxt = context;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: dogCardsList.length != 0
              ? ListView(
                  children: dogCardsList,
                )
              : CircularProgressIndicator()),
    );
  }
}
