import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

import 'package:getflutter/getflutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Classes/dog_profile.dart';
import 'package:jabwemate/Screens/docMainScreen.dart';
import 'package:jabwemate/Widgets/custom_drawer.dart';
import 'package:jabwemate/Widgets/appbar.dart';
import 'package:jabwemate/Widgets/my_dog_card.dart';
import 'package:jabwemate/Widgets/profile_card.dart';
import 'package:jabwemate/Widgets/profile_pull_up.dart';
import 'package:jabwemate/adoption_sell_module/AdoptFirstScreen.dart';
import 'package:jabwemate/adoption_sell_module/landing.dart';
import 'package:jabwemate/e-commerce_module/NavBar.dart';
import 'package:jabwemate/style/theme.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
String uid;
List<DogProfile> dogList = new List<DogProfile>();
List dogList2 = new List();
List dogCardsList2 = new List();

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _scaffoldKey2 = GlobalKey<ScaffoldState>();

  int number = 0;
  int max = 10;
  void getUser() async {
    final FirebaseUser user = await auth.currentUser();
    uid = user.uid;
    print(uid);
    // here you write the codes to input the data into firestore
  }

  final databaseReference = Firestore.instance;

  void getData() async {
    dogList.clear();
    print('stsrted loading');
    await databaseReference
        .collection("Dogs")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) async {
        await dogList.add(DogProfile(
            f['profileImage'],
            f['name'],
            f['city'],
            f['age'],
            f['breed'],
            f['gender'],
            f['owner'],
            f['ownerID'],
            f['address'],
            f['phone'],
            otherImages: f['imageLinks']));
        print('Dog added');
        print(f['imageLinks'].toString());
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return new Scaffold(
      key: _scaffoldKey2,
      drawer: CustomDrawer(),
      backgroundColor: Color(0xFFEFF7F6),
      appBar: CustomAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
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
                    borderRadius: BorderRadius.circular(height * 0.15),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/img/essentials.png',
                      height: height * 0.04,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => AdoptFirstScreen(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(height * 0.15),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/img/adoption.png',
                      height: height * 0.04,
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
                    borderRadius: BorderRadius.circular(height * 0.15),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/img/health.png',
                      height: height * 0.04,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: width * 0.95,
            child: Divider(
              color: MyColors.loginGradientEnd,
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Text(
            'Latest Profiles',
            style: GoogleFonts.k2d(
                fontSize: height * 0.035,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.5)),
          ),
          dogList.length != 0
              ? Expanded(
                  child: Container(
                    child: new TinderSwapCard(
                      orientation: AmassOrientation.TOP,
                      totalNum: dogList.length,
                      stackNum: 3,
                      swipeEdge: 4.0,
                      maxWidth: width,
                      maxHeight: height * 0.65,
                      minWidth: width * 0.95,
                      minHeight: height * 0.60,
                      animDuration: 100,
                      cardBuilder: (context, index) => ProfileCard(height,
                          width, index, Scaffold.of(context), dogList[index]),
                      cardController: CardController(),
                      swipeUpdateCallback:
                          (DragUpdateDetails details, Alignment align) {
                        /// Get swiping card's alignment
                        if (align.x < 0) {
                          //Card is LEFT swiping
                        } else if (align.x > 0) {
                          //Card is RIGHT swiping
                        }
                      },
                      swipeCompleteCallback:
                          (CardSwipeOrientation orientation, int index) async {
                        /// Get orientation & index of swiped card!
                        if (orientation == CardSwipeOrientation.RIGHT) {
                          dogCardsList2.clear();
                          dogList2.clear();
                          print('started loading');
                          await databaseReference
                              .collection("Dogs")
                              .getDocuments()
                              .then((QuerySnapshot snapshot) {
                            snapshot.documents.forEach((f) async {
                              if (f['ownerID'] == uid) {
                                DogProfile dp = DogProfile(
                                    f['profileImage'],
                                    f['name'],
                                    f['city'],
                                    f['age'],
                                    f['breed'],
                                    f['gender'],
                                    f['owner'],
                                    f['ownerID'],
                                    f['address'],
                                    f['phone'],
                                    otherImages: f['imageLinks']);
                                await dogList2.add(dp);
                                await dogCardsList2.add(MyDogCard(
                                    dp,
                                    MediaQuery.of(context).size.width,
                                    MediaQuery.of(context).size.height));
                                print('Dog added');
                                print(f['imageLinks'].toString());
                              }
                            });
                          });
                          setState(() {
                            print(dogList2.length.toString());
                            print(dogCardsList2.length.toString());
                          });
                          _scaffoldKey2.currentState.showBottomSheet((context) {
                            return StatefulBuilder(
                                builder: (context, StateSetter state) {
                              return PullUp(dogList2, dogCardsList2,
                                  dogList[index].name, dogList[index].ownerId);
                            });
                          });
                        }
                        print(orientation.toString());
                        print(index.toString());
                      },
                    ),
                  ),
                )
              : Expanded(
                  child: GFLoader(
                  type: GFLoaderType.ios,
                )),
          Container(
            alignment: Alignment.topCenter,
            height: height * 0.15,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Image.asset('assets/img/left_arrow.png'),
                    height: 40,
                  ),
                ),
                Container(
                  width: width * 0.3,
                  child: Text(
                    'Swipe left to reject',
                    style: GoogleFonts.k2d(
                        fontSize: 24, color: Colors.black.withOpacity(0.7)),
                  ),
                ),
                Spacer(),
                Container(
                  width: width * 0.3,
                  child: Text(
                    'Swipe right to request',
                    style: GoogleFonts.k2d(
                        fontSize: 24, color: Colors.black.withOpacity(0.7)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Image.asset('assets/img/right_arrow.png'),
                    height: 40,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
