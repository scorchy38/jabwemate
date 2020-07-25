import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jabwemate/Classes/appointment_data.dart';
import 'package:jabwemate/Screens/home_screen.dart';
import 'package:jabwemate/Widgets/my_appointment_card.dart';

class FutureAppointment extends StatefulWidget {
  @override
  _FutureAppointmentState createState() => _FutureAppointmentState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();

class _FutureAppointmentState extends State<FutureAppointment> {
  void getUser() async {
    final FirebaseUser user = await auth.currentUser();
    uid = user.uid;
    print(uid);
    // here you write the codes to input the data into firestore
  }

  final databaseReference = Firestore.instance;
  double width, height;
  List<Widget> futAppointsList = [];
  List fuAppList = [];
  void getData() async {
    fuAppList.clear();
    await databaseReference
        .collection("DoctorAppointment")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        fuAppList.add(AppointmentData(
          f['bookingTime'],
          f['doctorUID'],
          f['docName'],
          f['docDegree'],
          f['status'],
          f['dogAge'],
          f['dogBreed'],
          f['dogName'],
          f['ownerEmail'],
          f['ownerName'],
          f['ownerPhone'],
          f['patientUID'],
          f['timeSlot'],
        ));
        futAppointsList.add(MyAppointmentCard(
            AppointmentData(
              f['bookingTime'],
              f['doctorUID'],
              f['docName'],
              f['docDegree'],
              f['status'],
              f['dogAge'],
              f['dogBreed'],
              f['dogName'],
              f['ownerEmail'],
              f['ownerName'],
              f['ownerPhone'],
              f['patientUID'],
              f['timeSlot'],
            ),
            width,
            height,
            context: context));
      });
    });
    setState(() {
      print(fuAppList.length.toString());
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
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: futAppointsList.length != 0
          ? ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: fuAppList.length,
              itemBuilder: (BuildContext, index) {
                var item = fuAppList[index];
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    height: 250,
                    width: double.maxFinite,
                    child: Card(
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 2.0, color: Colors.orange),
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(7),
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerRight,
                                child: Stack(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 5),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Icon(
                                                  Icons.people,
                                                  color: Colors.deepPurple,
                                                  size: 30,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: item.docName,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.deepPurple,
                                                        fontSize: 20),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: '\n' +
                                                              item.docDegree,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.purple,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: item.dogName,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue,
                                                        fontSize: 20),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: '\n' +
                                                              item.dogBreed,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .lightBlue,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Align(
                                                  alignment: Alignment.topRight,
                                                  child: Icon(
                                                    Icons.pets,
                                                    color: Colors.blue,
                                                    size: 30,
                                                  )),
                                              SizedBox(
                                                width: 20,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      RichText(
                                                        textAlign:
                                                            TextAlign.left,
                                                        text: TextSpan(
                                                          text: '\nSlot: ' +
                                                              item.timeSlot,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: '\nBooked at: ' +
                                                                  item.bookingTime,
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      RichText(
                                                        textAlign:
                                                            TextAlign.left,
                                                        text: TextSpan(
                                                          text: '\nStatus: ' +
                                                              item.status,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          // children: <TextSpan>[
                                                          //   TextSpan(
                                                          //     text: '\nBooked at: ' +
                                                          //         item.bookingTime,
                                                          //     style: TextStyle(
                                                          //       color:
                                                          //           Colors.grey,
                                                          //       fontStyle:
                                                          //           FontStyle
                                                          //               .italic,
                                                          //       fontSize: 14,
                                                          //     ),
                                                          //   ),
                                                          // ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                        width: 150,
                                                        child: RaisedButton(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 0, 0, 0),
                                                          textColor:
                                                              Colors.white,
                                                          color: Colors.red,
                                                          onPressed: () {
                                                            print("Hi");
                                                          },
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
