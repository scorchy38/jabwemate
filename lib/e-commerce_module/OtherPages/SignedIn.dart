import 'package:flutter/material.dart';
import 'package:jabwemate/Screens/FirstScreen.dart';
import 'package:jabwemate/e-commerce_module/Classes/Constants.dart';
import 'package:jabwemate/style/theme.dart' as Theme;

class SignedIn extends StatefulWidget {
  String phNo;

  SignedIn({this.phNo});

  @override
  _SignedInState createState() => _SignedInState();
}

class _SignedInState extends State<SignedIn> {
  @override
  void initState() {
    new Future.delayed(Duration(seconds: 3), () async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FirstScreen(),
        ),
      );
    });
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
