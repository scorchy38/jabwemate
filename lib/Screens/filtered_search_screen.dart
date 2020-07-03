import 'package:flutter/material.dart';
import 'package:jabwemate/Widgets/CustomDrawer.dart';
import 'package:jabwemate/Widgets/appbar.dart';

class FilteredSearch extends StatefulWidget {
  @override
  _FilteredSearchState createState() => _FilteredSearchState();
}

class _FilteredSearchState extends State<FilteredSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: CustomAppBar(),
      body: Center(
          child: Container(
        child: Text('Filtered Search'),
      )),
    );
  }
}
