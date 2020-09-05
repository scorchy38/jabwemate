import 'package:diagonal/diagonal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jabwemate/FeedbackOrQuery.dart';
import 'package:jabwemate/Screens/FirstScreen.dart';
import 'package:jabwemate/e-commerce_module/Classes/Constants.dart';
import 'package:jabwemate/e-commerce_module/Classes/User.dart';
import 'package:jabwemate/e-commerce_module/Drawer/support_page_main.dart';
import 'package:jabwemate/ui/login_page.dart';
import 'package:jabwemate/Abuse.dart';
import '../NavBar.dart';
import 'ProfilePage.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  User userData = User();
  DatabaseReference dbRef = FirebaseDatabase.instance.reference();
  FirebaseAuth mAuth = FirebaseAuth.instance;
  FirebaseUser user;

  getUser() async {
    user = await mAuth.currentUser();
  }

  getUserData() async {
    FirebaseUser user = await mAuth.currentUser();
    String uid = user.uid;

    DatabaseReference userRef = dbRef.child('Users').child(uid);
    userRef.once().then((DataSnapshot snapshot) async {
      userData.name = await snapshot.value['Name'];
      print(userData.name);
      userData.phNo = await snapshot.value['phNo'];
      print(userData.phNo);
      userData.add1 = await snapshot.value['Add1'];
      print(userData.add1);
      userData.add2 = await snapshot.value['Add2'];
      print(userData.add2);
      userData.pin = await snapshot.value['Zip'];
      print(userData.pin);
      setState(() {
        print('Done');
      });
    });
  }

  @override
  void initState() {
    getUserData();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Diagonal(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.225,
                decoration: BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [kPrimaryColor, kSecondaryColor],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hi,',
                        style: Theme.of(context).textTheme.headline.copyWith(
                            color: kWhiteColor, fontSize: size.height * 0.06),
                      ),
                      user == null
                          ? Text(
                              'Anonymous',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(
                                      color: kWhiteColor,
                                      fontSize: size.height * 0.04),
                            )
                          : Text(
                              '${userData.name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(
                                      color: kWhiteColor,
                                      fontSize: size.height * 0.04),
                            ),
                    ],
                  ),
                ),
              ),
              position: Position.BOTTOM_LEFT,
              clipHeight: size.height * 0.1,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                      colors: [kPrimaryColor, kSecondaryColor],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kPrimaryColor, width: 1.0),
                    boxShadow: [
                      BoxShadow(
                          color: kPrimaryColor,
                          blurRadius: 2.0,
                          spreadRadius: 0.1),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.account_circle,
                          size: size.height * 0.036,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: size.width * 0.1,
                        ),
                        Text(
                          'Profile',
                          style: Theme.of(context).textTheme.title.copyWith(
                              color: Colors.white,
                              fontSize: size.height * 0.036),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactUsPage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                      colors: [kPrimaryColor, kSecondaryColor],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kPrimaryColor, width: 1.0),
                    boxShadow: [
                      BoxShadow(
                          color: kPrimaryColor,
                          blurRadius: 2.0,
                          spreadRadius: 0.1),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.supervisor_account,
                          size: size.height * 0.036,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: size.width * 0.1,
                        ),
                        Text(
                          'Support',
                          style: Theme.of(context).textTheme.title.copyWith(
                              color: Colors.white,
                              fontSize: size.height * 0.036),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FirstScreen(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                      colors: [kPrimaryColor, kSecondaryColor],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kPrimaryColor, width: 1.0),
                    boxShadow: [
                      BoxShadow(
                          color: kPrimaryColor,
                          blurRadius: 2.0,
                          spreadRadius: 0.1),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          size: size.height * 0.036,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: size.width * 0.1,
                        ),
                        Text(
                          'Main Home',
                          style: Theme.of(context).textTheme.title.copyWith(
                              color: Colors.white,
                              fontSize: size.height * 0.036),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeedbackQuery(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                      colors: [kPrimaryColor, kSecondaryColor],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kPrimaryColor, width: 1.0),
                    boxShadow: [
                      BoxShadow(
                          color: kPrimaryColor,
                          blurRadius: 2.0,
                          spreadRadius: 0.1),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.feedback,
                          size: size.height * 0.036,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: size.width * 0.1,
                        ),
                        Text(
                          'Feedback',
                          style: Theme.of(context).textTheme.title.copyWith(
                              color: Colors.white,
                              fontSize: size.height * 0.036),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Abuse(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                      colors: [kPrimaryColor, kSecondaryColor],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kPrimaryColor, width: 1.0),
                    boxShadow: [
                      BoxShadow(
                          color: kPrimaryColor,
                          blurRadius: 2.0,
                          spreadRadius: 0.1),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.error,
                          size: size.height * 0.036,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: size.width * 0.1,
                        ),
                        Text(
                          'Report Abuse',
                          style: Theme.of(context).textTheme.title.copyWith(
                              color: Colors.white,
                              fontSize: size.height * 0.036),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            user == null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: new LinearGradient(
                            colors: [kPrimaryColor, kSecondaryColor],
                          ),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kPrimaryColor, width: 1.0),
                          boxShadow: [
                            BoxShadow(
                                color: kPrimaryColor,
                                blurRadius: 2.0,
                                spreadRadius: 0.1),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.signInAlt,
                                size: size.height * 0.036,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: size.width * 0.1,
                              ),
                              Text(
                                'Sign In',
                                style: Theme.of(context)
                                    .textTheme
                                    .title
                                    .copyWith(
                                        color: Colors.white,
                                        fontSize: size.height * 0.036),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () {
                        signOut();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: new LinearGradient(
                            colors: [kPrimaryColor, kSecondaryColor],
                          ),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kPrimaryColor, width: 1.0),
                          boxShadow: [
                            BoxShadow(
                                color: kPrimaryColor,
                                blurRadius: 2.0,
                                spreadRadius: 0.1),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.signOutAlt,
                                size: size.height * 0.036,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: size.width * 0.1,
                              ),
                              Text(
                                'Sign Out',
                                style: Theme.of(context)
                                    .textTheme
                                    .title
                                    .copyWith(
                                        color: Colors.white,
                                        fontSize: size.height * 0.036),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  void signOut() async {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => NavBar(),
      ),
    );
  }
}
