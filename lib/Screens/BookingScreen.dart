import 'package:flutter/material.dart';
import 'package:jabwemate/Classes/Doc_data.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:jabwemate/Classes/Doc_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Making list for all time slots
class TimeSlotDrop {
  String from, to, available;
  int index;
  TimeSlotDrop({this.from, this.to, this.available, this.index});
}

TimeSlotDrop _selectedSlot;

dynamic currentTime;

String docName = "", docDegree = "";
int selIndex = 0;

class LoginFormBloc extends FormBloc<String, String> {
  final ownerName = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final dogName = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final dogBreed = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final dogAge = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final ownerEmail = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.email,
    ],
  );

  final ownerPhone = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final ownerAddress = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  LoginFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        ownerName,
        dogName,
        dogBreed,
        dogAge,
        ownerEmail,
        ownerPhone,
        ownerAddress,
      ],
    );
  }

  final appointmentdatabaseReference = Firestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onSubmitting() async {
    FirebaseUser user = await _auth.currentUser();
    currentTime = DateFormat.jm().format(DateTime.now());

    appointmentdatabaseReference
        .collection("DoctorAppointment")
        .document()
        .setData({
      "ownerName": ownerName.value,
      "dogName": dogName.value,
      "dogBreed": dogBreed.value,
      "dogAge": dogAge.value,
      "ownerEmail": ownerEmail.value,
      "ownerPhone": ownerPhone.value,
      "patientUID": user.uid,
      "doctorUID": "Randomly Generate",
      "docName": docName,
      "status": "Booked",
      "docDegree": docDegree,
      "timeSlot": _selectedSlot.from + " - " + _selectedSlot.to,
      "bookingTime": currentTime,
    });

    // Firestore.instance
    //     .collection("Doctors")
    //     .getDocuments()
    //     .then((QuerySnapshot snapshot) {
    //   snapshot.documents.forEach((doc) {
    //     if (doc['name'] == docName && doc['address'] == docAddress) {
    //       print(doc['ID']);
    //       //print(doc['TimeSlots'][selIndex]['Available']);
    //       //doc['TimeSlots'][selIndex]['Available'] = "No";
    //       Firestore.instance
    //           .collection("Doctors")
    //           .document(doc['ID'])
    //           .updateData({
    //         'cost': 10
    //         // "TimeSlots":FieldValue.arrayUnion({"Available": "No"})
    //       });
    //     }
    //   });
    // });

    print(ownerName.value);
    print(dogName.value);
    print(dogBreed.value);
    print(dogAge.value);
    print(ownerEmail.value);
    print(ownerPhone.value);
    print(ownerAddress.value);
    print(_selectedSlot.from + " - " + _selectedSlot.to);
    await Future<void>.delayed(Duration(seconds: 1));
  }
}

class BookingScreen extends StatefulWidget {
  final Docpro docpro;
  BookingScreen(this.docpro);
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  int index = 0;

  List<DropdownMenuItem<TimeSlotDrop>> _dropdownMenuItems;
  List<TimeSlotDrop> dropdownArr = new List<TimeSlotDrop>();

  void copyTimeList() {
    List.from(widget.docpro.slots).forEach((element) {
      TimeSlotDrop newTime = TimeSlotDrop(
        from: element.from,
        to: element.to,
        available: element.available,
        index: index + 1,
      );
      dropdownArr.add(newTime);
    });
  }

  @override
  void initState() {
    copyTimeList();
    _dropdownMenuItems = buildDropdownMenuItems(dropdownArr);
    _selectedSlot = _dropdownMenuItems[0].value;
    docName = widget.docpro.name;
    docDegree = widget.docpro.degree;
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  List<DropdownMenuItem<TimeSlotDrop>> buildDropdownMenuItems(List slots) {
    List<DropdownMenuItem<TimeSlotDrop>> items = List();
    for (TimeSlotDrop slot in slots) {
      if (slot.available == "Yes") {
        items.add(
          DropdownMenuItem(
            value: slot,
            child: Text(slot.from + " - " + slot.to),
          ),
        );
      }
    }
    return items;
  }

  onChangeDropdownItem(TimeSlotDrop selectedSlot) {
    setState(() {
      _selectedSlot = selectedSlot;
      selIndex = selectedSlot.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    final pWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => LoginFormBloc(),
      child: Builder(
        builder: (context) {
          final loginFormBloc = context.bloc<LoginFormBloc>();

          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(title: Text('Book Appointment')),
              body: FormBlocListener<LoginFormBloc, String, String>(
                onSubmitting: (context, state) {
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (_) => DocMainScreen()));
                  Navigator.of(context).pop();
                },
                onSuccess: (context, state) {
                  print("Successfully Booked");
                },
                onFailure: (context, state) {
                  LoadingDialog.hide(context);

                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(state.failureResponse)));
                },
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 4),
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.all(7),
                            child: Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Stack(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, top: 5),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: RichText(
                                                    text: TextSpan(
                                                      text: widget.docpro.name,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 20),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: '\n' +
                                                                widget.docpro
                                                                    .degree,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: RichText(
                                                    text: TextSpan(
                                                      text: 'Rs. ' +
                                                          widget.docpro.cost
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.green,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        RichText(
                                                          textAlign:
                                                              TextAlign.left,
                                                          text: TextSpan(
                                                            text: '\n' +
                                                                widget.docpro
                                                                    .specs,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 22,
                                                            ),
                                                            children: <
                                                                TextSpan>[
                                                              TextSpan(
                                                                text: '\n' +
                                                                    widget
                                                                        .docpro
                                                                        .address,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
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
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                        child: TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.ownerName,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Your Name',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                        child: TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.dogName,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Dog's Name",
                            prefixIcon: Icon(Icons.pets),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                        child: TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.dogBreed,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Dog's Breed",
                            prefixIcon: Icon(Icons.mood),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                        child: TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.dogAge,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Dog's Age",
                            prefixIcon: Icon(Icons.looks_one),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                        child: TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.ownerEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                        child: TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.ownerPhone,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                        child: TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.ownerAddress,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Address",
                            prefixIcon: Icon(Icons.home),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 18, 0, 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Select a Slot",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            DropdownButton(
                              value: _selectedSlot,
                              items: _dropdownMenuItems,
                              onChanged: onChangeDropdownItem,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text('Selected: ${_selectedSlot.from}'),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => loginFormBloc.onSubmitting(),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                          child: RaisedButton(
                            padding: const EdgeInsets.fromLTRB(80, 15, 80, 15),
                            textColor: Colors.white,
                            color: Colors.blue,
                            onPressed: loginFormBloc.submit,
                            child: Text(
                              "Book",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
