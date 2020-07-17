import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Classes/dog_profile.dart';
import 'package:jabwemate/Screens/home_screen.dart';
import 'package:jabwemate/Widgets/appbar.dart';
import 'package:jabwemate/Widgets/custom_drawer.dart';
import 'package:jabwemate/Widgets/my_dog_card.dart';
import 'package:jabwemate/Widgets/profile_pull_up.dart';
import 'package:jabwemate/adoption_sell_module/add_adoption.dart';
import 'package:jabwemate/style/theme.dart';

class Adoption extends StatefulWidget {
  @override
  _AdoptionState createState() => _AdoptionState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();

class _AdoptionState extends State<Adoption> {
  void getUser() async {
    final FirebaseUser user = await auth.currentUser();
    uid = user.uid;
    print(uid);
    // here you write the codes to input the data into firestore
  }

  final databaseReference = Firestore.instance;
  double width, height;
  List<Widget> dogCardsList = [];
  List dogList = [];
  void getData() async {
    dogList.clear();
    await databaseReference
        .collection("AdoptionDogs")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        dogList.add(DogProfile(
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
        ));
        dogCardsList.add(MyDogCard(
            DogProfile(
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
                otherImages: f['imageLinks']),
            width,
            height,
            context: context));
        print('Dog added');
        print(f['imageLinks'].toString());
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
                                  return ProfilePullUpAdoptSell(
                                      item, width, height);
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

class ProfilePullUpAdoptSell extends StatefulWidget {
  double height, width;
  DogProfile dp;
  ProfilePullUpAdoptSell(this.dp, this.width, this.height);

  @override
  _ProfilePullUpAdoptSellState createState() => _ProfilePullUpAdoptSellState();
}

var databaseReference = Firestore.instance;
List dogList = new List();
List dogCardsList = new List();

class _ProfilePullUpAdoptSellState extends State<ProfilePullUpAdoptSell> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 30.0, // soften the shadow
                  spreadRadius: 3.0, //extend the shadow
                  offset: Offset(
                    0.0, // Move to right 10  horizontally
                    0.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: EdgeInsets.fromLTRB(20, 20, 20, 40),
          padding: EdgeInsets.all(15),
          height: widget.height,
          width: widget.width,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.dp.name,
                      style: GoogleFonts.k2d(
                          color: Color(0xFF5F2D40),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 40,
                      ),
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              child: Image.network(
                                widget.dp.iamgeURL,
                                alignment: Alignment.center,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Gender-${widget.dp.gender}',
                            style: GoogleFonts.k2d(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            'City- ${widget.dp.city}',
                            style: GoogleFonts.k2d(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            'Breed- ${widget.dp.breed}',
                            style: GoogleFonts.k2d(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            'Age- ${widget.dp.age}',
                            style: GoogleFonts.k2d(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            'Owner name- ${widget.dp.owner}',
                            style: GoogleFonts.k2d(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            'Owner Phone No.- ${widget.dp.phone}',
                            style: GoogleFonts.k2d(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            'Owner Address- ${widget.dp.address}',
                            style: GoogleFonts.k2d(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: widget.height * 0.5,
                            width: double.infinity,
                            child: widget.dp.otherImages != null
                                ? StaggeredGridView.countBuilder(
                                    crossAxisCount: 4,
                                    itemCount: widget.dp.otherImages.length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            new Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        child: Image.network(
                                          widget.dp.otherImages[index],
                                          alignment: Alignment.center,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    staggeredTileBuilder: (int index) =>
                                        new StaggeredTile.fit(2),
                                    mainAxisSpacing: 4.0,
                                    crossAxisSpacing: 4.0,
                                  )
                                : Center(
                                    child: Text('No other images'),
                                  ),
                          )
                        ],
                      ),
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
