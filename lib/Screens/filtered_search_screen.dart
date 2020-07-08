import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Classes/dog_profile.dart';
import 'package:jabwemate/Widgets/custom_drawer.dart';
import 'package:jabwemate/Widgets/profile_card.dart';
import 'package:jabwemate/style/theme.dart' as Theme;

class FilteredSearch extends StatefulWidget {
  @override
  _FilteredSearchState createState() => _FilteredSearchState();
}

class _FilteredSearchState extends State<FilteredSearch> {
  List<DocumentSnapshot> docList = [];
  List<DogProfile> dogList = [];

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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close);
                  this.appBarTitle = new TextFormField(
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
                      maxWidth: width * 0.9,
                      maxHeight: height * 0.75,
                      minWidth: width * 0.8,
                      minHeight: height * 0.74,
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
              : CircularProgressIndicator()
        ],
      ),
    );
  }

  getCaseDetails(String query) async {
    docList.clear();
    dogList.clear();
    setState(() {
      print('Updated');
    });

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
          DogProfile dog = DogProfile(f['profileImage'], f['name'], f['city'],
              f['age'], f['breed'], f['gender'], f['owner']);
          dogList.add(dog);
          setState(() {
            print('Updated');
          });
        }
      });
    });
  }
}
