import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Widgets/appbar.dart';
import 'package:jabwemate/Widgets/custom_text_field.dart';
import 'package:random_string/random_string.dart';

class FeedbackQuery extends StatefulWidget {
  @override
  _FeedbackQueryState createState() => _FeedbackQueryState();
}

class _FeedbackQueryState extends State<FeedbackQuery> {
  TextEditingController name = new TextEditingController(text: '');
  TextEditingController phone = new TextEditingController(text: '+91');
  TextEditingController email = new TextEditingController(text: '');
  TextEditingController city = new TextEditingController(text: '');
  TextEditingController message = new TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                'Send a Feedback or Query to Team JWM',
                style: GoogleFonts.k2d(color: Colors.black, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
              decoration: BoxDecoration(
                  color: Color(0xFF2E294E).withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: name,
                  validator: (value) {
                    if (value.length == 0) {
                      return 'Can\'t be left blank.';
                    } else {
                      return null;
                    }
                  },
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorStyle:
                          GoogleFonts.k2d(color: Colors.white, fontSize: 18),
                      hintStyle:
                          GoogleFonts.k2d(color: Colors.white, fontSize: 18),
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: 'Your name'),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
              decoration: BoxDecoration(
                  color: Color(0xFF2E294E).withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: phone,
                  validator: (value) {
                    if (value.length < 13) {
                      return 'Invalid phone number.';
                    } else {
                      return null;
                    }
                  },
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorStyle:
                          GoogleFonts.k2d(color: Colors.white, fontSize: 18),
                      hintStyle:
                          GoogleFonts.k2d(color: Colors.white, fontSize: 18),
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: 'Your phone number'),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
              decoration: BoxDecoration(
                  color: Color(0xFF2E294E).withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: city,
                  validator: (value) {
                    if (value.length == 0) {
                      return 'Can\'t be left blank.';
                    } else {
                      return null;
                    }
                  },
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorStyle:
                          GoogleFonts.k2d(color: Colors.white, fontSize: 18),
                      hintStyle:
                          GoogleFonts.k2d(color: Colors.white, fontSize: 18),
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: 'Your city'),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
              decoration: BoxDecoration(
                  color: Color(0xFF2E294E).withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: email,
                  validator: (value) {
                    if (value.length == 0) {
                      return 'Can\'t be left blank.';
                    } else {
                      return null;
                    }
                  },
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorStyle:
                          GoogleFonts.k2d(color: Colors.white, fontSize: 18),
                      hintStyle:
                          GoogleFonts.k2d(color: Colors.white, fontSize: 18),
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: 'Your email address'),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
              decoration: BoxDecoration(
                  color: Color(0xFF2E294E).withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: message,
                  maxLines: 6,
                  validator: (value) {
                    if (value.length == 0) {
                      return 'Can\'t be left blank.';
                    } else {
                      return null;
                    }
                  },
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorStyle:
                          GoogleFonts.k2d(color: Colors.white, fontSize: 18),
                      hintStyle:
                          GoogleFonts.k2d(color: Colors.white, fontSize: 18),
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: 'Type your message here'),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (_formKey.currentState.validate()) {
                  writeData();
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
                    'Send to Team JWM',
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
      ),
    );
  }

  writeData() async {
    String key = randomAlphaNumeric(15);
    final dbRef =
        FirebaseDatabase.instance.reference().child('Feedbacks').child(key);
    dbRef.set({
      'name': name.text,
      'phone': phone.text,
      'city': city.text,
      'email': email.text,
      'msg': message.text
    }).then((value) {
      Fluttertoast.showToast(msg: 'Your message has been sent to team JWM.');
      setState(() {
        name.clear();
        city.clear();
        phone.clear();
        email.clear();
        message.clear();
      });
    });
  }
}
