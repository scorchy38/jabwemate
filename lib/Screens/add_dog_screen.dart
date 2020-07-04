import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Screens/home_screen.dart';
import 'package:jabwemate/Screens/pick_image_screen.dart';
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

  String url;
  void _uploadFile(File file, String filename) async {
    final FirebaseStorage _storage =
        FirebaseStorage(storageBucket: 'gs://jab-we-mate-ef838.appspot.com/');
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    StorageReference storageReference;
    storageReference = _storage.ref().child("Dogs/$key/profileImage");

    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
    Fluttertoast.showToast(
        msg: 'Upload Complete', gravity: ToastGravity.CENTER);
    setState(() {});
  }

  File file;
  String fileName = '';

  Future filePicker(BuildContext context) async {
    try {
      file = await FilePicker.getFile(type: FileType.image);
      setState(() {
        fileName = p.basename(file.path);
      });
      print(fileName);
      _uploadFile(file, fileName);
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sorry...'),
              content: Text('Unsupported exception: $e'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
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
              filePicker(context);
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
                  'Upload',
                  style: GoogleFonts.k2d(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
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

  static int keyLength = randomBetween(10, 20);
  String key = randomAlpha(keyLength);
  final databaseReference = Firestore.instance;
  saveData() async {
    await databaseReference.collection('Dogs').document(key).setData({
      'name': name.text,
      'city': city.text,
      'age': int.parse(age.text),
      'breed': breed.text,
      'gender': gender.text,
      'owner': owner.text,
      'ownerID': uid,
      'profileImage': url,
    });
    print(name.text.toString());
  }
}
