import 'package:admin/screens/Account/components/uppermenu.dart';
import 'package:admin/screens/WalkInPanel/walkIn_generateSeats.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:admin/services/database.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../../globals.dart';

final DatabaseService db = DatabaseService();

class WalkInPassengerForm extends StatefulWidget {
  const WalkInPassengerForm({Key key}) : super(key: key);

  @override
  _WalkInPassengerFormState createState() => _WalkInPassengerFormState();
}

class _WalkInPassengerFormState extends State<WalkInPassengerForm> {
  final List<GlobalKey<FormState>> formKeyList =
      List.generate(seatCounter, (index) => GlobalKey<FormState>());

  void discountIDNotVerifiedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            "\nYour discount ID is not yet verified. To verify, kindly go first to the terminal and present your ID to the clerk.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
            ),
          ),
          elevation: 30.0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          actions: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(70.0, 5.0),
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.white),
                        ),
                      ),
                      child: Text(
                        "OK",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.1,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> getDiscount() async {
    String tempUID;
    for (int i = 0; i < passengerType.length; i++) {
      var result = await FirebaseFirestore.instance
          .collection('$company' + "_priceCategories")
          .where('category', isEqualTo: passengerType[i])
          .get();
      result.docs.forEach((val) {
        tempUID = val.id;
      });
      var dbResult = await FirebaseFirestore.instance
          .collection('$company' + "_priceCategories")
          .doc(tempUID)
          .get();
      setState(() {
        listDiscount.insert(i, dbResult.get('discount'));
      });
    }
    print('List Discount - ' + listDiscount.toString());

    Navigator.push(context,
            MaterialPageRoute(builder: (context) => WalkInGenerateSeats()))
        .then((value) {
      setState(() {});
    });
  }

  Future<void> getListRightSeat() async {
    walkInRightSeatList.clear();
    final CollectionReference busCollection =
        FirebaseFirestore.instance.collection('$company' + '_trips');

    var docSnapshot = await busCollection.doc(selectedTripID).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      walkInRightSeatList = List.from(data['List Right Seat']);
    }
  }

  Future<void> getListLeftSeatList() async {
    walkInListLeftSeat.clear();
    final CollectionReference busCollection =
        FirebaseFirestore.instance.collection('$company' + '_trips');

    var docSnapshot = await busCollection.doc(selectedTripID).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      walkInListLeftSeat = List.from(data['List Left Seat']);
    }
  }

  Future<void> getLeftSeatStatus() async {
    walkInLeftSeatStatus.clear();
    final CollectionReference busCollection =
        FirebaseFirestore.instance.collection('$company' + '_trips');

    var docSnapshot = await busCollection.doc(selectedTripID).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      walkInLeftSeatStatus = List.from(data['Left Seat Status']);
    }
  }

  Future<void> getRightSeatStatus() async {
    walkInRightSeatStatus.clear();
    final CollectionReference busCollection =
        FirebaseFirestore.instance.collection('$company' + '_trips');

    var docSnapshot = await busCollection.doc(selectedTripID).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      walkInRightSeatStatus = List.from(data['Right Seat Status']);
    }
  }

  Future<void> getRowColSize() async {
    final CollectionReference busCollection =
        FirebaseFirestore.instance.collection('$company' + '_bus');

    var docSnapshot = await busCollection.doc(busDocID).get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      leftColSize = data['Left Col Size'];
      leftRowSize = data['Left Row Size'];
      rightColSize = data['Right Col Size'];
      rightRowSize = data['Right Row Size'];
      bottomColSize = data['Bottom Col Size'];
    }
  }

  Future<void> getListBottomSeat() async {
    walkInListBottomSeat.clear();
    final CollectionReference busCollection =
        FirebaseFirestore.instance.collection('$company' + '_trips');

    var docSnapshot = await busCollection.doc(selectedTripID).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      walkInListBottomSeat = List.from(data['List Bottom Seat']);
    }
  }

  Future<void> getBottomSeatStatus() async {
    walkInBottomSeatStatus.clear();
    final CollectionReference busCollection =
        FirebaseFirestore.instance.collection('$company' + '_trips');

    var docSnapshot = await busCollection.doc(selectedTripID).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      walkInBottomSeatStatus = List.from(data['Bottom Seat Status']);
    }
  }

  void generateDropdownItem() {
    seatsName.clear();
    seatsName = [walkInListLeftSeat, walkInRightSeatList, walkInListBottomSeat]
        .expand((x) => x)
        .toList();

    seatsNameStatus.clear();
    seatsNameStatus = [
      walkInLeftSeatStatus,
      walkInRightSeatStatus,
      walkInBottomSeatStatus
    ].expand((x) => x).toList();

    seatNameDropdownItem.clear();
    for (int i = 0; i < seatsName.length; i++) {
      if (seatsNameStatus[i].toString() == 'true') {
        seatNameDropdownItem.add(seatsName[i].toString());
      }
    }
    print('Seat Name All True: ' + seatNameDropdownItem.toString());
  }

  @override
  Widget build(BuildContext context) {
    baseFare = double.parse(selectedPriceDetails);
    percentageDiscount = 0;
    selectedPercentageDiscount = 0;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Container(
                child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: seatCounter,
                    separatorBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(height: defaultPadding),
                          SizedBox(height: defaultPadding),
                        ],
                      );
                    },
                    itemBuilder: (context, index) {
                      print('FormKey ' +
                          '$index : ' +
                          formKeyList[index].toString());
                      print('Seat Counter: ' + '$index');
                      return Container(
                        padding: EdgeInsets.all(defaultPadding),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Form(
                            key: formKeyList[index],
                            child: Column(
                              children: [
                                SizedBox(height: defaultPadding),
                                Text(
                                  "Passenger " + (index + 1).toString(),
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                SizedBox(height: defaultPadding),
                                //passenger category
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection(
                                            '$company' + '_priceCategories')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CupertinoActivityIndicator(),
                                        );
                                      } else {
                                        return DropdownButtonFormField(
                                          value: selectedPassengerCategory,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Select a field';
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.all(defaultPadding),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    0, 189, 56, 1.0),
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red
                                                      .withOpacity(0.8)),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red
                                                      .withOpacity(0.8)),
                                            ),
                                          ),
                                          isExpanded: true,
                                          isDense: true,
                                          //iconSize: 5 * SizeConfig.imageSizeMultiplier,
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.white,
                                            size: 10,
                                          ),
                                          hint: Text(
                                            "Passenger",
                                            style: TextStyle(
                                              color: Colors.white38,
                                              fontFamily: 'Poppins',
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          onChanged: (val) async {
                                            print('Passenger Type ' +
                                                '$index' +
                                                ': ' +
                                                '$val');

                                            String tempUID;
                                            var result = await FirebaseFirestore
                                                .instance
                                                .collection('$company' +
                                                    "_priceCategories")
                                                .where('category',
                                                    isEqualTo: val)
                                                .get();

                                            result.docs.forEach((val) {
                                              tempUID = val.id;
                                            });

                                            var dbResult =
                                                await FirebaseFirestore.instance
                                                    .collection('$company' +
                                                        "_priceCategories")
                                                    .doc(tempUID)
                                                    .get();
                                            setState(() {
                                              discount = dbResult['discount'];
                                              tempDiscount.insert(
                                                  index, discount);
                                            });
                                            print('Discount ' +
                                                '$index' +
                                                ': ' +
                                                discount);
                                            print('Discount List ' +
                                                '$index' +
                                                ': ' +
                                                tempDiscount[index]);
                                          },
                                          onSaved: (val) {
                                            passengerType.insert(index, val);
                                          },
                                          items: snapshot.data.docs
                                              .map((DocumentSnapshot docs) {
                                            return new DropdownMenuItem<String>(
                                              value: docs['category'],
                                              child: new Text(
                                                docs['category'].toUpperCase(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      }
                                    }),
                                SizedBox(height: defaultPadding),
                                //first name
                                TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  //controller: _passengerFname,
                                  keyboardType: TextInputType.name,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "Please enter your first name";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (val) {
                                    setState(() {
                                      passengerFirstName.insert(index, val);
                                    });
                                  },
                                  onTap: () {
                                    InputDecoration(
                                      hintText: 'First Name',
                                      hintStyle: TextStyle(
                                        color: Colors.white38,
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    );
                                  },
                                  style: Theme.of(context).textTheme.subtitle1,
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                    labelStyle: TextStyle(
                                      color: Colors.white38,
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    contentPadding:
                                        EdgeInsets.all(defaultPadding),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.8)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(0, 189, 56, 1.0)),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red.withOpacity(0.8)),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red.withOpacity(0.8)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: defaultPadding),
                                //last name
                                TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  //controller: _passengerLname,
                                  keyboardType: TextInputType.name,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "Please enter your last name";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (val) {
                                    setState(() {
                                      passengerLastName.insert(index, val);
                                    });
                                  },
                                  onTap: () {
                                    InputDecoration(
                                      hintText: 'Last Name',
                                      hintStyle: TextStyle(
                                        color: Colors.white38,
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    );
                                  },
                                  style: Theme.of(context).textTheme.subtitle1,
                                  decoration: InputDecoration(
                                    labelText: 'Last Name',
                                    labelStyle: TextStyle(
                                      color: Colors.white38,
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    contentPadding:
                                        EdgeInsets.all(defaultPadding),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.8)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(0, 189, 56, 1.0)),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red.withOpacity(0.8)),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red.withOpacity(0.8)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: defaultPadding),
                                //email
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  //controller: _passengerEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "Please enter an email address";
                                    } else if (!RegExp(
                                            "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                        .hasMatch(value)) {
                                      return "Please enter a valid email address";
                                    } else {
                                      return null;
                                    }
                                  },

                                  onSaved: (val) {
                                    setState(() {
                                      passengerEmailAddress.insert(index, val);
                                    });
                                  },
                                  onTap: () {
                                    InputDecoration(
                                      hintText: 'Email Address',
                                      hintStyle: TextStyle(
                                        color: Colors.white38,
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    );
                                  },
                                  style: Theme.of(context).textTheme.subtitle1,
                                  decoration: InputDecoration(
                                    labelText: 'Email Address',
                                    labelStyle: TextStyle(
                                      color: Colors.white38,
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    contentPadding:
                                        EdgeInsets.all(defaultPadding),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.8)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(0, 189, 56, 1.0)),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red.withOpacity(0.8)),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red.withOpacity(0.8)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: defaultPadding),
                                //mobile number
                                TextFormField(
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(11),
                                  ],
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  //controller: _passengerMobileNum,
                                  keyboardType: TextInputType.number,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "Please enter a mobile number";
                                    } else if (value.length != 11) {
                                      return "Enter eleven digits";
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: Theme.of(context).textTheme.subtitle1,
                                  onSaved: (val) {
                                    setState(() {
                                      passengerMobileNum.insert(index, val);
                                    });
                                  },
                                  onTap: () {
                                    InputDecoration(
                                      hintText: 'Mobile Number',
                                      hintStyle: TextStyle(
                                        color: Colors.white38,
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    );
                                  },
                                  decoration: InputDecoration(
                                    hintText: '09xxxxxxxxx',
                                    hintStyle: TextStyle(
                                      color: Colors.white38,
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    labelText: 'Mobile Number',
                                    labelStyle: TextStyle(
                                      color: Colors.white38,
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    contentPadding:
                                        EdgeInsets.all(defaultPadding),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.8)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(0, 189, 56, 1.0)),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red.withOpacity(0.8)),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red.withOpacity(0.8)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: defaultPadding),
                                SizedBox(height: defaultPadding),
                                //discount id note
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 7.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '*This field is required to apply discount. If none, kindly leave the Discount ID blank.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: defaultPadding),
                                //discount id
                                TextFormField(
                                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                                  //controller: _passengerDiscountID,
                                  keyboardType: TextInputType.name,
                                  // validator: (String value) {
                                  //   if (value.isEmpty) {
                                  //     return "Please enter your discount ID";
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                  onSaved: (val) {
                                    if (val.isEmpty) {
                                      val = 'None';
                                      passengerDiscountID.insert(index, val);
                                    } else {
                                      passengerDiscountID.insert(index, val);
                                    }
                                  },
                                  onTap: () {
                                    InputDecoration(
                                      hintText: 'Discount ID',
                                      hintStyle: TextStyle(
                                        color: Colors.white38,
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    );
                                  },
                                  style: Theme.of(context).textTheme.subtitle1,
                                  decoration: InputDecoration(
                                    labelText: 'Discount ID',
                                    labelStyle: TextStyle(
                                      color: Colors.white38,
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    contentPadding:
                                        EdgeInsets.all(defaultPadding),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.8)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(0, 189, 56, 1.0)),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red.withOpacity(0.8)),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red.withOpacity(0.8)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: defaultPadding),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            SizedBox(height: defaultPadding),
            SizedBox(height: defaultPadding),
            ElevatedButton(
              onPressed: () async {
                passengerType.clear();
                passengerFirstName.clear();
                passengerLastName.clear();
                passengerEmailAddress.clear();
                passengerMobileNum.clear();
                listDiscount.clear();
                passengerDiscountID.clear();
                eachSubTotal.clear();
                eachDiscount.clear();
                List<bool> validateForm = [];
                for (int i = 0; i < formKeyList.length; i++) {
                  formKeyList[i].currentState.save();
                  if (formKeyList[i].currentState.validate()) {
                    validateForm.insert(
                        i, formKeyList[i].currentState.validate());
                  } else {
                    validateForm.insert(i, false);
                  }
                }
                var valFormRes =
                    validateForm.every((element) => element == true);
                print('Validate - ' + validateForm.toString());
                print('Validate Form Result - ' + '$valFormRes');

                if (valFormRes == true) {
                  int checker = 0;
                  for (int i = 0; i < formKeyList.length; i++) {
                    if (passengerType[i] != 'ADULT') {
                      var result = await FirebaseFirestore.instance
                          .collection('all_discountIDs')
                          .where('discount ID',
                              isEqualTo: passengerDiscountID[i])
                          .where('category',
                              isEqualTo:
                                  passengerType[i].toString().toLowerCase())
                          .where('email', isEqualTo: passengerEmailAddress[i])
                          .where('full name',
                              isEqualTo: passengerFirstName[i]
                                      .toString()
                                      .toLowerCase() +
                                  ' ' +
                                  passengerLastName[i].toString().toLowerCase())
                          .get();
                      if (result.docs.length == 0) {
                        discountIDNotVerifiedDialog();
                        break;
                      } else {
                        checker++;
                      }
                    } else {
                      checker++;
                    }
                  }

                  if (checker == formKeyList.length) {
                    print('Seat Counter - ' + '$seatCounter');
                    valueList = List.generate(seatCounter, (index) => null);
                    print('Value List - ' + valueList.toString());
                    await getListLeftSeatList();
                    await getLeftSeatStatus();
                    await getRightSeatStatus();
                    await getRowColSize();
                    await getListBottomSeat();
                    await getBottomSeatStatus();
                    await getListRightSeat();
                    generateDropdownItem();
                    getDiscount();
                  }
                } else {
                  print('Validate Form Result - ' + '$valFormRes');
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(50, 30),
                primary: primaryColor,
              ),
              child: Text(
                'Next',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            SizedBox(height: defaultPadding),
            SizedBox(height: defaultPadding),
          ],
        ),
      ),
    );
  }
}
