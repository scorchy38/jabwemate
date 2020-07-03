import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Screens/home_screen.dart';
import 'package:jabwemate/Widgets/appbar.dart';
import 'package:jabwemate/Widgets/custom_text_field.dart';
import 'package:random_string/random_string.dart';

class AddDogScreen extends StatefulWidget {
  @override
  _AddDogScreenState createState() => _AddDogScreenState();
}

TextEditingController name, city, age, breed, gender, owner;

class _AddDogScreenState extends State<AddDogScreen> {
  @override
  void initState() {
    name = new TextEditingController();
    city = new TextEditingController();
    age = new TextEditingController();
    breed = new TextEditingController();
    gender = new TextEditingController();
    owner = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: <Widget>[
          CustomTextField('Enter Name', name),
          CustomTextField('Enter City', city),
          CustomTextField('Enter Age', age),
          CustomTextField('Enter Breed', breed),
          CustomTextField('Enter Gender', gender),
          CustomTextField('Enter Owner', owner),
          InkWell(
            onTap: () {
              saveData();
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xFF2E294E),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Save',
                  style: GoogleFonts.k2d(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

final databaseReference = Firestore.instance;
saveData() async {
  int keyLength = randomBetween(10, 20);
  String key = randomAlpha(keyLength);
  await databaseReference.collection('Dogs').document(key).setData({
    'name': name.text,
    'city': city.text,
    'age': int.parse(age.text),
    'breed': breed.text,
    'gender': gender.text,
    'owner': owner.text,
    'ownerID': uid,
    'profileImage':
        'https://www.nationalgeographic.com/content/dam/photography/PROOF/2018/February/musi-dog-portraits/05-dog-portraits-FP-Jpegs-5.jpg',
  });
  print(name.text.toString());
}
