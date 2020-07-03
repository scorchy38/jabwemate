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

List<String> welcomeImages = [
  'https://www.nationalgeographic.com/content/dam/photography/PROOF/2018/February/musi-dog-portraits/05-dog-portraits-FP-Jpegs-5.jpg',
  'https://i1.wp.com/jimharrisphoto.com/wp-content/uploads/2014/06/pet-photography.jpg?ssl=1',
  'https://images.unsplash.com/photo-1535745049887-3cd1c8aef237?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60',
  'https://images.unsplash.com/photo-1518700445284-c7212fa9ab88?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60',
  'https://images.unsplash.com/photo-1531842477197-54acf89bff98?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60',
  'https://images.unsplash.com/photo-1585060423772-a39f0b543c61?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60',
  'https://images.unsplash.com/photo-1536524293309-dec90390d9fd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60',
  'https://images.unsplash.com/photo-1581179222927-277438492810?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60',
  'https://images.unsplash.com/photo-1550165298-543077a40399?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60',
  'https://images.unsplash.com/photo-1582001961959-aa434d61c708?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60',
  'https://images.unsplash.com/photo-1527272786992-a70c29447012?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60',
  'https://images.unsplash.com/photo-1555557135-0971899f7e3c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60',
  'https://images.unsplash.com/photo-1593620659530-7f98c53de278?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60',
  'https://images.unsplash.com/photo-1583421291124-1dbd783be565?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60',
  'https://images.unsplash.com/photo-1513688365525-03a864e341a1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60',
  'https://images.unsplash.com/photo-1543702303-71766260f6d3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60',
  'https://images.unsplash.com/photo-1552257524-66af6dc9e77c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60',
  'https://images.unsplash.com/photo-1583555338180-5c68ea04312d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60'
];

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
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
