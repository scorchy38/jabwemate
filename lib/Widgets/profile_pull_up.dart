import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Classes/dog_profile.dart';
import 'package:jabwemate/style/theme.dart';
import 'package:random_string/random_string.dart';

import 'my_dog_card.dart';

class ProfilePullUp extends StatefulWidget {
  double height, width;
  DogProfile dp;
  ProfilePullUp(this.dp, this.width, this.height);

  @override
  _ProfilePullUpState createState() => _ProfilePullUpState();
}

var databaseReference = Firestore.instance;
List dogList = new List();
List dogCardsList = new List();

class _ProfilePullUpState extends State<ProfilePullUp> {
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
                              child: Column(
                                children: <Widget>[
                                  Image.network(widget.dp.iamgeURL),
                                ],
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
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () async {
                              FirebaseUser user =
                                  await FirebaseAuth.instance.currentUser();
                              var uid = user.uid;
                              dogCardsList.clear();
                              dogList.clear();
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
                                    await dogList.add(dp);
                                    await dogCardsList.add(MyDogCard(
                                        dp,
                                        MediaQuery.of(context).size.width,
                                        MediaQuery.of(context).size.height));
                                    print('Dog added');
                                    print(f['imageLinks'].toString());
                                  }
                                });
                              });
                              setState(() {
                                print(dogList.length.toString());
                                print(dogCardsList.length.toString());
                              });
                              _scaffoldKey.currentState
                                  .showBottomSheet((context) {
                                return StatefulBuilder(
                                    builder: (context, StateSetter state) {
                                  return PullUp(dogList, dogCardsList,
                                      widget.dp.name, widget.dp.ownerId);
                                });
                              });
                            },
                            child: Card(
                              color: Color(0xFF5F2D40).withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Make a request',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'nunito',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: widget.height * 0.5,
                            width: double.infinity,
                            child: StaggeredGridView.countBuilder(
                              crossAxisCount: 4,
                              itemCount: widget.dp.otherImages.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  new Container(
                                child:
                                    Image.network(widget.dp.otherImages[index]),
                              ),
                              staggeredTileBuilder: (int index) =>
                                  new StaggeredTile.fit(2),
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 4.0,
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

class PullUp extends StatefulWidget {
  final receiveDog, receiveID;
  final dogList1;
  final dogs;
  PullUp(this.dogList1, this.dogs, this.receiveDog, this.receiveID);

  @override
  _PullUpState createState() => _PullUpState();
}

class _PullUpState extends State<PullUp> {
  double height, width;

  @override
  Widget build(BuildContext context) {
    print(widget.dogs.length);
    BuildContext cxt = context;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: height * 0.005,
          ),
          Text(
            'Your Dogs',
            style: GoogleFonts.k2d(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: height * 0.005,
          ),
          Text(
            'Select your dog',
            style: GoogleFonts.k2d(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: height * 0.005,
          ),
          widget.dogs.length != 0
              ? ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.dogList1.length,
                  itemBuilder: (BuildContext, index) {
                    var item = widget.dogList1[index];

                    return InkWell(
                      onTap: () {
                        makeRequest(item.name, item.ownerId, widget.receiveDog,
                            widget.receiveID);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color:
                                  MyColors.loginGradientStart.withOpacity(0.6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
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
                                    child: CachedNetworkImage(
                                      imageUrl: item.iamgeURL,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                      placeholder: (context, url) => GFLoader(
                                        type: GFLoaderType.ios,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      child: Text(
                                        item.name,
                                        style: GoogleFonts.k2d(fontSize: 24),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Expanded(
                  child: Center(
                    child: Text(
                      'You have not added any dogs yet.\nPlease add a dog to continue.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.k2d(
                        textStyle: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  static int keyLength = randomBetween(10, 20);
  String key = randomAlpha(keyLength);
  final databaseReference1 = Firestore.instance;
  makeRequest(sendDog, sendID, receiveDog, receiveID) async {
    await databaseReference1.collection('Requests').document(key).setData({
      'senderDog': sendDog,
      'senderID': sendID,
      'receiverDog': receiveDog,
      'receiverID': receiveID,
      'senderPayment': 'notDone',
      'status': 'sent'
    });
    Navigator.pop(context);
    Fluttertoast.showToast(msg: 'Request Sent', gravity: ToastGravity.BOTTOM);
  }
}
