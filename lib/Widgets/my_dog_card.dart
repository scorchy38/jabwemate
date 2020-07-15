import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Classes/dog_profile.dart';
import 'package:jabwemate/Widgets/profile_pull_up.dart';
import 'package:jabwemate/style/theme.dart';

class MyDogCard extends StatefulWidget {
  DogProfile dp;
  double width, height;
  ScaffoldState state;
  BuildContext context;
  MyDogCard(this.dp, this.width, this.height, {this.context});
  @override
  _MyDogCardState createState() => _MyDogCardState();
}

class _MyDogCardState extends State<MyDogCard> {
  @override
  Widget build(BuildContext context) {
    print(widget.width);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: MyColors.loginGradientStart.withOpacity(0.6),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: widget.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.network(
                    widget.dp.iamgeURL,
                    height: 50,
                    width: 50,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    child: Text(
                      widget.dp.name,
                      style: GoogleFonts.k2d(fontSize: 24),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
//                  widget.state.showBottomSheet((context) {
//                    return StatefulBuilder(
//                        builder: (BuildContext context, StateSetter state) {
//                      return ProfilePullUp(
//                          widget.dp, widget.width, widget.height);
//                    });
//                  });
                },
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
