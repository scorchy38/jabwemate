import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Classes/dog_profile.dart';
import 'package:jabwemate/Screens/your_dogs.dart';
import 'package:jabwemate/style/theme.dart';

import 'home_screen.dart';

class Sent extends StatefulWidget {
  @override
  _SentState createState() => _SentState();
}

class _SentState extends State<Sent> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  double height, width;

  @override
  void initState() {
    getRequests();
    super.initState();
  }

  String status = "Loading";
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 10000), () {
// Here you can write your code
      status = "No Recent Requests";
      setState(() {
        // Here you can write your code for open new view
      });
    });
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
            alignment:
                dogList.length == 0 ? Alignment.center : Alignment.topCenter,
            height: height,
            child: dogList.length != 0
                ? ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: dogList.length,
                    itemBuilder: (BuildContext, index) {
                      var item = dogList[index];
                      return notificationCard(
                          item, width, height, _scaffoldKey);
                    })
                : status == "Loading"
                    ? Center(
                        child: GFLoader(
                        type: GFLoaderType.ios,
                      ))
                    : Center(child: Text(status))));
  }

  List dogList = [];
  String dogID, dogName;
  getRequests() async {
    dogList.clear();
    print('started loading');
    await databaseReference
        .collection("Requests")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) async {
        if (f['senderID'] == uid && f['status'] == 'sent') {
          dogID = f['receiverID'];
          dogName = f['receiverDog'];
          dogList.clear();
          print('started loading');
          await databaseReference
              .collection("Dogs")
              .getDocuments()
              .then((QuerySnapshot snapshot) {
            snapshot.documents.forEach((f) async {
              if (f['ownerID'] == dogID && f['name'] == dogName) {
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
                print('Dog added');
                print(f['imageLinks'].toString());
              }
            });
          });
          setState(() {
            print(dogList.length.toString());
          });
        }
      });
    });
    setState(() {
      print(dogList.length.toString());
    });
  }

  notificationCard(item, width, height, scaffoldKey) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: MyColors.loginGradientStart.withOpacity(0.6),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: width * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: Text(
                          'You sent a request to ${item.name} for your pet\'s mating.',
                          style: GoogleFonts.k2d(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      scaffoldKey.currentState.showBottomSheet((context) {
                        return StatefulBuilder(
                            builder: (context, StateSetter state) {
                          return NewPullUp(item, width, height);
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
            ],
          ),
        ),
      ),
    );
  }

  remove(dogID, dogName) async {
    print('started loading');
    await databaseReference
        .collection("Requests")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) async {
        if (f['receiverID'] == uid) {
          if (f['senderDog'] == dogName && f['senderID'] == dogID) {
            f.reference.delete();
          }
        }
      });
    });
    setState(() {
      getRequests();
    });
  }
}

class NewPullUp extends StatefulWidget {
  double height, width;
  DogProfile dp;
  NewPullUp(this.dp, this.width, this.height);

  @override
  _NewPullUpState createState() => _NewPullUpState();
}

class _NewPullUpState extends State<NewPullUp> {
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
                          Image.network(widget.dp.iamgeURL),
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
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.dp.otherImages[index],
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider,
                                            alignment: Alignment.center,
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
