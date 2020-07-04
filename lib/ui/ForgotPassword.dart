import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jabwemate/style/theme.dart' as Theme;
import 'package:jabwemate/ui/ResetLinkSent.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController loginEmailController = new TextEditingController();
  final FocusNode myFocusNodeEmailLogin = FocusNode();
  FirebaseAuth mAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height >= 775.0
              ? MediaQuery.of(context).size.height
              : 775.0,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  Theme.MyColors.loginGradientStart,
                  Theme.MyColors.loginGradientEnd
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 150.0, left: 0),
                child: new Image(
                    width: 191.0,
                    height: 191.0,
                    fit: BoxFit.fill,
                    image: new AssetImage('assets/img/animal.png')),
              ),
              Container(
                padding: EdgeInsets.only(top: 23.0),
                child: Column(
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.topCenter,
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Card(
                          margin: EdgeInsets.fromLTRB(0, 90, 0, 0),
                          elevation: 2.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Container(
                            width: 300.0,
                            height: 90.0,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 20.0,
                                      left: 25.0,
                                      right: 25.0),
                                  child: TextField(
                                    focusNode: myFocusNodeEmailLogin,
                                    controller: loginEmailController,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                        fontFamily: "WorkSansSemiBold",
                                        fontSize: 16.0,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(
                                        FontAwesomeIcons.envelope,
                                        color: Colors.black,
                                        size: 22.0,
                                      ),
                                      hintText: "Email Address",
                                      hintStyle: TextStyle(
                                          fontFamily: "WorkSansSemiBold",
                                          fontSize: 17.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 170.0),
                          decoration: new BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Theme.MyColors.loginGradientStart,
                                offset: Offset(1.0, 6.0),
                                blurRadius: 20.0,
                              ),
                              BoxShadow(
                                color: Theme.MyColors.loginGradientEnd,
                                offset: Offset(1.0, 6.0),
                                blurRadius: 20.0,
                              ),
                            ],
                            gradient: new LinearGradient(
                                colors: [
                                  Theme.MyColors.loginGradientEnd,
                                  Theme.MyColors.loginGradientStart
                                ],
                                begin: const FractionalOffset(0.2, 0.2),
                                end: const FractionalOffset(1.0, 1.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          child: MaterialButton(
                              highlightColor: Colors.transparent,
                              splashColor: Theme.MyColors.loginGradientEnd,
                              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                child: Text(
                                  "RESET PASSWORD",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      fontFamily: "WorkSansBold"),
                                ),
                              ),
                              onPressed: () async {
                                await mAuth
                                    .sendPasswordResetEmail(
                                        email: loginEmailController.text)
                                    .then((AuthResult) async {})
                                    .catchError((err) {
                                  if (err.code == "ERROR_USER_NOT_FOUND") {
                                    showCupertinoDialog(
                                        context: context,
                                        builder: (context) {
                                          return CupertinoAlertDialog(
                                            title: Text(
                                                'This email is not yet registered. Please sign up first.'),
                                            actions: <Widget>[
                                              CupertinoDialogAction(
                                                child: Text('OK'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  }
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResetLinkSent()),
                                );
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
