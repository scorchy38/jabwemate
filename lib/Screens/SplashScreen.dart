import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'FirstScreen.dart';
import 'package:jabwemate/ui/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth mAuth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    new Future.delayed(Duration(seconds: 5), () async {
      FirebaseUser user = await mAuth.currentUser();
      if (user != null) {
        print(user.uid);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FirstScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Color(0xFFFCFFF3),
            ),
          ),
          Image.asset(
            'images/splashpic.png',
            fit: BoxFit.cover,
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Color(0xFFE9F4F3),
            ),
          ),
        ],
      ),
    );
  }
}
