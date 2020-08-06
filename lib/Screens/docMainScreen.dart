//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jabwemate/Classes/Doc_data.dart';
import 'package:jabwemate/Widgets/docCustomDrawer.dart';
import 'package:jabwemate/Widgets/appbar.dart';
import 'package:jabwemate/Screens/BookingScreen.dart';
import 'package:jabwemate/adoption_sell_module/AdoptFirstScreen.dart';
import 'package:jabwemate/adoption_sell_module/landing.dart';
import 'package:jabwemate/e-commerce_module/NavBar.dart';
import 'package:jabwemate/style/theme.dart';

import 'home_screen.dart';

class DocMainScreen extends StatefulWidget {
  @override
  _DocMainScreenState createState() => _DocMainScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
String uid;
List<Docpro> docpros = new List<Docpro>();

class _DocMainScreenState extends State<DocMainScreen> {
  int number = 0;
  int max = 10;

  final docdatabaseReference = Firestore.instance;

  void getData() async {
    docpros.clear();
    await docdatabaseReference
        .collection("Doctors")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((doc) async {
        //Array of all TimeSlots
        List<TimeSlots> timeArr = new List<TimeSlots>();

        List.from(doc["TimeSlots"]).forEach((element) async {
          TimeSlots newTime = TimeSlots(
            from: element['From'],
            to: element['To'],
            available: element['Available'],
          );
          await timeArr.add(newTime);
        });

        Docpro newdp = Docpro();
        newdp.address = await doc['address'];
        newdp.imageUrl = 'images/Doc2.png';
        newdp.name = await doc['name'];
        newdp.specs = await doc['specs'];
        newdp.degree = await doc['degree'];
        newdp.cost = await doc['cost'];
        newdp.slots = timeArr;
        newdp.docId = await doc['ID'];
        print('---------DOC ID ${newdp.docId}------------');

        docpros.add(newdp);
        print("doc added");
      });
    });
    setState(() {
      print(docpros.length.toString());
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  //function to return list of column of doctors
  _builddocotor() {
    List<Widget> docList = [];

    //going through every element in the list (docpros present in Doc_data in classes)
    docpros.forEach((Docpro docpro) {
      docList.add(GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BookingScreen(
              docpro,
            ), //sending data to BookingScreen
          ),
        ),
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  width: 1.0,
                  color: Colors.grey[200],
                )),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image(
                    height: 100.0,
                    width: 100.0,
                    image: AssetImage(docpro.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                        //margin: EdgeInsets.all(12.0),
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 3.0),
                        Text(
                          docpro.name,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 9.0),
                        Text(
                          'Degree:  ' + docpro.degree,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          'Specialization: ' + docpro.specs,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Address: ' + docpro.address,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Cost: ₹' + '${docpro.cost}',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.0),
                      ],
                    )),
                  ),
                )
              ],
            )),
      ));
    });
    return (Column(children: docList));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return new Scaffold(
      drawer: DocCustomDrawer(),
      backgroundColor: Color(0xFFEFF7F6),
      appBar: CustomAppBar(),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(height * 0.15),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/img/mating.png',
                          height: height * 0.04,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => NavBar(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(height * 0.15),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/img/essentials.png',
                          height: height * 0.04,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => AdoptFirstScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(height * 0.15),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/img/adoption.png',
                          height: height * 0.04,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: width * 0.95,
                child: Divider(
                  color: MyColors.loginGradientEnd,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  'Nearby Doctors',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              _builddocotor(),
            ],
          ),
        ],
      ),
    );
  }
}
