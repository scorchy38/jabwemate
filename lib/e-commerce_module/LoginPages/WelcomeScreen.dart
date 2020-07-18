import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jabwemate/e-commerce_module/Classes/Constants.dart';

import '../NavBar.dart';
import 'PhoneLogin.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  FirebaseAuth mAuth = FirebaseAuth.instance;
  double pHeight;

  @override
  Widget build(BuildContext context) {
    pHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: pHeight / 20,
              ),
              Text(
                'Pet Shop',
                textAlign: TextAlign.start,
                // ignore: deprecated_member_use
                style:
                    Theme.of(context).textTheme.headline.copyWith(fontSize: 40),
              ),
              SizedBox(
                height: pHeight / 70,
              ),
              Text(
                'Everything your pet needs at one place',
                textAlign: TextAlign.start,
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.title.copyWith(
                      color: kTextColor.withOpacity(0.5),
                    ),
              ),
              Spacer(),
              SvgPicture.asset(
                'images/petshop.svg',
                height: 250,
              ),
              Spacer(),
              Text(
                'Lets get started',
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.headline.copyWith(
                      color: kTextColor.withOpacity(0.5),
                    ),
              ),
              SizedBox(
                height: pHeight / 80,
              ),
              InkWell(
                onTap: () async {
                  FirebaseUser user = await mAuth.currentUser();
                  //Added the condition to check if the user is already logged in
                  user == null ? goToLogin() : goToHomePage1();
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Container(
                      width: 330,
                      decoration: BoxDecoration(
                        color: kSecondaryColor.withOpacity(0.2),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      child: Container(
                        width: 330,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          shape: BoxShape.rectangle,
                          border: Border.all(color: kBorderColor, width: 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "CONTINUE",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(fontSize: 25, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goToLogin() {
    Navigator.pushReplacement(context, SlideUpRoute(nextPage: PhoneLogin()));
  }

  void goToHomePage1() {
    Navigator.pushReplacement(context, SlideUpRoute(nextPage: NavBar()));
  }
}

class SlideUpRoute extends PageRouteBuilder {
  final Widget nextPage;
  SlideUpRoute({this.nextPage})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              nextPage,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
