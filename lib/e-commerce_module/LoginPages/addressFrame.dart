import 'package:flutter/material.dart';
import 'package:jabwemate/e-commerce_module/Classes/Constants.dart';
import 'package:jabwemate/e-commerce_module/LoginPages/address.dart';

class AddressFrame extends StatefulWidget {
  final String phno;
  AddressFrame({Key key, this.phno}) : super(key: key);

  @override
  _AddressFrameState createState() => _AddressFrameState();
}

class _AddressFrameState extends State<AddressFrame> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kWhiteColor,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Enter Primary Address',
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(fontSize: 30.0, color: kTextColor),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  height: 360,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: PageView(
                      controller: pageController,
                      children: <Widget>[
                        Address(
                          phno: widget.phno,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
