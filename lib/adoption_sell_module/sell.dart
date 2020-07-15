import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Classes/dog_profile.dart';
import 'package:jabwemate/Screens/home_screen.dart';
import 'package:jabwemate/Widgets/appbar.dart';
import 'package:jabwemate/Widgets/custom_drawer.dart';
import 'package:jabwemate/Widgets/my_dog_card.dart';
import 'package:jabwemate/Widgets/profile_pull_up.dart';
import 'package:jabwemate/adoption_sell_module/add_adoption.dart';
import 'package:jabwemate/adoption_sell_module/add_sell.dart';
import 'package:jabwemate/style/theme.dart';

class Sell extends StatefulWidget {
  @override
  _SellState createState() => _SellState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();

class _SellState extends State<Sell> {
  void getUser() async {
    final FirebaseUser user = await auth.currentUser();
    uid = user.uid;
    print(uid);
    // here you write the codes to input the data into firestore
  }

  double width, height;
  List<Widget> dogCardsList = [];
  final databaseReference = Firestore.instance;

  void getData() async {
    dogList.clear();
    await databaseReference
        .collection("SellDogs")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        dogList.add(DogProfile(f['profileImage'], f['name'], f['city'],
            f['age'], f['breed'], f['gender'], f['owner']));
        dogCardsList.add(MyDogCard(
            DogProfile(f['profileImage'], f['name'], f['city'], f['age'],
                f['breed'], f['gender'], f['owner'],
                otherImages: f['imageLinks']),
            width,
            height));
        print('Dog added');
        print(f['profileImage'].toString());
      });
    });
    setState(() {
      print(dogList.length.toString());
    });
  }

  @override
  void initState() {
    getUser();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BuildContext cxt = context;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: dogCardsList.length != 0
          ? ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: dogList.length,
              itemBuilder: (BuildContext, index) {
                var item = dogList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyColors.loginGradientStart.withOpacity(0.6),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: Image.network(
                                item.iamgeURL,
                                height: 50,
                                width: 50,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                child: Text(
                                  item.name,
                                  style: GoogleFonts.k2d(fontSize: 24),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _scaffoldKey.currentState
                                  .showBottomSheet((context) {
                                return StatefulBuilder(
                                    builder: (context, StateSetter state) {
                                  return ProfilePullUp(item, width, height);
                                });
                              });
                            },
                            icon: Icon(
                              Icons.info_outline,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
