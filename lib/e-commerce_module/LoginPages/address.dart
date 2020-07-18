import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jabwemate/e-commerce_module/Classes/Constants.dart';

import '../NavBar.dart';

class Address extends StatefulWidget {
  final String phno;

  const Address({Key key, this.phno}) : super(key: key);
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  FirebaseAuth mAuth = FirebaseAuth.instance;

  final myController = TextEditingController();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    myController.dispose();

    super.dispose();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseUser user;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    FirebaseUser _user = await _firebaseAuth.currentUser();
    setState(() {
      user = _user;
    });
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: myController,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
                ),
                hintText: 'Full Name',
                hintStyle: TextStyle(
                  color: kTextColor.withOpacity(0.65),
                ),
              ),
              validator: (name) {
                if (name.isEmpty) {
                  return 'This field cannot be blank';
                } else
                  return null;
              },
              style: TextStyle(
                  color: kTextColor.withOpacity(0.85),
                  fontSize: 24.0,
                  fontFamily: 'Cabin'),
            ),
            Spacer(),
            TextFormField(
              controller: myController1,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
                ),
                hintText: 'Address Line 1',
                hintStyle: TextStyle(
                  color: kTextColor.withOpacity(0.65),
                ),
              ),
              validator: (line1) {
                if (line1.isEmpty) {
                  return 'This field cannot be blank';
                } else
                  return null;
              },
              style: TextStyle(
                  color: kTextColor.withOpacity(0.85),
                  fontSize: 24.0,
                  fontFamily: 'Cabin'),
            ),
            Spacer(),
            TextFormField(
              controller: myController2,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
                ),
                hintText: 'Address Line 2',
                hintStyle: TextStyle(
                  color: kTextColor.withOpacity(0.65),
                ),
              ),
              validator: (line2) {
                if (line2.isEmpty) {
                  return 'This field cannot be blank';
                } else
                  return null;
              },
              style: TextStyle(
                  color: kTextColor.withOpacity(0.85),
                  fontSize: 24.0,
                  fontFamily: 'Cabin'),
            ),
            Spacer(),
            TextFormField(
              controller: myController3,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
                ),
                hintText: 'Pincode',
                hintStyle: TextStyle(
                  color: kTextColor.withOpacity(0.65),
                ),
              ),
              validator: (pincode) {
                if (pincode.isEmpty) {
                  return 'This field cannot be blank';
                } else
                  return null;
              },
              style: TextStyle(
                  color: kTextColor.withOpacity(0.85),
                  fontSize: 24.0,
                  fontFamily: 'Cabin'),
            ),
            Spacer(),
            InkWell(
              onTap: () async {
                FirebaseUser user = await mAuth.currentUser();

                if (formKey.currentState.validate()) {
                  print(widget.phno);
                  DatabaseReference dbRef =
                      FirebaseDatabase.instance.reference();
                  dbRef.child('Users').child(user.uid).set({
                    "Name": myController.text,
                    "Add1": myController1.text,
                    'Add2': myController2.text,
                    'Zip': myController3.text,
                    'phNo': widget.phno
                  });
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => NavBar()),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 34.0),
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(15.0)),
                child: Text(
                  'SAVE',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(fontSize: 20.0, color: kWhiteColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
