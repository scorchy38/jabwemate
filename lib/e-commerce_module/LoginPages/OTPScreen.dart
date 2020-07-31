import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jabwemate/e-commerce_module/Classes/Constants.dart';
import 'package:jabwemate/e-commerce_module/LoginPages/OTPinput.dart';
import 'package:jabwemate/e-commerce_module/OtherPages/SignedIn.dart';

class OTPScreen extends StatefulWidget {
  final String mobileNumber;
  OTPScreen({
    Key key,
    @required this.mobileNumber,
  })  : assert(mobileNumber != null),
        super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Control the input text field.
  TextEditingController _pinEditingController = TextEditingController();

  /// Decorate the outside of the Pin.
  PinDecoration _pinDecoration =
      UnderlineDecoration(enteredColor: Colors.black, hintText: '333333');

  bool isCodeSent = false;
  String _verificationId;

  @override
  void initState() {
    super.initState();
    _onVerifyCode();
  }

  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;

    final pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kWhiteColor,
      appBar: AppBar(
          backgroundColor: kWhiteColor,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            color: kBlackColor,
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Container(
          height: pHeight,
          width: pWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 16.0, bottom: 16, top: 4),
                color: kWhiteColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SvgPicture.asset(
                      'images/loginjwm3.svg',
                      height: pHeight * 0.3,
                    ),
                    Text(
                      "The best care you pet can get",
                      style: Theme.of(context).textTheme.title.copyWith(
                          color: kTextColor.withOpacity(0.75), fontSize: 25.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 16, 0),
                      child: Text(
                        "OTP sent to ${widget.mobileNumber}",
                        style: Theme.of(context).textTheme.body1.copyWith(
                              color: kTextColor.withOpacity(0.6),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(color: kBorderColor, width: 2.0)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: PinInputTextField(
                          pinLength: 6,
                          decoration: _pinDecoration,
                          controller: _pinEditingController,
                          autoFocus: true,
                          textInputAction: TextInputAction.done,
                          onSubmit: (pin) {
                            if (pin.length == 6) {
                              _onFormSubmitted();
                            } else {
                              showToast("Invalid OTP", Colors.red);
                            }
                          },
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(top: 10, left: 16, right: 16),
                        child: Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: RaisedButton(
                              color: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side:
                                    BorderSide(color: kBorderColor, width: 2.0),
                              ),
                              child: Text(
                                "ENTER OTP",
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(fontSize: 20.0),
                              ),
                              onPressed: () {
                                if (_pinEditingController.text.length == 6) {
                                  _onFormSubmitted();
                                } else {
                                  showToast("Invalid OTP", Colors.white);
                                }
                              },
                              padding: EdgeInsets.all(16.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showToast(message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: color,
      textColor: kPrimaryColor,
      fontSize: 16.0,
    );
  }

  void _onVerifyCode() async {
    setState(() {
      isCodeSent = true;
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((AuthResult value) async {
        print(widget.mobileNumber);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => SignedIn(
              phNo: widget.mobileNumber,
            ),
          ),
        );
//        if (value.user != null) {
//          FirebaseUser user = await FirebaseAuth.instance.currentUser();
//          DatabaseReference useraddressref = FirebaseDatabase
//              .instance //Used the UID of the user to check if record exists in the database or not
//              .reference()
//              .child('Users')
//              .child(user.uid);
//          useraddressref.once().then((DataSnapshot snap) {
//            // ignore: non_constant_identifier_names
//            var DATA = snap.value;
//            if (DATA == null) {
//              Navigator.pushAndRemoveUntil(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) => AddressFrame(
//                      phno: widget.mobileNumber,
//                    ),
//                  ),
//                  (Route<dynamic> route) => false);
//            } else {
//              Navigator.pushAndRemoveUntil(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) => null,
//                  ),
//                  (Route<dynamic> route) => false);
//            }
//          });
//        } else {
//          showToast("Error validating OTP, try again", Colors.white);
//        }
      }).catchError((error) {
        showToast("Try again in sometime", Colors.white);
      });
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      showToast(authException.message, Colors.white);
      setState(() {
        isCodeSent = false;
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      showToast('sent', Colors.white);
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91${widget.mobileNumber}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _onFormSubmitted() async {
    AuthCredential _authCredential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: _pinEditingController.text,
    );

    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((AuthResult value) async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SignedIn(
            phNo: widget.mobileNumber,
          ),
        ),
      );

//      if (value.user != null) {
//        FirebaseUser user = await FirebaseAuth.instance.currentUser();
//        DatabaseReference useraddressref = FirebaseDatabase
//            .instance //Used the UID of the user to check if record exists in the database or not
//            .reference()
//            .child('Users')
//            .child(user.uid);
//        useraddressref.once().then((DataSnapshot snap) {
//          // ignore: non_constant_identifier_names
//          var DATA = snap.value;
//          if (DATA == null) {
//            Navigator.pushAndRemoveUntil(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => AddressFrame(
//                    phno: widget.mobileNumber,
//                  ),
//                ),
//                (Route<dynamic> route) => false);
//          } else {
//            Navigator.pushAndRemoveUntil(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => null,
//                ),
//                (Route<dynamic> route) => false);
//          }
//        });
//      } else {
//        showToast("Error validating OTP, try again", Colors.white);
//      }
    }).catchError((error) {
      showToast("Something went wrong", Colors.white);
    });
  }
}
