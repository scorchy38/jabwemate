import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jabwemate/e-commerce_module/Classes/Cart.dart';
import 'package:jabwemate/e-commerce_module/Classes/Constants.dart';
import 'package:jabwemate/e-commerce_module/Classes/DatabaseHelper.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';
//TODO:Razor Used
import 'OrdersPage.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Cart> cartItems = [];
  final dbHelper = DatabaseHelper.instance;
  final dbRef = FirebaseDatabase.instance.reference();
  FirebaseAuth mAuth = FirebaseAuth.instance;
  Razorpay _razorpay;

  TextEditingController nameController = new TextEditingController(text: '');
  TextEditingController numberController = new TextEditingController(text: '');
  TextEditingController addressController = new TextEditingController(text: '');
  TextEditingController zipController = new TextEditingController(text: '');
  final formKey = GlobalKey<FormState>();

  int newQty;

  void getAllItems() async {
    final allRows = await dbHelper.queryAllRows();
    cartItems.clear();
    allRows.forEach((row) => cartItems.add(Cart.fromMap(row)));
    setState(() {});
  }

  void updateItem(
      {int id, String name, String imgUrl, String price, int qty}) async {
    // row to update
    Cart item = Cart(id, name, imgUrl, price, qty);
    final rowsAffected = await dbHelper.update(item);
    Fluttertoast.showToast(msg: 'Updated', toastLength: Toast.LENGTH_SHORT);
    getAllItems();
  }

  void removeItem(String name) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.delete(name);
    getAllItems();
    Fluttertoast.showToast(
        msg: 'Removed from cart', toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void initState() {
    getAllItems();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    double pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      var item = cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: kWhiteColor,
                              border:
                                  Border.all(color: kPrimaryColor, width: 2.0),
                              boxShadow: [
                                BoxShadow(
                                    color: kPrimaryColor,
                                    blurRadius: 2.0,
                                    spreadRadius: 0.1)
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: pWidth * 0.2,
                                  child: Image.network(
                                    item.imgUrl,
                                    height: 70,
                                    width: 70,
                                  ),
                                ),
                                Container(
                                  width: pWidth * 0.4,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          item.productName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .title
                                              .copyWith(
                                                  color: kTextColor
                                                      .withOpacity(0.85),
                                                  fontSize: 18.0),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Price : ${item.price}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .button
                                              .copyWith(
                                                color: kTextColor
                                                    .withOpacity(0.65),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: pWidth * 0.3,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          if (item.qty == 1) {
                                            removeItem(item.productName);
                                          } else {
                                            newQty = item.qty - 1;
                                            updateItem(
                                                id: item.id,
                                                name: item.productName,
                                                imgUrl: item.imgUrl,
                                                price: item.price,
                                                qty: newQty);
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Icon(
                                            Icons.indeterminate_check_box,
                                            color: Colors.white,
                                            size: pWidth * 0.07,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            item.qty.toString(),
                                            style: TextStyle(
                                                fontFamily: 'Cabin',
                                                color: Colors.black,
                                                fontSize: 17),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          newQty = item.qty + 1;
                                          updateItem(
                                              id: item.id,
                                              name: item.productName,
                                              imgUrl: item.imgUrl,
                                              price: item.price,
                                              qty: newQty);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Icon(
                                            Icons.add_box,
                                            color: Colors.white,
                                            size: pWidth * 0.07,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          removeItem(item.productName);
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: kPrimaryColor,
                                          size: pWidth * 0.07,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 4.8,
                decoration: BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [kPrimaryColor, kSecondaryColor],
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: pWidth * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                cartItems.length == 0
                                    ? FittedBox(
                                        child: Text(
                                          "Order Total = Rs. ${(totalAmount() + (0.18 * totalAmount()) + 00).toStringAsFixed(2)}  ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Cabin',
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  40),
                                        ),
                                      )
                                    : FittedBox(
                                        child: Text(
                                          "Order Total = Rs. ${(totalAmount() + (0.18 * totalAmount()) + 40).toStringAsFixed(2)}  ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Cabin',
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  40),
                                        ),
                                      ),
                                FittedBox(
                                  child: Text(
                                    "Products Total = Rs. ${totalAmount()}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Cabin',
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                60),
                                  ),
                                ),
                                FittedBox(
                                  child: Text(
                                    "GST(18%) = Rs. ${(totalAmount() * 0.18).toStringAsFixed(2)}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Cabin',
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                60),
                                  ),
                                ),
                                cartItems.length == 0
                                    ? FittedBox(
                                        child: Text(
                                          "Delivery Charges = Rs. 0.00",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Cabin',
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  60),
                                        ),
                                      )
                                    : FittedBox(
                                        child: Text(
                                          "Delivery Charges = Rs. 40.0",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Cabin',
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  60),
                                        ),
                                      ),
                              ],
                            ),
                          ),
//                          SizedBox(
//                            width: MediaQuery.of(context).size.width * 0.1,
//                          ),
//                          Column(
//                            children: [
//                              InkWell(
//                                onTap: () {
//                                  onOrderPlaced();
//                                },
//                                child: Container(
//                                  decoration: BoxDecoration(
//                                    borderRadius: BorderRadius.all(
//                                      Radius.circular(10),
//                                    ),
//                                    color: Colors.white,
//                                  ),
//                                  width:
//                                      MediaQuery.of(context).size.width * 0.315,
//                                  child: Padding(
//                                    padding: const EdgeInsets.symmetric(
//                                        horizontal: 10, vertical: 10),
//                                    child: Text(
//                                      "PROCEED FOR COD",
//                                      style: TextStyle(
//                                          fontWeight: FontWeight.bold,
//                                          fontFamily: 'Cabin',
//                                          fontSize: MediaQuery.of(context)
//                                                  .size
//                                                  .height /
//                                              65,
//                                          color: kPrimaryColor),
//                                    ),
//                                  ),
//                                ),
//                              ),
//                              SizedBox(
//                                height: MediaQuery.of(context).size.height / 70,
//                              ),
//                              InkWell(
//                                onTap: () async {
//                                  await onOrderPlaced();
//                                  //   openCheckout();
//                                },
//                                child: Container(
//                                  decoration: BoxDecoration(
//                                    borderRadius: BorderRadius.all(
//                                      Radius.circular(10),
//                                    ),
//                                    color: Colors.white,
//                                  ),
//                                  width:
//                                      MediaQuery.of(context).size.width * 0.315,
//                                  child: Padding(
//                                    padding: const EdgeInsets.symmetric(
//                                        horizontal: 10, vertical: 7),
//                                    child: Center(
//                                      child: Text(
//                                        "PAY ONLINE",
//                                        style: TextStyle(
//                                            fontWeight: FontWeight.bold,
//                                            fontFamily: 'Cabin',
//                                            fontSize: MediaQuery.of(context)
//                                                    .size
//                                                    .height /
//                                                55,
//                                            color: kPrimaryColor),
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 80,
                      ),
                      InkWell(
                        onTap: () {
                          Alert(
                              context: context,
                              title: "PROCEED TO CHECKOUT",
                              content: Form(
                                key: formKey,
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      validator: (value) {
                                        if (value.length == 0) {
                                          return 'Please enter your name';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: nameController,
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.account_circle),
                                        labelText: 'Name',
                                      ),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Please enter a valid phone number';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: numberController,
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.phone_iphone),
                                        labelText: 'Contact Number',
                                      ),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value.length == 0) {
                                          return 'Please enter your address';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: addressController,
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.home),
                                        labelText: 'Address',
                                      ),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value.length < 6) {
                                          return 'Please enter a valid pin code';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: zipController,
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.location_on),
                                        labelText: 'PIN Code',
                                      ),
                                    ),
                                    SizedBox(
                                      height: pWidth * 0.05,
                                    ),
                                    Text(
                                      "Order Total : Rs. ${(totalAmount() + (0.18 * totalAmount()) + 00).toStringAsFixed(2)}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Cabin',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              50,
                                          color: kPrimaryColor),
                                    )
                                  ],
                                ),
                              ),
                              buttons: [
                                DialogButton(
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                                      Navigator.pop(context);
                                      onOrderPlaced();
                                    }
                                  },
                                  color: kPrimaryColor,
                                  child: Text(
                                    "PROCEED FOR COD",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Cabin',
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                70,
                                        color: Colors.white),
                                  ),
                                ),
                                DialogButton(
                                  onPressed: () async {
                                    if (formKey.currentState.validate()) {
                                      //openCheckout();
                                      Navigator.pop(context);
                                      onOrderPlaced();
                                    }
                                  },
                                  color: kPrimaryColor,
                                  child: Text(
                                    "PAY ONLINE",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Cabin',
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                70,
                                        color: Colors.white),
                                  ),
                                )
                              ]).show();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.height - 20,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Text(
                                "PROCEED TO CHECKOUT",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cabin',
                                    fontSize:
                                        MediaQuery.of(context).size.height / 50,
                                    color: kPrimaryColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onOrderPlaced() async {
    List<String> item = [];
    List<int> qty = [];
    double orderAmount = (totalAmount() + (0.18 * totalAmount()) + 40);

    for (int i = 0; i < cartItems.length; i++) {
      item.add(cartItems[i].productName);
      qty.add(cartItems[i].qty);
    }

    FirebaseUser user = await mAuth.currentUser();

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy  kk:mm').format(now);

    dbRef
        .child('Orders')
        .child(user.uid)
        .child(TimeOfDay.now().toString())
        .set({
      "itemsName": item,
      "itemsQty": qty,
      'orderAmount': orderAmount,
      'isCompleted': false,
      'DateTime': formattedDate,
      'CompletedTime': 'Not yet completed',
      'ShippedTime': 'Not yet shipped',
      'Status': 'Placed',
      'orderLength': item.length,
      'userName': nameController.text,
      'userAddress': addressController.text,
      'userPhone': numberController.text,
      'pinCode': zipController.text
    });

    numberController.clear();
    nameController.clear();
    zipController.clear();
    addressController.clear();

    print('Order Placed');

    for (int i = 0; i < cartItems.length; i++) {
      removeItem(cartItems[i].productName);
    }

    Alert(
      context: context,
      type: AlertType.success,
      title: "Order Placed",
      desc: "Your order has been placed successfully.",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => OrdersPage(),
            ),
          ),
          width: 120,
        )
      ],
    ).show();
  }

  double totalAmount() {
    double sum = 0;
    getAllItems();
    for (int i = 0; i < cartItems.length; i++) {
      sum += (double.parse(cartItems[i].price) * cartItems[i].qty);
    }
    return sum;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void openCheckout() async {
    var options = {
      'key': 'abc',
      'amount': ((totalAmount() + 0.18 * totalAmount() + 40) * 100).toString(),
      'name': 'Axact Studios',
      'description': 'Bill',
      'prefill': {'contact': '', '': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
    onOrderPlaced();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }
}
