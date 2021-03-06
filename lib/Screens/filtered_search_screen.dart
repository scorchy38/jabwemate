import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Classes/dog_profile.dart';
import 'package:jabwemate/Screens/home_screen.dart';
import 'package:jabwemate/Widgets/my_dog_card.dart';
import 'package:jabwemate/Widgets/profile_pull_up.dart';
import 'package:jabwemate/style/theme.dart' as Theme;
import 'package:jabwemate/style/theme.dart';

class FilteredSearch extends StatefulWidget {
  @override
  _FilteredSearchState createState() => _FilteredSearchState();
}

List<DogProfile> dogList1 = [];
List<Widget> dogCardsList1 = [];

class _FilteredSearchState extends State<FilteredSearch> {
  List<DocumentSnapshot> docList = [];
  List<DogProfile> dogList = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController searchController = TextEditingController(text: "");
  Widget appBarTitle = Text(
    'Jab We Mate',
    style: GoogleFonts.k2d(
        fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
  );
  Icon actionIcon = new Icon(Icons.search);

  int number = 0;
  int max = 10;

  @override
  void initState() {
    getData();
    getData1();
  }

  void getData1() async {
    dogCardsList1.clear();
    dogList1.clear();
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
          await dogList1.add(dp);
          await dogCardsList1.add(MyDogCard(dp, width, height));
          print('Dog added');
          print(f['imageLinks'].toString());
        }
      });
    });
    setState(() {
      print(dogList1.length.toString());
      print(dogCardsList1.length.toString());
    });
  }

  double width, height;
  List<Widget> dogCardsList = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close);
                  this.appBarTitle = new TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: searchController,
                    decoration: new InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: 'Search for Names or Breeds..',
                      hintStyle: GoogleFonts.k2d(
                          textStyle: TextStyle(color: Colors.white)),
                    ),
                    onChanged: (String query) {
                      getCaseDetails(query);
                    },
                  );
                } else {
                  this.appBarTitle = Text(
                    'Jab We Mate',
                    style: GoogleFonts.k2d(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white),
                  );
                  this.actionIcon = new Icon(Icons.search);
                }
              });
            },
          ),
        ],
        centerTitle: true,
        title: appBarTitle,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                Theme.MyColors.loginGradientStart,
                Theme.MyColors.loginGradientEnd
              ])),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'Search Results',
                style: GoogleFonts.k2d(
                    fontSize: height * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.5)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: height * 0.75,
                child: ListView.builder(
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
                                      height: 50,
                                      width: 50,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getCaseDetails(String query) async {
    docList.clear();
    dogList.clear();
    setState(() {
      print('Updated');
    });

    if (query == '') {
      print(query);
      getData();
      return;
    }

    await Firestore.instance
        .collection('Dogs')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      docList.clear();
      dogList.clear();
      snapshot.documents.forEach((f) {
        List<String> dogName = List<String>.from(f['nameSearch']);
        List<String> dogBreed = List<String>.from(f['breedSearch']);
        List<String> dogLowerCase = [];
        List<String> breedLowerCase = [];
        for (var dog in dogName) {
          dogLowerCase.add(dog.toLowerCase());
        }
        for (var breed in dogBreed) {
          breedLowerCase.add(breed.toLowerCase());
        }
        if (dogLowerCase.contains(query.toLowerCase()) ||
            breedLowerCase.contains(query.toLowerCase())) {
          print('Match found ${f['name']}');
          docList.add(f);
          DogProfile dog = DogProfile(
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
          dogList.add(dog);
          setState(() {
            print('Updated');
          });
        }
      });
    });
  }

  final databaseReference = Firestore.instance;

  void getData() async {
    await databaseReference
        .collection("Dogs")
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
            otherImages: f['imageLinks']));
        print('Dog added');
        print(f['profileImage'].toString());
      });
    });
    setState(() {
      print(dogList.length.toString());
    });
  }
}
