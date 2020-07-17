import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Classes/dog_profile.dart';
import 'package:jabwemate/Screens/your_dogs.dart';
import 'package:jabwemate/style/theme.dart';

import 'home_screen.dart';

class Recents extends StatefulWidget {
  @override
  _RecentsState createState() => _RecentsState();
}

class _RecentsState extends State<Recents> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  double height, width;

  @override
  void initState() {
    getRequests();
    getAccepted();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
            height: height,
            child: Column(
              children: [
                dogList.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: dogList.length,
                        itemBuilder: (BuildContext, index) {
                          var item = dogList[index];
                          return notificationCard(
                              item, width, height, _scaffoldKey, state, index);
                        })
                    : Text('No Recent Requests'),
                dogList1.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: dogList1.length,
                        itemBuilder: (BuildContext, index) {
                          var item = dogList1[index];
                          return notificationCard1(item, width, height,
                              _scaffoldKey, state1, payState, index);
                        })
                    : Container(),
              ],
            )));
  }

  List dogList = [];
  List dogList1 = [];
  List dogName = [];
  List dogID = [];
  List state = [];
  List dogName1 = [];
  List dogID1 = [];
  List state1 = [];
  List payState = [];
  getRequests() async {
    dogList.clear();
    dogID.clear();

    state.clear();
    dogName.clear();
    dogList.clear();

    print('started loading');
    await databaseReference
        .collection("Requests")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) async {
        if (f['senderID'] == uid) {
          if (f['status'] == 'Rejected') {
            dogID.add(f['receiverID']);
            dogName.add(f['receiverDog']);
            print(dogName[0]);
            state.add(f['status']);
            dogList.clear();
            print('started loading');
            await databaseReference
                .collection("Dogs")
                .getDocuments()
                .then((QuerySnapshot snapshot) {
              int i = 0;
              snapshot.documents.forEach((f) async {
                if (f['ownerID'] == dogID[i] && f['name'] == dogName[i]) {
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
                  i++;
                }
              });
            });
            setState(() {
              print(dogList.length.toString());
            });
          }
        }
      });
    });
    setState(() {
      print('getAccepted();');
    });
  }

  List myDogName = [];
  getAccepted() async {
    dogID1.clear();
    myDogName.clear();
    state1.clear();
    dogName1.clear();
    dogList1.clear();
    payState.clear();
    print('started loading');
    await databaseReference
        .collection("Requests")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) async {
        if (f['senderID'] == uid) {
          if (f['status'] == 'Accepted') {
            dogID1.add(f['receiverID']);
            myDogName.add(f['senderDog']);
            dogName1.add(f['receiverDog']);
            state1.add(f['status']);
            payState.add(f['senderPayment']);
            dogList1.clear();
            print('started loading');
            await databaseReference
                .collection("Dogs")
                .getDocuments()
                .then((QuerySnapshot snapshot) {
              int i = 0;
              snapshot.documents.forEach((f) async {
                if (f['ownerID'] == dogID1[i] && f['name'] == dogName1[i]) {
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
                  await dogList1.add(dp);
                  print('Dog added');
                  print(f['imageLinks'].toString());
                  i++;
                }
              });
            });
            setState(() {
              print(dogList1.length.toString());
            });
          }
        }
      });
    });
    setState(() {
      print(payState[0]);
    });
  }

  notificationCard(item, width, height, scaffoldKey, status, index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
                          'Recent Request- ${item.name}\nStatus- ${status[index]}',
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
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  notificationCard1(item, width, height, scaffoldKey, status, pay, index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
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
                          'Recent Request- ${item.name}\nStatus- ${status[index]}',
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
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    paid(myDogName[index], item.ownerId);
                  },
                  child: payState[index] == 'notDone'
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            child: Text(
                              'Pay to get contact details',
                              style: GoogleFonts.k2d(
                                  textStyle: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                  fontSize: 20),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            child: Text(
                              '${item.address}, ${item.city}, ${item.phone}',
                              style: GoogleFonts.k2d(
                                  textStyle: TextStyle(
                                    color: Colors.blue,
                                  ),
                                  fontSize: 20),
                            ),
                          ),
                        )),
            ],
          ),
        ),
      ),
    );
  }

  paid(dog, id) async {
    print('started loading');
    await databaseReference
        .collection("Requests")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) async {
        print(uid);
        print(id);
        if (f['receiverID'] == id) {
          if (f['senderDog'] == dog && f['senderID'] == uid) {
            f.reference.updateData({'senderPayment': 'done'});
          }
        }
      });
    });
    setState(() {
      getRequests();
      getAccepted();
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
