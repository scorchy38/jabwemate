import 'package:diagonal/diagonal.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/adoption_sell_module/landing.dart';
import 'package:jabwemate/delayed_animation.dart';
import 'package:jabwemate/e-commerce_module/LoginPages/WelcomeScreen.dart';
import 'package:jabwemate/main.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final int delayedAmount = 500;
  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    final pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Diagonal(
            child: Container(
              height: pHeight * 0.25,
              width: pWidth,
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                  colors: [Colors.deepOrange, Colors.orangeAccent],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  DelayedAnimation(
                    child: Text("Welcome to Jab We Mate.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.k2d(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                              color: Colors.white),
                        )),
                    delay: delayedAmount + 500,
                  ),
                  SizedBox(
                    height: pHeight * 0.04,
                  ),
                ],
              ),
            ),
            position: Position.BOTTOM_LEFT,
            clipHeight: pHeight * 0.075,
          ),
          Text(
            'What do you wish to do for your pet?',
            style: GoogleFonts.k2d(
                textStyle: TextStyle(
              fontSize: 24,
              color: Colors.black.withOpacity(0.7),
            )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ),
                  );
                },
                child: Card(
                  elevation: 6,
                  child: Container(
                    height: pHeight * 0.3,
                    width: pWidth * 0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/img/mating.png',
                          height: pHeight * 0.2,
                          width: pWidth * 0.4,
                        ),
                        Text(
                          'Find a mate',
                          style: GoogleFonts.k2d(
                              textStyle: TextStyle(
                            fontSize: pHeight * 0.025,
                            color: Colors.black.withOpacity(0.6),
                          )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WelcomeScreen(),
                    ),
                  );
                },
                child: Card(
                  elevation: 6,
                  child: Container(
                    height: pHeight * 0.3,
                    width: pWidth * 0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/img/essentials.png',
                          height: pHeight * 0.2,
                          width: pWidth * 0.4,
                        ),
                        Text(
                          'Buy essentials',
                          style: GoogleFonts.k2d(
                              textStyle: TextStyle(
                            fontSize: pHeight * 0.025,
                            color: Colors.black.withOpacity(0.6),
                          )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IdeasPage(),
                    ),
                  );
                },
                child: Card(
                  elevation: 6,
                  child: Container(
                    height: pHeight * 0.3,
                    width: pWidth * 0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/img/adoption.png',
                          height: pHeight * 0.2,
                          width: pWidth * 0.4,
                        ),
                        Text(
                          'Adopt a Dog',
                          style: GoogleFonts.k2d(
                              textStyle: TextStyle(
                            fontSize: pHeight * 0.025,
                            color: Colors.black.withOpacity(0.6),
                          )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Fluttertoast.showToast(
                      msg: 'Coming Soon!',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER);
                },
                child: Card(
                  elevation: 6,
                  child: Container(
                    height: pHeight * 0.3,
                    width: pWidth * 0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/img/health.png',
                          height: pHeight * 0.2,
                          width: pWidth * 0.4,
                        ),
                        Text(
                          'Doctor appointment',
                          style: GoogleFonts.k2d(
                              textStyle: TextStyle(
                            fontSize: pHeight * 0.025,
                            color: Colors.black.withOpacity(0.6),
                          )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: pHeight * 0.01,
          ),
        ],
      ),
    );
  }
}
