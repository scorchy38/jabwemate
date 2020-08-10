import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Screens/docMainScreen.dart';
import 'package:jabwemate/Screens/home_screen.dart';
import 'package:jabwemate/Widgets/appbar.dart';
import 'package:jabwemate/adoption_sell_module/adopt.dart';
import 'package:jabwemate/adoption_sell_module/sell.dart';
import 'package:jabwemate/e-commerce_module/NavBar.dart';
import 'package:jabwemate/style/theme.dart';

class AdoptFirstScreen extends StatefulWidget {
  @override
  _AdoptFirstScreenState createState() => _AdoptFirstScreenState();
}

class _AdoptFirstScreenState extends State<AdoptFirstScreen> {
  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    final pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.white,
      body: Container(
        width: pWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: pHeight * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(pHeight * 0.15),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/img/mating.png',
                            height: pHeight * 0.04,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => NavBar(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(pHeight * 0.15),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/img/essentials.png',
                            height: pHeight * 0.04,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => DocMainScreen(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(pHeight * 0.15),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/img/health.png',
                            height: pHeight * 0.04,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: pWidth * 0.95,
                  child: Divider(
                    color: MyColors.loginGradientEnd,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Adoption(),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: pHeight * 0.35,
                  width: pWidth * 0.95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: new LinearGradient(
                      colors: [
                        MyColors.loginGradientStart,
                        MyColors.loginGradientEnd
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        height: pHeight * 0.01,
                      ),
                      Image.asset(
                        'assets/img/puppy-2.png',
                        height: pHeight * 0.2,
                      ),
                      Text(
                        'Adopt a Dog',
                        style: GoogleFonts.k2d(
                          textStyle: TextStyle(
                              color: Colors.white, fontSize: pHeight * 0.035),
                        ),
                      ),
                      SizedBox(
                        height: pHeight * 0.01,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Sell(),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: pHeight * 0.35,
                  width: pWidth * 0.95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: new LinearGradient(
                      colors: [
                        MyColors.loginGradientStart,
                        MyColors.loginGradientEnd
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        height: pHeight * 0.01,
                      ),
                      Image.asset(
                        'assets/img/resetdog.png',
                        height: pHeight * 0.2,
                      ),
                      Text(
                        'Buy or sell a Dog',
                        style: GoogleFonts.k2d(
                          textStyle: TextStyle(
                              color: Colors.white, fontSize: pHeight * 0.035),
                        ),
                      ),
                      SizedBox(
                        height: pHeight * 0.01,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
