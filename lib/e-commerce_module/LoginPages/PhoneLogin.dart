import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jabwemate/e-commerce_module/Classes/Constants.dart';
import 'package:jabwemate/e-commerce_module/LoginPages/OTPScreen.dart';

class PhoneLogin extends StatefulWidget {
  PhoneLogin({Key key}) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final TextEditingController _phoneNumberController = TextEditingController();

  bool isValid = false;

  Future<Null> validate() async {
    if (_phoneNumberController.text.length == 10) {
      setState(() {
        isValid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SingleChildScrollView(
        child: Container(
          color: kWhiteColor,
          padding: EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  'images/loginjwm2.svg',
                  height: 250,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 10),
                child: Text(
                  'Link your phone number to your account',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.title.copyWith(
                      color: kTextColor.withOpacity(0.7), fontSize: 25.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _phoneNumberController,
                          autofocus: true,
                          onChanged: (text) {
                            validate();
                          },
                          decoration: InputDecoration(
                            labelText: "10 digit mobile number",
                            prefix: Container(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                "+91",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ),
                          autovalidate: true,
                          autocorrect: false,
                          maxLengthEnforced: true,
                          validator: (value) {
                            return !isValid
                                ? 'Please provide a valid 10 digit phone number'
                                : null;
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: RaisedButton(
                              color: !isValid ? kSecondaryColor : kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Text(
                                !isValid ? "ENTER PHONE NUMBER" : "CONTINUE",
                                style: !isValid
                                    ? Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(
                                            fontSize: 20.0, color: kWhiteColor)
                                    : Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(
                                            fontSize: 20.0, color: kWhiteColor),
                              ),
                              onPressed: () {
                                if (isValid) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OTPScreen(
                                          mobileNumber:
                                              _phoneNumberController.text,
                                        ),
                                      ));
                                } else {
                                  validate();
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
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
