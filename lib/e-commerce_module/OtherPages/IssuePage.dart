import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jabwemate/e-commerce_module/Classes/Constants.dart';
import 'package:jabwemate/e-commerce_module/Classes/Orders.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:intl/intl.dart';

import '../NavBar.dart';

class IssuePage extends StatefulWidget {
  Orders issueOrder;

  IssuePage({this.issueOrder});

  @override
  _IssuePageState createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  TextEditingController issueController = TextEditingController(text: "");
  final formKey = GlobalKey<FormState>();
  String request = "";

  FirebaseAuth mAuth = FirebaseAuth.instance;
  final dbRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    final pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Raise an issue',
          style:
              Theme.of(context).textTheme.headline.copyWith(color: kWhiteColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: pHeight * 0.35,
                    decoration: BoxDecoration(
                      gradient: new LinearGradient(
                        colors: [kPrimaryColor, kSecondaryColor],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Order Details',
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(color: kWhiteColor, fontSize: 24),
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Item name',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontFamily: 'Cabin'),
                                  ),
                                  Text(
                                    'Item Quantity',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontFamily: 'Cabin'),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 100,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        widget.issueOrder.itemsName.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            widget.issueOrder.itemsName[index],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                fontFamily: 'Cabin'),
                                          ),
                                          Text(
                                            widget.issueOrder.itemsQty[index]
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                fontFamily: 'Cabin'),
                                          )
                                        ],
                                      );
                                    }),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: Divider(
                                  color: Colors.white,
                                  thickness: 0.8,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Order placed at',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontFamily: 'Cabin'),
                                  ),
                                  Text(
                                    widget.issueOrder.dateTime,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontFamily: 'Cabin'),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Order completed at',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontFamily: 'Cabin'),
                                  ),
                                  Text(
                                    widget.issueOrder.completedTime,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontFamily: 'Cabin'),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Order amount',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontFamily: 'Cabin'),
                                  ),
                                  Text(
                                    widget.issueOrder.orderAmount
                                        .toStringAsFixed(2),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontFamily: 'Cabin'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: pHeight * 0.05,
                  ),
                  Form(
                    key: formKey,
                    child: Container(
                      height: pHeight * 0.45,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Raise an issue',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(color: kWhiteColor),
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'Describe the issue',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                          color: kWhiteColor, fontSize: 18.0),
                                ),
                                SizedBox(
                                  height: pHeight * 0.01,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 6,
                                  controller: issueController,
                                  decoration: InputDecoration(
                                      fillColor: kWhiteColor,
                                      filled: true,
                                      hintMaxLines: 4,
                                      hintText:
                                          'Please describe the issue you have faced with this order'),
                                  validator: (value) {
                                    if (value.length == 0) {
                                      return 'This field can\'t be left empty';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'Choose one of the following options',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                          color: kWhiteColor, fontSize: 18.0),
                                ),
                                SizedBox(
                                  height: pHeight * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          request = 'Refund';
                                        });
                                        onIssueRaised();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: kWhiteColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: kPrimaryColor, width: 1.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Refund',
                                            style: Theme.of(context)
                                                .textTheme
                                                .title
                                                .copyWith(color: kPrimaryColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          request = 'Replacement';
                                        });
                                        onIssueRaised();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: kWhiteColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: kPrimaryColor, width: 1.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Replacement',
                                            style: Theme.of(context)
                                                .textTheme
                                                .title
                                                .copyWith(color: kPrimaryColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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

  Future<void> onIssueRaised() async {
    FirebaseUser user = await mAuth.currentUser();

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy  kk:mm').format(now);

    dbRef
        .child('Issues')
        .child(user.uid)
        .child(TimeOfDay.now().toString())
        .set({
      "itemsName": widget.issueOrder.itemsName,
      "itemsQty": widget.issueOrder.itemsQty,
      'orderAmount': widget.issueOrder.orderAmount.toStringAsFixed(2),
      'isCompleted': false,
      'DateTime': formattedDate,
      'CompletedTime': widget.issueOrder.completedTime,
      'IssueDescription': issueController.text,
      'Request': request,
      'Status': 'Issue raised'
    });

    print('Issue raised');

    Alert(
      context: context,
      type: AlertType.success,
      title: "Complaint registered",
      desc: "Your complaint has been registered successfully.",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NavBar(),
            ),
          ),
          width: 120,
        )
      ],
    ).show();
  }
}
