import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Classes/dog_profile.dart';
import 'package:jabwemate/Widgets/profile_pull_up.dart';
import 'package:jabwemate/style/theme.dart' as Theme;

class ProfileCard extends StatefulWidget {
  double width, height;
  int index;
  ScaffoldState state;
  DogProfile dp;
  ProfileCard(this.height, this.width, this.index, this.state, this.dp);
  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(widget.dp.otherImages);
        widget.state.showBottomSheet((context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
            return ProfilePullUp(widget.dp, widget.width, widget.height);
          });
        });
      },
      child: Card(
        color: Theme.MyColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              height: widget.height * 0.63,
              width: widget.width * 0.9,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
                child: Image.network(
                  '${widget.dp.iamgeURL}',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: widget.height * 0.1,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FittedBox(
                    child: Padding(
                      padding: EdgeInsets.only(left: widget.width * 0.05),
                      child: Text(
                        widget.dp.name,
                        style: GoogleFonts.k2d(
                            color: Color(0xFF5F2D40),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: widget.width * 0.05),
                        child: Icon(
                          Icons.location_on,
                          color: Color(0xFF5F2D40).withOpacity(0.5),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          widget.dp.name,
                          style: GoogleFonts.k2d(
                              color: Color(0xFF5F2D40).withOpacity(0.5),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
