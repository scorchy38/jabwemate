import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jabwemate/e-commerce_module/Classes/Constants.dart';
import 'package:jabwemate/e-commerce_module/Drawer/support_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  String _platformVersion = 'Unknown';
  @override
  void initState() {
    super.initState();
  }

  double pWidth, pHeight;
  @override
  Widget build(BuildContext context) {
    pHeight = MediaQuery.of(context).size.height;
    pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Have any complaint? ',
          style: TextStyle(
            color: kTextColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kTextColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: <Widget>[
          Image(
            image: AssetImage('images/hello.png'),
            height: pHeight / 2.5,
          ),
          SizedBox(
            height: pHeight / 50,
          ),
          Text(
            "How can we help you?",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: pHeight / 50,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
                "If you have any complaint regarding any product or service feel free"
                "to contact us. Your problem will be taken into consideration as soon as possible",
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center),
          ),
          SizedBox(
            height: pHeight / 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  launch('https://api.whatsapp.com/send?phone=919027553376');
                },
                child: SizedBox(
                  height: pHeight / 6.5,
                  width: pWidth / 3,
                  child: Card(
                    elevation: 7.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.whatsapp,
                          size: pHeight / 25.0,
                          color: Colors.green,
                        ),
                        SizedBox(
                          height: pHeight / 70,
                        ),
                        Text(
                          "Chat with us",
                          style: TextStyle(fontSize: pHeight / 60),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Support())),
                child: SizedBox(
                  height: pHeight / 6.5,
                  width: pWidth / 3,
                  child: Card(
                    elevation: 7.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.mailBulk,
                          size: pHeight / 25.0,
                          color: Color.fromARGB(255, 143, 23, 255),
                        ),
                        SizedBox(
                          height: pHeight / 70,
                        ),
                        Text(
                          "Email Us",
                          style: TextStyle(fontSize: pHeight / 60),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
