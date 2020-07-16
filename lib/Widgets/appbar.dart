import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemate/style/theme.dart' as Theme;

// ignore: must_be_immutable
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  IconButton action;
  CustomAppBar({Key key, this.action})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
      actions: widget.action != null ? <Widget>[widget.action] : <Widget>[],
      centerTitle: true,
      title: Text(
        'Jab We Mate',
        style: GoogleFonts.k2d(
            fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
              Theme.MyColors.loginGradientStart,
              Theme.MyColors.loginGradientEnd
            ])),
      ),
    );
  }
}
