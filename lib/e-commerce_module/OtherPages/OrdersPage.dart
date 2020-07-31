import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jabwemate/e-commerce_module/Classes/Constants.dart';
import 'package:jabwemate/e-commerce_module/Classes/Issues.dart';
import 'package:jabwemate/e-commerce_module/Classes/Orders.dart';

import 'IssuePage.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    getOrders();
    getIssueOrders();
  }

  List<Orders> pastOrders = [];
  List<Orders> ongoingOrders = [];
  List<Issues> issueOrders = [];
  FirebaseAuth mAuth = FirebaseAuth.instance;

  getIssueOrders() async {
    issueOrders.clear();
    final FirebaseUser user = await mAuth.currentUser();
    DatabaseReference orderRef =
        FirebaseDatabase.instance.reference().child('Issues').child(user.uid);
    orderRef.once().then((DataSnapshot snapshot) async {
      Map<dynamic, dynamic> values = await snapshot.value;
      values.forEach((key, values) async {
        Issues newOrder = Issues();
        newOrder.orderAmount = values['orderAmount'];
        print('Issue amount ${newOrder.orderAmount}');
        newOrder.itemsName = List<String>.from(values['itemsName']);
        newOrder.itemsQty = List<int>.from(values['itemsQty']);
        newOrder.placedTime = values['DateTime'];
        newOrder.completedTime = values['CompletedTime'];
        newOrder.status = values['Status'];
        newOrder.desc = values['IssueDescription'];
        newOrder.request = values['Request'];

        issueOrders.add(newOrder);

        setState(() {
          pastOrders;
          ongoingOrders;
          print('An order fetched');
        });
      });
    });

    print(ongoingOrders.length);
    print(pastOrders.length);
  }

  getOrders() async {
    pastOrders.clear();
    ongoingOrders.clear();
    final FirebaseUser user = await mAuth.currentUser();
    DatabaseReference orderRef =
        FirebaseDatabase.instance.reference().child('Orders').child(user.uid);
    orderRef.once().then((DataSnapshot snapshot) async {
      Map<dynamic, dynamic> values = await snapshot.value;
      values.forEach((key, values) async {
        Orders newOrder = Orders();
        newOrder.orderAmount = values['orderAmount'];
        print(newOrder.orderAmount);
        newOrder.itemsName = List<String>.from(values['itemsName']);
        newOrder.itemsQty = List<int>.from(values['itemsQty']);
        newOrder.dateTime = values['DateTime'];
        print(newOrder.dateTime);
        newOrder.completedTime = values['CompletedTime'];
        print(newOrder.completedTime);
        newOrder.shippedTime = values['ShippedTime'];
        newOrder.status = values['Status'];
        print(newOrder.status);
        print(newOrder.shippedTime);
        print(newOrder.itemsQty);
        print(newOrder.itemsName);
        if (values['isCompleted'] == false) {
          print('Ongoing');
          ongoingOrders.add(newOrder);
        } else {
          print('Past');
          pastOrders.add(newOrder);
        }

        setState(() {
          pastOrders;
          ongoingOrders;
          print('An order fetched');
        });
      });
    });

    print(ongoingOrders.length);
    print(pastOrders.length);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[kPrimaryColor, kSecondaryColor])),
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.watch_later,
                  color: Colors.white,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.error,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          physics: ScrollPhysics(),
          children: <Widget>[
            ongoingOrders.length == 0
                ? SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Text('You have no ongoing orders'),
                      ),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: ongoingOrders.length,
                    itemBuilder: (context, index) {
                      var item = ongoingOrders[index];
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          height: 350,
                          decoration: BoxDecoration(
                            gradient: new LinearGradient(
                              colors: [kPrimaryColor, kSecondaryColor],
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Order ${index + 1}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'Cabin'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Item Name',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          fontFamily: 'Cabin'),
                                    ),
                                    Text(
                                      'Quantity',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          fontFamily: 'Cabin'),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  height: 100,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: item.itemsName.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              item.itemsName[index],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  fontFamily: 'Cabin'),
                                            ),
                                            Text(
                                              item.itemsQty[index].toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  fontFamily: 'Cabin'),
                                            )
                                          ],
                                        );
                                      }),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      child: Divider(
                                        color: Colors.white,
                                        thickness: 0.8,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Order Status',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Cabin'),
                                        ),
                                        Text(
                                          ' ${item.status}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Cabin'),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Order placed at',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Cabin'),
                                        ),
                                        Text(
                                          ' ${item.dateTime}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Cabin'),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Order shipped',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Cabin'),
                                        ),
                                        Text(
                                          ' ${item.shippedTime}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Cabin'),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Order Completed',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Cabin'),
                                        ),
                                        Text(
                                          ' ${item.completedTime}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Cabin'),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Order Amount',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Cabin'),
                                        ),
                                        Text(
                                          'Rs. ${item.orderAmount.toStringAsFixed(2)}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Cabin'),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
            pastOrders.length == 0
                ? SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Text('You have no completed orders'),
                      ),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: pastOrders.length,
                    itemBuilder: (context, index) {
                      var item = pastOrders[index];
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          height: 350,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Order ${index + 1}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          fontFamily: 'Cabin'),
                                    ),
                                    SizedBox(height: 2),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Have an issue with this order?  ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              fontFamily: 'Cabin'),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => IssuePage(
                                                  issueOrder: item,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Click here.',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                fontFamily: 'Cabin'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Item Name',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          fontFamily: 'Cabin'),
                                    ),
                                    Text(
                                      'Quantity',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          fontFamily: 'Cabin'),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: item.itemsName.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              item.itemsName[index],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  fontFamily: 'Cabin'),
                                            ),
                                            Text(
                                              item.itemsQty[index].toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  fontFamily: 'Cabin'),
                                            )
                                          ],
                                        );
                                      }),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: Divider(
                                          color: Colors.white,
                                          thickness: 0.8,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Order Status',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          ),
                                          Text(
                                            ' ${item.status}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Order placed at',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          ),
                                          Text(
                                            ' ${item.dateTime}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Order shipped',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          ),
                                          Text(
                                            ' ${item.shippedTime}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Order Completed',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          ),
                                          Text(
                                            ' ${item.completedTime}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Order Amount',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          ),
                                          Text(
                                            'Rs. ${item.orderAmount.toStringAsFixed(2)}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
            issueOrders.length == 0
                ? SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Text('You have not raised any complaints.'),
                      ),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: issueOrders.length,
                    itemBuilder: (context, index) {
                      var item = issueOrders[index];
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          height: 350,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Order ${index + 1}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          fontFamily: 'Cabin'),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Item Name',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          fontFamily: 'Cabin'),
                                    ),
                                    Text(
                                      'Quantity',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          fontFamily: 'Cabin'),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: item.itemsName.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              item.itemsName[index],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  fontFamily: 'Cabin'),
                                            ),
                                            Text(
                                              item.itemsQty[index].toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  fontFamily: 'Cabin'),
                                            )
                                          ],
                                        );
                                      }),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: Divider(
                                          color: Colors.white,
                                          thickness: 0.8,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Issue Status',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          ),
                                          Text(
                                            ' ${item.status}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Order placed at',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          ),
                                          Text(
                                            ' ${item.placedTime}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Order completed at',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          ),
                                          Text(
                                            ' ${item.completedTime}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Request made',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          ),
                                          Text(
                                            ' ${item.request}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Order Amount',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          ),
                                          Text(
                                            'Rs. ${item.orderAmount.toString()}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
          ],
        ),
      ),
    );
  }
}
