import 'package:flutter/material.dart';

class PickImage extends StatefulWidget {
  @override
  _PickImageState createState() => new _PickImageState();
}

class _PickImageState extends State<PickImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(),
    );
  }
}
