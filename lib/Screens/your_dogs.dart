import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Classes/dog_profile.dart';
import 'package:jabwemate/Screens/add_dog_screen.dart';
import 'package:jabwemate/Screens/home_screen.dart';
import 'package:jabwemate/Widgets/appbar.dart';
import 'package:jabwemate/Widgets/my_dog_card.dart';
import 'package:jabwemate/Widgets/profile_pull_up.dart';
import 'package:jabwemate/style/theme.dart';

class YourDogs extends StatefulWidget {
  @override
  _YourDogsState createState() => _YourDogsState();
}

final databaseReference = Firestore.instance;
List dogList = [];
List<Widget> dogCardsList = [];

FirebaseAuth mAuth;
bool loading = true;
Widget loader = GFLoader(
  type: GFLoaderType.ios,
);
final _scaffoldKey = GlobalKey<ScaffoldState>();

class _YourDogsState extends State<YourDogs> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
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
          await dogCardsList.add(MyDogCard(dp, width, height));
          print('Dog added');
          print(f['imageLinks'].toString());
        }
      });
    });
    setState(() {
      print(dogList.length.toString());
      print(dogCardsList.length.toString());
    });
  }

  double width, height;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 10), () {
      setState(() {
        loader = Center(child: Text('No dogs'));
      });

      //pop dialog
    });
    BuildContext cxt = context;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        action: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => AddDogScreen()));
          },
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: dogCardsList.length != 0
          ? ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: dogList.length,
              itemBuilder: (BuildContext, index) {
                var item = dogList[index];
                return InkWell(
                  onTap: () {
                    _scaffoldKey.currentState.showBottomSheet((context) {
                      return StatefulBuilder(
                          builder: (context, StateSetter state) {
                        return ProfilePullUp(item, width, height);
                      });
                    });
                  },
                  child: Padding(
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
                                child: CachedNetworkImage(
                                  imageUrl: item.iamgeURL,
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
                            Icon(
                              Icons.info_outline,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(child: loader),
    );
  }
}
