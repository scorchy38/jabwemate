import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jabwemate/Classes/appointment_data.dart';
import 'package:jabwemate/Screens/home_screen.dart';
import 'package:jabwemate/Widgets/my_appointment_card.dart';

class PastAppointment extends StatefulWidget {
  @override
  _PastAppointmentState createState() => _PastAppointmentState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();

class _PastAppointmentState extends State<PastAppointment> {
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
        if (uid == f['patientUID'] && f['status'] != "Booked") {
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
              f['from'],
              f['to'],
              f.documentID,
              f['appointmentDate'],
              f['bookingDate'],
              f['isConfirmed'],
              f['isPaid']));
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
                  f['from'],
                  f['to'],
                  f.documentID,
                  f['appointmentDate'],
                  f['bookingDate'],
                  f['isConfirmed'],
                  f['isPaid']),
              width,
              height,
              context: context));
        }
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
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    height: height * 0.27,
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
                                                  size: height * 0.03,
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
                                                        fontSize:
                                                            height * 0.02),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: '\n' +
                                                              item.docDegree,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.purple,
                                                              fontSize: height *
                                                                  0.016,
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
                                                        fontSize:
                                                            height * 0.02),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: '\n' +
                                                              item.dogBreed,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .lightBlue,
                                                              fontSize: height *
                                                                  0.016,
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
                                                    size: height * 0.03,
                                                  )),
                                              SizedBox(
                                                width: width * 0.02,
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
                                                              item.from +
                                                              ' - ' +
                                                              item.to +
                                                              '\nAppointment Date: ' +
                                                              item.appDate,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontSize: height *
                                                                  0.018,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: '\n\nBooked at: ' +
                                                                  item.bookingTime +
                                                                  '\nBooking Date: ' +
                                                                  item.bookingDate,
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontSize:
                                                                    height *
                                                                        0.015,
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
                                                              fontSize: height *
                                                                  0.019,
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
          : Center(
              child: Text('No appointments to show.'),
            ),
    );
  }
}
