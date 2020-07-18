import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jabwemate/e-commerce_module/Classes/Constants.dart';
import 'package:jabwemate/e-commerce_module/Classes/User.dart';
import 'package:jabwemate/e-commerce_module/LoginPages/addressFrame2.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User userData = User();
  DatabaseReference dbRef = FirebaseDatabase.instance.reference();
  FirebaseAuth mAuth = FirebaseAuth.instance;

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
  // ignore: must_call_super
  void initState() {
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kPrimaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddressFrame2(
                      userData: userData,
                    ),
                  ),
                );
              },
              child: Icon(
                Icons.edit,
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2629,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(size.width * 0.5),
                        bottomRight: Radius.circular(size.width * 0.5),
                      ),
                      border: Border.all(color: kPrimaryColor, width: 2.0),
                      boxShadow: [
                        BoxShadow(
                            color: kPrimaryColor,
                            blurRadius: 2.0,
                            spreadRadius: 0.1),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.account_circle,
                            color: kPrimaryColor,
                            size: size.height * 0.15,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.005,
                        ),
                        Container(
                          child: Text(
                            'PROFILE',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: size.height * 0.028,
                                fontFamily: 'Cabin',
                                letterSpacing: 5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.14,
                  ),
                  userData.name == null
                      ? SpinKitWave(
                          color: kPrimaryColor,
                        )
                      : SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: size.width * 0.9,
                                decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: kPrimaryColor, width: 1.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.person,
                                        color: kPrimaryColor,
                                        size: size.height * 0.032,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.1,
                                      ),
                                      Container(
                                        child: Text(
                                          userData.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              // ignore: deprecated_member_use
                                              .title
                                              .copyWith(
                                                  color: kPrimaryColor,
                                                  fontSize:
                                                      size.height * 0.028),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.025,
                              ),
                              Container(
                                width: size.width * 0.9,
                                decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: kPrimaryColor, width: 1.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.phone,
                                        color: kPrimaryColor,
                                        size: size.height * 0.032,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.1,
                                      ),
                                      Container(
                                        child: Text(
                                          userData.phNo,
                                          style: Theme.of(context)
                                              .textTheme
                                              // ignore: deprecated_member_use
                                              .title
                                              .copyWith(
                                                  color: kPrimaryColor,
                                                  fontSize:
                                                      size.height * 0.028),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.025,
                              ),
                              Container(
                                width: size.width * 0.9,
                                decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: kPrimaryColor, width: 1.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.home,
                                        color: kPrimaryColor,
                                        size: size.height * 0.032,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.1,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Text(
                                          userData.add1,
                                          style: Theme.of(context)
                                              .textTheme
                                              // ignore: deprecated_member_use
                                              .title
                                              .copyWith(
                                                  color: kPrimaryColor,
                                                  fontSize:
                                                      size.height * 0.028),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.025,
                              ),
                              Container(
                                width: size.width * 0.9,
                                decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: kPrimaryColor, width: 1.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.location_city,
                                        color: kPrimaryColor,
                                        size: size.height * 0.032,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.1,
                                      ),
                                      Container(
                                        child: Text(
                                          userData.add2,
                                          style: Theme.of(context)
                                              .textTheme
                                              // ignore: deprecated_member_use
                                              .title
                                              .copyWith(
                                                  color: kPrimaryColor,
                                                  fontSize:
                                                      size.height * 0.028),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.025,
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(bottom: size.height * 0.1),
                                width: size.width * 0.9,
                                decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: kPrimaryColor, width: 1.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.location_on,
                                        color: kPrimaryColor,
                                        size: size.height * 0.032,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.1,
                                      ),
                                      Container(
                                        child: Text(
                                          userData.pin,
                                          style: Theme.of(context)
                                              .textTheme
                                              // ignore: deprecated_member_use
                                              .title
                                              .copyWith(
                                                  color: kPrimaryColor,
                                                  fontSize:
                                                      size.height * 0.028),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
