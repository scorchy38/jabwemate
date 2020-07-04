import 'package:flutter/material.dart';
import 'package:jabwemate/style/theme.dart' as Theme;
import 'package:jabwemate/ui/login_page.dart';

class ResetLinkSent extends StatefulWidget {
  @override
  _ResetLinkSentState createState() => _ResetLinkSentState();
}

class _ResetLinkSentState extends State<ResetLinkSent> {
  @override
  void initState() {
    // TODO: implement initState
    new Future.delayed(Duration(seconds: 2), () async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      super.initState();
    });
  }

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
                padding: EdgeInsets.only(top: 300.0, left: 0),
                child: new Image(
                    width: 191.0,
                    height: 191.0,
                    fit: BoxFit.fill,
                    image: new AssetImage('assets/img/resetdog.png')),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  'Password reset link sent!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: "WorkSansBold"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
