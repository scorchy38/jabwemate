//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jabwemate/Classes/Doc_data.dart';
import 'package:jabwemate/Widgets/docCustomDrawer.dart';
import 'package:jabwemate/Widgets/appbar.dart';
import 'package:jabwemate/Screens/BookingScreen.dart';

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

        Docpro newdp = Docpro(
          address: doc['address'],
          imageUrl: 'images/Doc2.png',
          name: doc['name'],
          specs: doc['specs'],
          degree: doc['degree'],
          cost: doc['cost'],
          slots: timeArr,
        );

        await docpros.add(newdp);
        print("doc added");
      });
    });
    setState(() {
      //print(docpros.length.toString());
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
                    height: 150.0,
                    width: 150.0,
                    image: AssetImage(docpro.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            docpro.name,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            docpro.specs,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            docpro.degree,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            docpro.address,
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.0),
                        ],
                      )),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Nearby Doctors',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
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
