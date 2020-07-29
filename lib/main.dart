import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jabwemate/Screens/FirstScreen.dart';
import 'package:jabwemate/Screens/SplashScreen.dart';
import 'package:jabwemate/Screens/home_screen.dart';
import 'package:jabwemate/style/theme.dart' as Theme;
import 'package:jabwemate/ui/login_page.dart';
import 'delayed_animation.dart';
import 'e-commerce_module/Classes/Constants.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyHome());
}

//TODO:Use Cached network image
class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jab we mate',
      theme: ThemeData(
        fontFamily: 'Cabin',
        scaffoldBackgroundColor: kWhiteColor,
        primaryColor: kPrimaryColor,
        // ignore: deprecated_member_use
        textTheme: TextTheme(
          // ignore: deprecated_member_use
          headline: TextStyle(fontWeight: FontWeight.bold),
          button: TextStyle(fontWeight: FontWeight.bold),
          // ignore: deprecated_member_use
          title: TextStyle(fontWeight: FontWeight.bold),
          // ignore: deprecated_member_use
          body1: TextStyle(color: kTextColor),
        ),
      ),
      home: SplashScreen(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  FirebaseAuth mAuth = FirebaseAuth.instance;

  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
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
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              AvatarGlow(
                endRadius: 90,
                duration: Duration(seconds: 2),
                glowColor: Colors.white24,
                repeat: true,
                repeatPauseDuration: Duration(seconds: 2),
                startDelay: Duration(seconds: 1),
                child: Material(
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Theme.MyColors.loginGradientStart,
                      child: Image.asset('assets/img/dog-2.png'),
                      radius: 70.0,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              DelayedAnimation(
                child: Text(
                  "Hi There",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      color: color),
                ),
                delay: delayedAmount + 1000,
              ),
              DelayedAnimation(
                child: Text(
                  "Jab We Mate",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      color: color),
                ),
                delay: delayedAmount + 2000,
              ),
              SizedBox(
                height: 30.0,
              ),
              DelayedAnimation(
                child: Text(
                  "Find Dogs,",
                  style: TextStyle(fontSize: 20.0, color: color),
                ),
                delay: delayedAmount + 3000,
              ),
              DelayedAnimation(
                child: Text(
                  "Fix Meets",
                  style: TextStyle(fontSize: 20.0, color: color),
                ),
                delay: delayedAmount + 3000,
              ),
              SizedBox(
                height: 100.0,
              ),
              DelayedAnimation(
                child: GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  child: Transform.scale(
                    scale: _scale,
                    child: _animatedButtonUI,
                  ),
                ),
                delay: delayedAmount + 4000,
              ),
              SizedBox(
                height: 50.0,
              ),
              DelayedAnimation(
                child: Text(
                  "Made with love<3".toUpperCase(),
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: color),
                ),
                delay: delayedAmount + 5000,
              ),
            ],
          ),
        ),
      )
          //  Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Text('Tap on the Below Button',style: TextStyle(color: Colors.grey[400],fontSize: 20.0),),
          //     SizedBox(
          //       height: 20.0,
          //     ),
          //      Center(

          //   ),
          //   ],

          // ),
          ),
    );
  }

  Widget get _animatedButtonUI => InkWell(
        onTap: () async {
          FirebaseUser user = await mAuth.currentUser();
          if (user == null) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        },
        child: Container(
          height: 60,
          width: 270,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              'Enter JWM',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
