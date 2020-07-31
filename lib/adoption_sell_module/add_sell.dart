import 'dart:async';
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
import 'package:jabwemate/Widgets/appbar.dart';
import 'package:jabwemate/Widgets/custom_text_field.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:random_string/random_string.dart';

class AddDogSell extends StatefulWidget {
  @override
  _AddDogSellState createState() => _AddDogSellState();
}

TextEditingController name,
    city,
    age,
    breed,
    gender,
    owner,
    address1,
    address2,
    phone;

class _AddDogSellState extends State<AddDogSell> {
  @override
  void initState() {
    name = new TextEditingController();
    city = new TextEditingController();
    age = new TextEditingController();
    breed = new TextEditingController();
    gender = new TextEditingController();
    owner = new TextEditingController();
    address1 = TextEditingController();
    address2 = TextEditingController();
    phone = TextEditingController();

    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ProgressDialog pr;

  bool _isLoading = false;
  double _progress = 0;
  String url;
  void _uploadFile(File file, String filename) async {
    final FirebaseStorage _storage =
        FirebaseStorage(storageBucket: 'gs://jab-we-mate-ef838.appspot.com/');
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    StorageReference storageReference;
    storageReference = _storage.ref().child("Dogs/$key/profileImage");

    final StorageUploadTask uploadTask = storageReference.putFile(file);
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Download,
      textDirection: TextDirection.rtl,
      isDismissible: false,
    );
    pr.style(
      message: 'Uploading photo...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      progressWidgetAlignment: Alignment.center,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    await pr.show();
    uploadTask.events.listen((event) {
      setState(() {
        _isLoading = true;
        _progress = (event.snapshot.bytesTransferred.toDouble() /
                event.snapshot.totalByteCount.toDouble()) *
            100;
        print('${_progress.toStringAsFixed(2)}%');
        pr.update(
          progress: double.parse(_progress.toStringAsFixed(2)),
          maxProgress: 100.0,
        );
      });
    }).onError((error) {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(error.toString()),
        backgroundColor: Colors.red,
      ));
    });

    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    url = (await downloadUrl.ref.getDownloadURL());

    print("URL is $url");
    Fluttertoast.showToast(
        msg: 'Upload Complete', gravity: ToastGravity.BOTTOM);
    setState(() async {
      await pr.hide();
    });
  }

  File file;
  String fileName = '';

  Future filePicker(BuildContext context) async {
    try {
      file = await FilePicker.getFile(type: FileType.any);
      setState(() {
        fileName = p.basename(file.path);
      });
      print(fileName);
      Fluttertoast.showToast(msg: 'Uploading...', gravity: ToastGravity.BOTTOM);
      setState(() {});
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

  List urls = new List();
  void _uploadFileMultiple(
      File file, String filename, String key, int i) async {
    final FirebaseStorage _storage =
        FirebaseStorage(storageBucket: 'gs://jab-we-mate-ef838.appspot.com/');
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    StorageReference storageReference;
    storageReference = _storage.ref().child("Dogs/$key/otherImages");

    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    urls.add(await downloadUrl.ref.getDownloadURL());
    print("URL is ${urls[i]}");

    Fluttertoast.showToast(
        msg: 'Upload Complete', gravity: ToastGravity.CENTER);
    setState(() {
      print(key);
    });
  }

  List<File> files = new List();
  Future filePickerMultiple(BuildContext context) async {
    try {
      files = await FilePicker.getMultiFile(
          type: FileType.custom,
          allowedExtensions: ['jpeg', 'jpg', 'png', 'mp4', 'mov']);
      urls.clear();
      for (int i = 0; i < files.length; i++) {
        setState(() {
          fileName = p.basename(files[i].path);
        });
        print(fileName);
        _uploadFileMultiple(files[i], fileName, key, i);
      }
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
      key: _scaffoldKey,
      appBar: CustomAppBar(),
      body: Column(
        children: <Widget>[
          CustomTextField('Enter Name', name),
          CustomTextField('Enter City', city),
          CustomTextField('Enter Age', age),
          CustomTextField('Address line 1', address1),
          CustomTextField('Address line 2', address2),
          CustomTextField('Active Phone Number', phone),
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
                  'Upload Profile Image',
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
              filePickerMultiple(context);
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
                  'Upload other images',
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
              if (url != null && urls.length != 0) {
                print('URL IS $url');
                print('URLs are $urls');
                saveData();
              } else {
                Fluttertoast.showToast(
                    msg: 'Please upload images to add your dog');
              }
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
    await databaseReference.collection('SellDogs').document(key).setData({
      'name': name.text,
      'city': city.text,
      'age': int.parse(age.text),
      'breed': breed.text,
      'gender': gender.text,
      'owner': owner.text,
      'ownerID': uid,
      'profileImage': url,
      'imageLinks': urls,
      "nameSearch": setSearchParam(name.text),
      "breedSearch": setSearchParam(breed.text)
    });
    print(name.text.toString());
    Fluttertoast.showToast(msg: 'Dog added', gravity: ToastGravity.BOTTOM);
    Navigator.pop(context);
  }

  setSearchParam(String caseString) {
    List<String> caseSearchList = List();
    String temp = "";
    for (int i = 0; i < caseString.length; i++) {
      temp = temp + caseString[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }
}
