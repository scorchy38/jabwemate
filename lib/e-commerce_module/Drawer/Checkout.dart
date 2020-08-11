import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jabwemate/e-commerce_module/Classes/Cart.dart';
import 'package:intl/intl.dart';
import 'package:jabwemate/e-commerce_module/Classes/Constants.dart';
import 'package:jabwemate/e-commerce_module/Classes/DatabaseHelper.dart';
import 'package:jabwemate/e-commerce_module/OtherPages/OrdersPage.dart';
import 'package:jabwemate/style/theme.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CheckOut extends StatefulWidget {
  List<Cart> cartItems;
  CheckOut({this.cartItems});

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  TextEditingController nameController = new TextEditingController(text: '');
  TextEditingController numberController = new TextEditingController(text: '');
  TextEditingController addressController = new TextEditingController(text: '');
  TextEditingController addressController2 =
      new TextEditingController(text: '');
  TextEditingController zipController = new TextEditingController(text: '');
  final formKey = GlobalKey<FormState>();
  final dbRef = FirebaseDatabase.instance.reference();
  final dbHelper = DatabaseHelper.instance;
  Razorpay _razorpay;

  double totalAmount() {
    double sum = 0;
    for (int i = 0; i < widget.cartItems.length; i++) {
      sum +=
          (double.parse(widget.cartItems[i].price) * widget.cartItems[i].qty);
    }
    return sum;
  }

  void removeItem(String name) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.delete(name);
    Fluttertoast.showToast(
        msg: 'Removed from cart', toastLength: Toast.LENGTH_SHORT);
  }

  Future<void> onOrderPlaced(BuildContext context) async {
    List<String> item = [];
    List<int> qty = [];
    double orderAmount = (totalAmount() + (0.18 * totalAmount()) + 40);

    for (int i = 0; i < widget.cartItems.length; i++) {
      item.add(widget.cartItems[i].productName);
      qty.add(widget.cartItems[i].qty);
    }

    FirebaseUser user = await FirebaseAuth.instance.currentUser();

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
    });

    dbRef.child('Users').child(user.uid).set({
      "Name": nameController.text,
      "Add1": addressController.text,
      'Add2': addressController2.text,
      'Zip': zipController.text,
      'phNo': numberController.text
    });

    numberController.clear();
    nameController.clear();
    zipController.clear();
    addressController.clear();

    print('Order Placed');

    for (int i = 0; i < widget.cartItems.length; i++) {
      removeItem(widget.cartItems[i].productName);
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
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => OrdersPage(),
              ),
            );
          },
          width: 120,
        )
      ],
    ).show();
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    double pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "CHECKOUT",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cabin',
                    fontSize: MediaQuery.of(context).size.height / 30,
                    color: MyColors.loginGradientEnd),
              ),
              SizedBox(
                height: pWidth * 0.1,
              ),
              TextFormField(
                validator: (value) {
                  if (value.length == 0) {
                    return 'Please enter a valid name';
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
              SizedBox(
                height: pWidth * 0.05,
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
              SizedBox(
                height: pWidth * 0.05,
              ),
              TextFormField(
                validator: (value) {
                  if (value.length == 0) {
                    return 'Please enter a valid address';
                  } else {
                    return null;
                  }
                },
                controller: addressController,
                decoration: InputDecoration(
                  icon: Icon(Icons.home),
                  labelText: 'Address Line 1',
                ),
              ),
              SizedBox(
                height: pWidth * 0.05,
              ),
              TextFormField(
                validator: (value) {
                  if (value.length == 0) {
                    return 'Please enter a valid address';
                  } else {
                    return null;
                  }
                },
                controller: addressController2,
                decoration: InputDecoration(
                  icon: Icon(Icons.location_city),
                  labelText: 'Address Line 2',
                ),
              ),
              SizedBox(
                height: pWidth * 0.05,
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
                    fontSize: MediaQuery.of(context).size.height / 50,
                    color: kPrimaryColor),
              ),
              SizedBox(
                height: pWidth * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DialogButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        onOrderPlaced(context);
                      }
                    },
                    color: kPrimaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "PROCEED FOR COD",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cabin',
                            fontSize: MediaQuery.of(context).size.height / 70,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: pWidth * 0.05,
                  ),
                  DialogButton(
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        openCheckout();
                      }
                    },
                    color: kPrimaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "PAY ONLINE",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cabin',
                            fontSize: MediaQuery.of(context).size.height / 70,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_uqORQiidCVwzWI',
      'amount': ((totalAmount() + 0.18 * totalAmount() + 40) * 100),
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
    onOrderPlaced(context);
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
