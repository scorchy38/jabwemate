import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getflutter/components/carousel/gf_carousel.dart';
import 'package:jabwemate/e-commerce_module/Classes/Cart.dart';
import 'package:jabwemate/e-commerce_module/Classes/Constants.dart';
import 'package:jabwemate/e-commerce_module/Classes/DatabaseHelper.dart';
import 'package:jabwemate/e-commerce_module/Classes/ItemsClass.dart';

import 'navDrawer.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

final FirebaseAuth mAuth = FirebaseAuth.instance;

class _MainHomeState extends State<MainHome> {
  final dbHelper = DatabaseHelper.instance;
  Cart cartItem;
  int newQty;

  final List<String> imageList = ['1.png', '2.png', '3.png'];

  List<Items> items = [];
  String category = 'Food';

  void getItemsRef() {
    items.clear();
    getCartLength();
    print('Retrieving $category');
    DatabaseReference itemsref =
        FirebaseDatabase.instance.reference().child(category);
    itemsref.once().then((DataSnapshot snap) {
      // ignore: non_constant_identifier_names
      var KEYS = snap.value.keys;
      // ignore: non_constant_identifier_names
      var DATA = snap.value;
      items.clear();
      for (var key in KEYS) {
        print(DATA[key]['Name']);
        print(DATA[key]['Price']);
        print(DATA[key]['ImageUrl']);
        print(DATA[key]['Quantity']);
        Items c = new Items(
            name: DATA[key]['Name'],
            price: DATA[key]['Price'],
            quantity: DATA[key]['Quantity'],
            imageUrl: DATA[key]['ImageUrl'],
            isCart: false);
        items.add(c);
      }
      setState(() {
        length;
        items;
        print(items.length);
      });
    });
  }

  int length = 0;

  getCartLength() async {
    int x = await dbHelper.queryRowCount();
    length = x;
    setState(() {
      length;
    });
  }

  @override
  void initState() {
    super.initState();
    getCartLength();
    getItemsRef();
  }

  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    final pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: NavDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.28,
                  child: GFCarousel(
                    items: imageList.map(
                      (url) {
                        return Card(
                          elevation: 8,
                          margin: EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            child: Image.asset('images/$url',
                                fit: BoxFit.cover, width: 1000.0),
                          ),
                        );
                      },
                    ).toList(),
                    onPageChanged: (index) {
                      setState(() {
                        length;
                        index;
                      });
                    },
                    autoPlay: true,
                    enlargeMainPage: true,
                    pagination: true,
                    passiveIndicator: Colors.black,
                    activeIndicator: Colors.white,
                    pagerSize: 10,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      categoryCard('Food', 'food.png'),
                      categoryCard('Bedding', 'bed.png'),
                      categoryCard('Bowls', 'bowl.png'),
                      categoryCard('Bath Items', 'bath.png'),
                      categoryCard('Collar & Lashes', 'collar.png'),
                      categoryCard('Hair Care', 'hair.png'),
                      categoryCard('Tooth Care', 'teeth.png'),
                      categoryCard('Toys', 'toys.png'),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    var item = items[index];
                    _query(item.name).then((value) {
                      item.isCart = value;
                      setState(() {
                        item.isCart;
                      });
                    });
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.01),
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kPrimaryColor, width: 1.5),
                          boxShadow: [
                            BoxShadow(
                                color: kPrimaryColor,
                                blurRadius: 2.0,
                                spreadRadius: 0.1),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                child: Image(
                                  image: NetworkImage(item.imageUrl),
                                  height: pHeight * 0.058,
                                  width: 60,
                                ),
                              ),
                              SizedBox(
                                width: pWidth * 0.025,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.38,
                                          child: Text(
                                            item.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .title
                                                .copyWith(
                                                    color: kTextColor
                                                        .withOpacity(0.85),
                                                    fontSize: 22.0),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Price : Rs ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .body1
                                                  .copyWith(
                                                      color: kTextColor
                                                          .withOpacity(0.65),
                                                      fontSize: 16.0),
                                            ),
                                            Text(
                                              item.price,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .body1
                                                  .copyWith(
                                                      color: kTextColor
                                                          .withOpacity(0.65),
                                                      fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              item.isCart == true
                                  ? InkWell(
                                      onTap: null,
                                      child: Container(
                                        width: pWidth * 0.21,
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Container(
                                            child: Text(
                                              'Already in cart',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button
                                                  .copyWith(color: kWhiteColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        _query(item.name);
                                        addToCart(
                                            name: item.name,
                                            imgUrl: item.imageUrl.toString(),
                                            price: item.price.toString(),
                                            qty: 1);
                                        setState(() {
                                          item.isCart = true;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Container(
                                            child: Text(
                                              'Add to cart',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button
                                                  .copyWith(color: kWhiteColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryCard(name, image) {
    return InkWell(
      onTap: () {
        setState(() {
          category = name;
        });
        getCartLength();
        getItemsRef();
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Image.asset(
                'assets/images/$image',
                height: 35,
                width: 35,
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Text(
                  name,
                  style:
                      Theme.of(context).textTheme.button.copyWith(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addToCart({String name, String imgUrl, String price, int qty}) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnProductName: name,
      DatabaseHelper.columnImageUrl: imgUrl,
      DatabaseHelper.columnPrice: price,
      DatabaseHelper.columnQuantity: qty
    };
    Cart item = Cart.fromMap(row);
    final id = await dbHelper.insert(item);
    Fluttertoast.showToast(
        msg: 'Added to cart', toastLength: Toast.LENGTH_SHORT);
    getCartLength();
  }

  Future<bool> _query(String name) async {
    Cart cartItem;
    final allRows = await dbHelper.queryRows(name);
    allRows.forEach((row) => cartItem = Cart.fromMap(row));
    if (cartItem == null) {
      return false;
    } else {
      return true;
    }
  }

  void updateItem(
      {int id, String name, String imgUrl, String price, int qty}) async {
    // row to update
    Cart item = Cart(id, name, imgUrl, price, qty);
    final rowsAffected = await dbHelper.update(item);
    _query(name);
    setState(() {
      _query(item.productName);
      print('Updated');
    });
    getCartLength();
  }

  void removeItem(String name) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.delete(name);
    setState(() {
      print('Updated');
    });
    getCartLength();
  }
}
