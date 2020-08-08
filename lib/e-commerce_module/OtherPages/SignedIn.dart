import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jabwemate/Screens/FirstScreen.dart';
import 'package:jabwemate/e-commerce_module/Classes/Constants.dart';
import 'package:jabwemate/e-commerce_module/LoginPages/addressFrame.dart';
import 'package:jabwemate/style/theme.dart' as Theme;

import '../NavBar.dart';

class SignedIn extends StatefulWidget {
  String phNo;

  SignedIn({this.phNo});

  @override
  _SignedInState createState() => _SignedInState();
}

class _SignedInState extends State<SignedIn> {
  getDatabaseRef() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DatabaseReference useraddressref = FirebaseDatabase
        .instance //Used the UID of the user to check if record exists in the database or not
        .reference()
        .child('Users')
        .child(user.uid);
    useraddressref.once().then((DataSnapshot snap) {
      // ignore: non_constant_identifier_names
      var DATA = snap.value;
      if (DATA == null) {
        setState(() {
          isStored = false;
          print('DATA STORED NAHI HAI');
        });
      } else {
        setState(() {
          isStored = true;
          print('DATA STORED HAI');
        });
      }
    });
  }

  navigation() async {
    await getDatabaseRef();

    new Future.delayed(Duration(seconds: 3), () {
      if (isStored) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FirstScreen(),
          ),
        );
      } else {
        print(widget.phNo);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AddressFrame(
              phno: widget.phNo,
            ),
          ),
        );
      }
    });
  }

  bool isStored = false;

  @override
  void initState() {
    navigation();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                Theme.MyColors.loginGradientStart,
                Theme.MyColors.loginGradientEnd
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/signed in.png',
                  height: 150,
                  width: 150,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Signed In',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: 'Cabin'),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Redirecting...',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: 'Cabin'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
