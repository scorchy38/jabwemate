import 'package:flutter/material.dart';
import 'package:getflutter/components/image/gf_image_overlay.dart';
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
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          height: widget.height * 0.63,
          width: widget.width * 0.9,
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: GFImageOverlay(
                image: NetworkImage(widget.dp.iamgeURL),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.dp.name,
                        style:
                            GoogleFonts.k2d(color: Colors.white, fontSize: 24),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.white,
                          ),
                          Text(
                            widget.dp.city,
                            style: GoogleFonts.k2d(
                                color: Colors.white, fontSize: 24),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
