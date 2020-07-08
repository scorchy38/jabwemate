import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/Classes/dog_profile.dart';

class ProfilePullUp extends StatefulWidget {
  double height, width;
  DogProfile dp;
  ProfilePullUp(this.dp, this.width, this.height);
  @override
  _ProfilePullUpState createState() => _ProfilePullUpState();
}

class _ProfilePullUpState extends State<ProfilePullUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 30.0, // soften the shadow
                  spreadRadius: 3.0, //extend the shadow
                  offset: Offset(
                    0.0, // Move to right 10  horizontally
                    0.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: EdgeInsets.fromLTRB(20, 20, 20, 40),
          padding: EdgeInsets.all(15),
          height: widget.height,
          width: widget.width,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.dp.name,
                      style: GoogleFonts.k2d(
                          color: Color(0xFF5F2D40),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 40,
                      ),
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              child: Image.network(
                                widget.dp.iamgeURL,
                                alignment: Alignment.center,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Gender-${widget.dp.gender}',
                            style: GoogleFonts.k2d(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            'City- ${widget.dp.city}',
                            style: GoogleFonts.k2d(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            'Breed- ${widget.dp.breed}',
                            style: GoogleFonts.k2d(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            'Age- ${widget.dp.age}',
                            style: GoogleFonts.k2d(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: null,
                            child: Card(
                              color: Color(0xFF5F2D40).withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Make a request',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'nunito',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: widget.height * 0.5,
                            width: double.infinity,
                            child: StaggeredGridView.countBuilder(
                              crossAxisCount: 4,
                              itemCount: 18,
                              itemBuilder: (BuildContext context, int index) =>
                                  new Container(
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  child: Image.network(
                                    widget.dp.iamgeURL,
                                    alignment: Alignment.center,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              staggeredTileBuilder: (int index) =>
                                  new StaggeredTile.fit(2),
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 4.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
