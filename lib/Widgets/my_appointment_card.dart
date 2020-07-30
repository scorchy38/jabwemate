import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Classes/appointment_data.dart';
import 'package:jabwemate/style/theme.dart';

class MyAppointmentCard extends StatefulWidget {
  AppointmentData dp;
  double width, height;
  ScaffoldState state;
  BuildContext context;
  MyAppointmentCard(this.dp, this.width, this.height, {this.context});
  @override
  _MyAppointmentCardState createState() => _MyAppointmentCardState();
}

class _MyAppointmentCardState extends State<MyAppointmentCard> {
  @override
  Widget build(BuildContext context) {
    print(widget.width);
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                          padding: const EdgeInsets.only(left: 10, top: 5),
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
                                        text: widget.dp.docName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepPurple,
                                            fontSize: 20),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '\n' + widget.dp.docDegree,
                                              style: TextStyle(
                                                  color: Colors.purple,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: RichText(
                                      text: TextSpan(
                                        text: widget.dp.dogName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                            fontSize: 20),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '\n' + widget.dp.dogBreed,
                                              style: TextStyle(
                                                  color: Colors.lightBlue,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
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
                                          const EdgeInsets.only(left: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          RichText(
                                            textAlign: TextAlign.left,
                                            text: TextSpan(
                                              text: '\nSlot: ' +
                                                  widget.dp.from +
                                                  ' - ' +
                                                  widget.dp.to,
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: '\nBooked at: ' +
                                                      widget.dp.bookingTime,
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontStyle: FontStyle.italic,
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
                                          const EdgeInsets.only(right: 10.0),
                                      child: Column(
                                        children: <Widget>[
                                          RichText(
                                            textAlign: TextAlign.left,
                                            text: TextSpan(
                                              text: '\nStatus: ' +
                                                  widget.dp.status,
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
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
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: 150,
                                            child: RaisedButton(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                              textColor: Colors.white,
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
  }
}
