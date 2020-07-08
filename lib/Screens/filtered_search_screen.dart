import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Classes/dog_profile.dart';
import 'package:jabwemate/Widgets/custom_drawer.dart';
import 'package:jabwemate/style/theme.dart' as Theme;

class FilteredSearch extends StatefulWidget {
  @override
  _FilteredSearchState createState() => _FilteredSearchState();
}

class _FilteredSearchState extends State<FilteredSearch> {
  List<DocumentSnapshot> docList = [];

  TextEditingController searchController = TextEditingController(text: "");
  Widget appBarTitle = Text(
    'Jab We Mate',
    style: GoogleFonts.k2d(
        fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
  );
  Icon actionIcon = new Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
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
        body: ListView.builder(
            itemCount: docList.length,
            itemBuilder: (context, index) {
              var item = docList[index];
              return Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  item['name'],
                  style: GoogleFonts.k2d(
                      textStyle: TextStyle(color: Colors.black, fontSize: 30)),
                ),
              );
            }));
  }

  getCaseDetails(String query) async {
    docList.clear();
    setState(() {
      print('Updated');
    });

    await Firestore.instance
        .collection('Dogs')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      docList.clear();
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
          setState(() {
            print('Updated');
          });
        }
      });
    });
  }
}
