import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Widgets/docCustomDrawer.dart';
import 'package:jabwemate/Widgets/appbar.dart';

class DocMainScreen extends StatefulWidget {
  @override
  _DocMainScreenState createState() => _DocMainScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
String uid;

class _DocMainScreenState extends State<DocMainScreen> {
  int number = 0;
  int max = 10;
  void getUser() async {
    final FirebaseUser user = await auth.currentUser();
    uid = user.uid;
    print(uid);
    // here you write the codes to input the data into firestore
  }

  final databaseReference = Firestore.instance;

  // void getData() async {
  //   dogList.clear();
  //   print('stsrted loading');
  //   await databaseReference
  //       .collection("Dogs")
  //       .getDocuments()
  //       .then((QuerySnapshot snapshot) {
  //     snapshot.documents.forEach((f) async {
  //       await dogList.add(DogProfile(
  //           f['profileImage'],
  //           f['name'],
  //           f['city'],
  //           f['age'],
  //           f['breed'],
  //           f['gender'],
  //           f['owner'],
  //           f['ownerID'],
  //           f['address'],
  //           f['phone'],
  //           otherImages: f['imageLinks']));
  //       print('Dog added');
  //       print(f['imageLinks'].toString());
  //     });
  //   });
  //   setState(() {
  //     print(dogList.length.toString());
  //   });
  // }

  @override
  void initState() {
    getUser();
    //getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return new Scaffold(
      drawer: DocCustomDrawer(),
      backgroundColor: Color(0xFFEFF7F6),
      appBar: CustomAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: height * 0.03,
          ),
          Text(
            'Latest Profiles',
            style: GoogleFonts.k2d(
                fontSize: height * 0.035,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.5)),
          ),
          Container(
            alignment: Alignment.topCenter,
            height: height * 0.15,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[],
            ),
          )
        ],
      ),
    );
  }
}
