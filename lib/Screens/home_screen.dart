import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Classes/dog_profile.dart';
import 'package:jabwemate/Widgets/custom_drawer.dart';
import 'package:jabwemate/Widgets/appbar.dart';
import 'package:jabwemate/Widgets/profile_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
String uid;
List<DogProfile> dogList = new List<DogProfile>();

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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
      drawer: CustomDrawer(),
      backgroundColor: Color(0xFFEFF7F6),
      appBar: CustomAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
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
                          (CardSwipeOrientation orientation, int index) {
                        /// Get orientation & index of swiped card!
                        setState(() {
                          number = index;
                        });
                        print(orientation.toString());
                        print(index.toString());
                      },
                    ),
                  ),
                )
              : CircularProgressIndicator(),
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
