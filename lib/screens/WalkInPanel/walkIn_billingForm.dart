import 'package:admin/routes/routeName.dart';
import 'package:admin/screens/AddBusPanel/components/bus_status.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import '../../constants.dart';
import '../../globals.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;
import 'package:dotted_line/dotted_line.dart';

import '../../responsive.dart';

class WalkInBillingForm extends StatefulWidget {
  const WalkInBillingForm({Key key}) : super(key: key);

  @override
  _WalkInBillingFormState createState() => _WalkInBillingFormState();
}

class _WalkInBillingFormState extends State<WalkInBillingForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> cashAmountFormKey = GlobalKey<FormState>();

  //passenger type
  var mapPassengerType = Map();
  List passengerTypeCount = [];

  //passenger type discount
  var mapPassengerTypeDiscount = Map();
  List passengerTypeDiscountList = [];
  int ticketCounter = 0;

  double cashAmount = 0;

  void computeEachDiscount() {
    eachSubTotal.clear();
    eachDiscount.clear();
    for (int i = 0; i < listDiscount.length; i++) {
      var discountTemp =
          baseFare * (int.parse(listDiscount[i].toString()) / 100);
      eachDiscount.insert(i, discountTemp.toStringAsFixed(0));
      var temp = baseFare - discountTemp;
      eachSubTotal.add(temp.toStringAsFixed(0));
    }
    print('Each Subtotal - ' + eachSubTotal.toString());
    print('Each Discount - ' + eachDiscount.toString());
  }

  void computeTotalDiscount() {
    totalDiscount = 0;
    for (int i = 0; i < eachDiscount.length; i++) {
      totalDiscount += int.parse(eachDiscount[i].toString());
    }
    print('Total Discount: ' + totalDiscount.toStringAsFixed(2));
  }

  void getTotalPrice() {
    for (int i = 0; i < eachSubTotal.length; i++) {
      totalPrice = totalPrice + double.parse(eachSubTotal[i]);
    }
  }

  void generateTicketID() {
    print(selectedCounter);
    ticketCounter = 0;
    ticketCounter = int.parse(selectedCounter);
    ticketIDList.clear();
    DateTime dateFormat = DateTime.parse(selectedDepartureDate);
    String dateFormatter = DateFormat('MMddy').format(dateFormat).toString();
    DateTime timeFormat = DateTime.parse(selectedDepartureTime);
    String timeFormatter = DateFormat('HHmm').format(timeFormat).toString();

    for (int i = 0; i < selectedSeats.length; i++) {
      ticketIDList.add(dateFormatter +
          timeFormatter +
          '-' +
          ticketCounter.toString() +
          '$company'.toUpperCase() +
          selectedBusCode +
          '-' +
          selectedSeats[i]);
      ticketCounter++;
    }
    print('Ticket ID ' + ticketIDList.toString());
  }

  var distinctPassengerType = passengerType.toSet().toList();

  Future<void> getListRightSeat() async {
    walkInRightSeatList.clear();
    final CollectionReference busCollection =
        FirebaseFirestore.instance.collection('$company' + '_trips');

    var docSnapshot = await busCollection.doc(selectedTripID).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      walkInRightSeatList = List.from(data['List Right Seat']);
    }
    // Navigator.of(context).pop();
    //Navigator.popAndPushNamed(context, '/chooseSeats', (Route<dynamic> route) => true));
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
        FirebaseFirestore.instance.collection('$company' + '_trips');

    //var docSnapshot = await busCollection.doc(busDocID).get();
    var docSnapshot = await busCollection.doc(selectedTripID).get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      leftColSize = data['Left Col Size'];
      leftRowSize = data['Left Row Size'];
      rightColSize = data['Right Col Size'];
      rightRowSize = data['Right Row Size'];
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

  Future<void> showPDf(pdf) async {
    final bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, '_blank');
    html.Url.revokeObjectUrl(url);
  }

  Future<void> downloadPDF(tempFirstName, tempLastName, pdf) async {
    final bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement()
      ..href = url
      ..style.display = 'none'
      ..download = tempFirstName +
          '_' +
          tempLastName +
          '_ticket'
              '.pdf';
    html.document.body?.children?.add(anchor);
    anchor.click();
    html.document.body?.children?.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  Future<void> downloadInvoicePDF(
      getTempTicket,
      tempFirstName,
      tempLastName,
      tempEmail,
      tempSeatNumber,
      tempPassengerType,
      tempPercentageDiscount,
      tempSubTotal,
      tempDiscount) async {
    double tempDiscountDouble = double.parse(tempDiscount.toString());
    double tempSubTotalDouble = double.parse(tempSubTotal.toString());
    double ticketTotalPrice =
        double.parse(tempSubTotal) - double.parse(tempDiscount);
    //Change date format
    DateTime tempDate =
        new DateFormat("yyyy-MM-dd HH:mm:ss").parse(selectedDepartureDate);
    String ticketDate = DateFormat('MMMM-dd-yyyy').format(tempDate);
    //Change time format
    DateTime tempTime =
        new DateFormat("yyyy-MM-dd HH:mm:ss").parse(selectedDepartureTime);
    String ticketTime = DateFormat('h:mm a').format(tempTime);
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  '$company'.toUpperCase(),
                  style: pw.TextStyle(),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  "TICKET",
                  style: pw.TextStyle(),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(),
                child: pw.Divider(),
              ),
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        selectedOrigin.toUpperCase(),
                        style: pw.TextStyle(),
                      ),
                    ),
                    pw.Align(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'to',
                        style: pw.TextStyle(),
                      ),
                    ),
                    pw.Align(
                      alignment: pw.Alignment.centerRight,
                      child: pw.Text(
                        selectedDestination.toUpperCase(),
                        style: pw.TextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(),
                child: pw.Divider(),
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.RichText(
                    text: pw.TextSpan(
                      text: 'Passenger Name\n',
                      style: pw.TextStyle(),
                      children: [
                        pw.TextSpan(
                          text: tempFirstName.toString().toUpperCase() +
                              ' ' +
                              tempLastName.toString().toUpperCase(),
                          style: pw.TextStyle(
                              fontSize: 13, fontWeight: pw.FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.RichText(
                        text: pw.TextSpan(
                          text: 'Departure Date \n',
                          style: pw.TextStyle(),
                          children: [
                            pw.TextSpan(
                              text: ticketDate,
                              style: pw.TextStyle(
                                  fontSize: 13, fontWeight: pw.FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      pw.RichText(
                        text: pw.TextSpan(
                          text: 'Boarding Place \n',
                          style: pw.TextStyle(),
                          children: [
                            pw.TextSpan(
                              text: selectedTerminalName,
                              style: pw.TextStyle(
                                  fontSize: 13, fontWeight: pw.FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      pw.RichText(
                        text: pw.TextSpan(
                          text: 'Bus Class \n',
                          style: pw.TextStyle(),
                          children: [
                            pw.TextSpan(
                              text: selectedBusClass,
                              style: pw.TextStyle(
                                  fontSize: 13, fontWeight: pw.FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      pw.RichText(
                        text: pw.TextSpan(
                          text: 'Price Category \n',
                          style: pw.TextStyle(),
                          children: [
                            pw.TextSpan(
                              text: tempPassengerType,
                              style: pw.TextStyle(
                                  fontSize: 13, fontWeight: pw.FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(height: 10),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.RichText(
                        text: pw.TextSpan(
                          text: 'Departure Time \n',
                          style: pw.TextStyle(),
                          children: [
                            pw.TextSpan(
                              text: ticketTime,
                              style: pw.TextStyle(
                                  fontSize: 13, fontWeight: pw.FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      pw.RichText(
                        text: pw.TextSpan(
                          text: 'Seat Number \n',
                          style: pw.TextStyle(),
                          children: [
                            pw.TextSpan(
                              text: tempSeatNumber,
                              style: pw.TextStyle(
                                  fontSize: 13, fontWeight: pw.FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      pw.RichText(
                        text: pw.TextSpan(
                          text: 'Discount \n',
                          style: pw.TextStyle(),
                          children: [
                            pw.TextSpan(
                              text: tempPercentageDiscount + '%',
                              style: pw.TextStyle(
                                  fontSize: 13, fontWeight: pw.FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(),
                child: pw.Divider(),
              ),
              pw.SizedBox(height: 20),
              pw.Column(
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Base Fare :',
                      ),
                      pw.Text(
                        double.parse(selectedPriceDetails).toStringAsFixed(2),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Discount :',
                      ),
                      pw.Text(
                        tempDiscountDouble.toStringAsFixed(2),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Total Fare :',
                      ),
                      pw.Text(
                        'PHP ' + tempSubTotalDouble.toStringAsFixed(2),
                        style: pw.TextStyle(
                          fontSize: 13,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(),
                child: pw.Divider(),
              ),
              pw.SizedBox(height: 50),
              pw.Center(
                  child: pw.Column(
                children: [
                  pw.Container(
                    height: 80,
                    width: 80,
                    child: pw.BarcodeWidget(
                        barcode: pw.Barcode.qrCode(), data: getTempTicket),
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Text(getTempTicket),
                ],
              ))
            ],
          );
        }));
    //
    //
    showPDf(pdf);
    downloadPDF(tempFirstName, tempLastName, pdf);
  }

  Future<void> popToSeat() {
    navKey.currentState.pushReplacementNamed(routeGenerateSeats);
  }

  Future<void> printData() async {
    print('Passenger Form');
    print(passengerType);
    print(passengerFirstName);
    print(passengerLastName);
    print(passengerEmailAddress);
    print(passengerMobileNum);
    print(passengerDiscountID);
    print(listDiscount);
    print('Trip Base Fare ' + double.parse(selectedPriceDetails).toString());
    print('Each Subtotal - ' + eachSubTotal.toString());
    print('Each Discount - ' + eachDiscount.toString());
    print('Total Price - ' + totalPrice.toString());
    print('Ticket ID - ' + ticketIDList.toString());
    print('Departure Date - ' + selectedDepartureDate);
    print('Departure Time - ' + selectedDepartureTime);
    return null;
  }

  Future<void> bookPayment() async {
    double priceTotal = 0;
    for (int i = 0; i < eachSubTotal.length; i++) {
      priceTotal = priceTotal + double.parse(eachSubTotal[i]);
    }
    for (int i = 0; i < seatCounter; i++) {
      //add company booking
      db.addCompanyBookingFormDetails(
          passengerType[i],
          passengerFirstName[i],
          passengerLastName[i],
          passengerEmailAddress[i],
          passengerMobileNum[i],
          selectedSeats[i],
          eachDiscount[i],
          eachSubTotal[i],
          passengerDiscountID[i],
          ticketIDList[i]);

      //add all booking
      String uidGet;
      var resultBookingForms = await FirebaseFirestore.instance
          .collection(company.toLowerCase() + "_bookingForms")
          .where('Ticket ID', isEqualTo: ticketIDList[i])
          .get();

      resultBookingForms.docs.forEach((res) {
        uidGet = res.id;
      });
      db.addAllBookingFormDetails(
          passengerType[i],
          passengerFirstName[i],
          passengerLastName[i],
          passengerEmailAddress[i],
          passengerMobileNum[i],
          selectedSeats[i],
          eachDiscount[i],
          eachSubTotal[i],
          passengerDiscountID[i],
          ticketIDList[i],
          uidGet);

      //Add company billing form
      DateTime tempDate = DateTime.now();
      DateTime dateBook = tempDate;
      var billingformDate = DateFormat('MMMM dd yyyy').format(tempDate);
      salesTotal = priceTotal;
      salesDate = billingformDate;
      salesMonth = dateBook;
      await db.addSalesByDaily();
      await db.addSalesByMonthly();
      // await db.updateSalesMonthly();
      await db.addCompanyBillingForm(eachDiscount[i], eachSubTotal[i],
          priceTotal, ticketIDList[i], billingformDate);

      String getUid = '';
      var resultBilling = await FirebaseFirestore.instance
          .collection(company.toString() + '_billingForms')
          .where('Address',
              isEqualTo: billingFormAddress.toString().toLowerCase())
          .where('Date of Payment', isEqualTo: billingformDate)
          .where('Discount', isEqualTo: eachDiscount[i])
          .where('Email', isEqualTo: billingFormEmail)
          .where('Mode of Payment', isEqualTo: 'Cash')
          .where('Name', isEqualTo: billingFormName.toString().toUpperCase())
          .where('Phone Number', isEqualTo: billingFormMobileNum)
          .where('Qty', isEqualTo: seatCounter)
          .where('Subtotal', isEqualTo: eachSubTotal[i])
          .where('Ticket ID', isEqualTo: ticketIDList[i])
          .where('Total Price', isEqualTo: priceTotal)
          .get();
      resultBilling.docs.forEach((val) {
        getUid = val.id;
      });
      await db.addAllBillingForm(eachDiscount[i], eachSubTotal[i], priceTotal,
          ticketIDList[i], billingformDate, getUid);
    }

    print('Booked successfully');
    return null;
  }

  @override
  Widget build(BuildContext context) {
    print('*** SELECTED TRIP VALUES ***');
    print('Origin - ' + '$selectedOrigin');
    print('Destination - ' + '$selectedDestination');
    print('Departure Date - ' + selectedDepartureDate.toString());
    print('Departure Time - ' + selectedDepartureTime.toString());
    print('Base Fare - ' + baseFare.toStringAsFixed(2));
    print('Subtotal - ' + subTotal.toStringAsFixed(2));

    // clear list
    mapPassengerType.clear();
    mapPassengerTypeDiscount.clear();
    passengerTypeDiscountList.clear();
    totalPrice = 0;
    subTotal = 0;

    //passenger type
    //remove duplicate from the list
    //var distinctPassengerType = passengerType.toSet().toList();
    //count duplicate from the list
    //passenger type
    passengerType.forEach((x) => mapPassengerType[x] =
        !mapPassengerType.containsKey(x) ? (1) : (mapPassengerType[x] + 1));
    // print(mapPassengerType);
    //add passenger type count from var to list
    passengerTypeCount.clear();
    mapPassengerType.forEach((key, value) {
      passengerTypeCount.add(value);
    });
    print('Passenger Type Count: ' + passengerTypeCount.toString());
    // print('Passenger Type Count: ' + passengerTypeCount.toString());

    //passenger type discount
    //count duplicate from the list
    //passenger type
    listDiscount.forEach((x) => mapPassengerTypeDiscount[x] =
        !mapPassengerTypeDiscount.containsKey(x)
            ? (1)
            : (mapPassengerTypeDiscount[x] + 1));
    // print(mapPassengerTypeDiscount);
    //add passenger type count from var to list
    mapPassengerTypeDiscount.forEach((key, value) {
      passengerTypeDiscountList.add(key);
    });
    print('Passenger Type Discount List: ' +
        passengerTypeDiscountList.toString());

    //print('Base Fare: ' + baseFare.toStringAsFixed(2));
    computeEachDiscount();
    computeTotalDiscount();
    subTotal = baseFare * seatCounter;
    print('SubTotal: ' + subTotal.toStringAsFixed(2));
    getTotalPrice();
    print('Total Fare: ' + '$totalPrice');
    //generateTicketID();

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            SizedBox(height: defaultPadding),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(height: defaultPadding),
                        Text(
                          'Billing Form',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(height: defaultPadding),
                        SizedBox(height: defaultPadding),
                        //full name
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please enter your first name";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() => billingFormName = val);
                          },
                          onSaved: (val) {
                            setState(() => billingFormName = val);
                          },
                          onTap: () {
                            InputDecoration(
                              hintText: 'Full Name',
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
                            labelText: 'Full Name',
                            labelStyle: TextStyle(
                              color: Colors.white38,
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                            ),
                            contentPadding: EdgeInsets.all(defaultPadding),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.8)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 189, 56, 1.0)),
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
                        //email
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          onChanged: (val) {
                            setState(() {
                              billingFormEmail = val;
                            });
                          },
                          onSaved: (val) {
                            setState(() {
                              billingFormEmail = val;
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
                            contentPadding: EdgeInsets.all(defaultPadding),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.8)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 189, 56, 1.0)),
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
                        //mobile number
                        TextFormField(
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(11),
                          ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          onChanged: (val) {
                            setState(() {
                              billingFormMobileNum = val;
                            });
                          },
                          onSaved: (val) {
                            setState(() {
                              billingFormMobileNum = val;
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
                            contentPadding: EdgeInsets.all(defaultPadding),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.8)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 189, 56, 1.0)),
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
                        //address
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please enter your address";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() => billingFormAddress = val);
                          },
                          onSaved: (val) {
                            setState(() => billingFormAddress = val);
                          },
                          onTap: () {
                            InputDecoration(
                              hintText: 'Address',
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
                            labelText: 'Address',
                            labelStyle: TextStyle(
                              color: Colors.white38,
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                            ),
                            contentPadding: EdgeInsets.all(defaultPadding),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.8)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 189, 56, 1.0)),
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: defaultPadding),
            SizedBox(height: defaultPadding),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: [
                      SizedBox(height: defaultPadding),
                      SizedBox(height: defaultPadding),
                      SizedBox(height: defaultPadding),
                      Text(
                        'Reservation Details',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(height: defaultPadding),
                      SizedBox(height: defaultPadding),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  selectedOrigin.toUpperCase(),
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //divider
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 0,
                                      ),
                                      child: Divider(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  selectedDestination.toString().toUpperCase(),
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(height: defaultPadding),
                      SizedBox(height: defaultPadding),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 0,
                        ),
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                      //price
                      SizedBox(height: defaultPadding),
                      SizedBox(height: defaultPadding),
                      Column(
                        children: [
                          //fare
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Base Fare :',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  baseFare.toStringAsFixed(2),
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: defaultPadding),
                          //qty
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Qty :',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  '$seatCounter',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: defaultPadding),
                          //subtotal
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Subtotal :',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  subTotal.toStringAsFixed(2),
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: defaultPadding),
                          SizedBox(height: defaultPadding),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 0,
                            ),
                            child: DottedLine(
                              dashColor: Colors.white,
                              dashGapLength: 7.0,
                              lineThickness: 1.5,
                            ),
                          ),
                          SizedBox(height: defaultPadding),
                          SizedBox(height: defaultPadding),
                          Column(
                            children: [
                              SizedBox(height: defaultPadding),
                              //discounts
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 18.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Discount :',
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Text(
                                      '- ' + totalDiscount.toStringAsFixed(2),
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: defaultPadding),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: distinctPassengerType.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 18.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 18.0,
                                            ),
                                            child: Text(
                                              //passengerType[index].toLowerCase().titleCase,
                                              distinctPassengerType[index],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 18.0,
                                            ),
                                            child: Text(
                                              passengerTypeCount[index]
                                                      .toString() +
                                                  ' x ' +
                                                  listDiscount[index]
                                                      .toString() +
                                                  '%',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                              SizedBox(height: defaultPadding),
                              SizedBox(height: defaultPadding),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 0,
                                ),
                                child: Divider(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: defaultPadding),
                              SizedBox(height: defaultPadding),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 18.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'TOTAL FARE :',
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Text(
                                      //'PHP ' + totalPrice.toStringAsFixed(2),
                                      'PHP ' + totalPrice.toStringAsFixed(2),
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: defaultPadding),
                              SizedBox(height: defaultPadding),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: defaultPadding),
            SizedBox(height: defaultPadding),
            ElevatedButton(
              onPressed: () async {
                //get new seat list
                List newListLeftSeat = [];
                newListLeftSeat.clear();

                List newRightSeatList = [];
                newRightSeatList.clear();

                List newListBottomSeat = [];
                newListBottomSeat.clear();

                List newLeftSeatStatus = [];
                newLeftSeatStatus.clear();

                List newRightSeatStatus = [];
                newRightSeatStatus.clear();

                List newBottomSeatStatus = [];
                newBottomSeatStatus.clear();

                final CollectionReference tripCollection = FirebaseFirestore
                    .instance
                    .collection('$company' + '_trips');

                var docSnapshot =
                    await tripCollection.doc(selectedTripID).get();
                if (docSnapshot.exists) {
                  Map<String, dynamic> data = docSnapshot.data();
                  newListLeftSeat = List.from(data['List Left Seat']);
                  newRightSeatList = List.from(data['List Right Seat']);
                  newListBottomSeat = List.from(data['List Bottom Seat']);
                  newLeftSeatStatus = List.from(data['Left Seat Status']);
                  newRightSeatStatus = List.from(data['Right Seat Status']);
                  newBottomSeatStatus = List.from(data['Bottom Seat Status']);
                }
                print('*** NEW SEATS ***');
                print('New List Left Seat - ' + newListLeftSeat.toString());
                print('New Left Seat Status - ' + newLeftSeatStatus.toString());
                print('New List Right Seat - ' + newRightSeatList.toString());
                print(
                    'New Right Seat Status - ' + newRightSeatStatus.toString());
                print('New List Bottom Seat - ' + newListBottomSeat.toString());
                print('New Bottom Seat Status - ' +
                    newBottomSeatStatus.toString());

                List newAllSeats = [
                  newListLeftSeat,
                  newRightSeatList,
                  newListBottomSeat
                ].expand((x) => x).toList();
                print('New All Seats - ' + newAllSeats.toString());

                //get index of selected seat from all seats
                List getIndex = [];
                getIndex.clear();

                for (int i = 0; i < selectedSeats.length; i++) {
                  for (int j = 0; j < newAllSeats.length; j++) {
                    if (selectedSeats[i] == newAllSeats[j]) {
                      getIndex.insert(i, j.toString());
                    }
                  }
                }

                print('Selected Seat - ' + selectedSeats.toString());
                print('Index from All Seats - ' + getIndex.toString());

                //get length of each seat list
                int newListLeftSeatLength = newListLeftSeat.length;
                int newRightSeatListLength = newRightSeatList.length;
                int newListBottomSeatLength = newListBottomSeat.length;

                List seatPosition = [];
                seatPosition.clear();
                for (int i = 0; i < getIndex.length; i++) {
                  if (int.parse(getIndex[i]) <= newListLeftSeatLength) {
                    seatPosition.insert(i, 'Left');
                  } else if (int.parse(getIndex[i]) <=
                      newRightSeatListLength + newListLeftSeatLength) {
                    seatPosition.insert(i, 'Right');
                  } else if (int.parse(getIndex[i]) <= newAllSeats.length) {
                    seatPosition.insert(i, 'Bottom');
                  }
                }

                print('Seat Position - ' + seatPosition.toString());

                List getEachIndex = [];
                getEachIndex.clear();
                for (int i = 0; i < seatPosition.length; i++) {
                  if (seatPosition[i].toString() == 'Left') {
                    for (int j = 0; j < newListLeftSeat.length; j++) {
                      if (newListLeftSeat[j] == selectedSeats[i]) {
                        getEachIndex.insert(i, j);
                      }
                    }
                  } else if (seatPosition[i].toString() == 'Right') {
                    for (int k = 0; k < newRightSeatList.length; k++) {
                      if (newRightSeatList[k] == selectedSeats[i]) {
                        getEachIndex.insert(i, k);
                      }
                    }
                  } else if (seatPosition[i].toString() == 'Bottom') {
                    for (int m = 0; m < newListBottomSeat.length; m++) {
                      if (newListBottomSeat[m] == selectedSeats[i]) {
                        getEachIndex.insert(i, m);
                      }
                    }
                  }
                }

                print('Index from Each Position - ' + getEachIndex.toString());

                List getSeatStatus = [];
                getSeatStatus.clear();
                for (int i = 0; i < seatPosition.length; i++) {
                  if (seatPosition[i].toString() == 'Left') {
                    getSeatStatus.insert(i, newLeftSeatStatus[getEachIndex[i]]);
                  } else if (seatPosition[i].toString() == 'Right') {
                    getSeatStatus.insert(
                        i, newRightSeatStatus[getEachIndex[i]]);
                  } else if (seatPosition[i].toString() == 'Bottom') {
                    getSeatStatus.insert(
                        i, newBottomSeatStatus[getEachIndex[i]]);
                  }
                }

                print('Seat Status of Selected Seat - ' +
                    getSeatStatus.toString());

                var result = getSeatStatus.contains(false);
                print('Result - ' + result.toString());

                generateTicketID();

                formKey.currentState.save();
                if (formKey.currentState.validate()) {
                  print(billingFormName);
                  print(billingFormEmail);
                  print(billingFormMobileNum);
                  print(billingFormAddress);

                  if (result == true) {
                    print('Seat taken. Choose a seat again');

                    setState(() {
                      walkInListLeftSeat.clear();
                      walkInListLeftSeat = List.of(newListLeftSeat);
                      walkInLeftSeatStatus.clear();
                      walkInLeftSeatStatus = List.of(newLeftSeatStatus);

                      walkInRightSeatList.clear();
                      walkInRightSeatList = List.of(newRightSeatList);
                      walkInRightSeatStatus.clear();
                      walkInRightSeatStatus = List.of(newRightSeatStatus);

                      walkInListBottomSeat.clear();
                      walkInListBottomSeat = List.of(newListBottomSeat);
                      walkInBottomSeatStatus.clear();
                      walkInBottomSeatStatus = List.of(newBottomSeatStatus);

                      seatsName.clear();
                      seatsName = [
                        walkInListLeftSeat,
                        walkInRightSeatList,
                        walkInListBottomSeat
                      ].expand((x) => x).toList();

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

                      selectedSeats.clear();
                      for (int i = 0; i < valueList.length; i++) {
                        valueList[i] = null;
                      }
                      print('Value List: ' + valueList.toString());
                      pickSeatAgainDialog();
                    });
                  } else {
                    print('Proceed to payment');

                    updateLeftSeatStatus.clear();
                    for (int i = 0; i < newLeftSeatStatus.length; i++) {
                      updateLeftSeatStatus.insert(i, newLeftSeatStatus[i]);
                    }

                    updateRightSeatStatus.clear();
                    for (int i = 0; i < newRightSeatStatus.length; i++) {
                      updateRightSeatStatus.insert(i, newRightSeatStatus[i]);
                    }

                    updateBottomSeatStatus.clear();
                    for (int i = 0; i < newBottomSeatStatus.length; i++) {
                      updateBottomSeatStatus.insert(i, newBottomSeatStatus[i]);
                    }

                    for (int i = 0; i < seatPosition.length; i++) {
                      if (seatPosition[i].toString() == 'Left') {
                        for (int j = 0; j < newLeftSeatStatus.length; j++) {
                          updateLeftSeatStatus[getEachIndex[i]] = false;
                        }
                      }
                      if (seatPosition[i].toString() == 'Right') {
                        for (int j = 0; j < newRightSeatStatus.length; j++) {
                          updateRightSeatStatus[getEachIndex[i]] = false;
                        }
                      }
                      if (seatPosition[i].toString() == 'Bottom') {
                        for (int j = 0; j < newBottomSeatStatus.length; j++) {
                          updateBottomSeatStatus[getEachIndex[i]] = false;
                        }
                      }
                    }
                    print('*** UPDATED SEATS ***');
                    print('Updated Left Seat Status - ' +
                        updateLeftSeatStatus.toString());
                    print('Updated Right Seat Status - ' +
                        updateRightSeatStatus.toString());
                    print('Updated Bottom Seat Status - ' +
                        updateBottomSeatStatus.toString());

                    feesDialog();
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(50, 30),
                primary: primaryColor,
              ),
              child: Text(
                'Pay Now',
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

  void pickSeatAgainDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            "\nSeat/s already taken. Please pick a seat again.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          elevation: 30.0,
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          actions: [
            Column(
              children: [
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                          70.0,
                          5.0,
                        ),
                        primary: bgColor,
                      ),
                      child: Text(
                        "OK",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      onPressed: () {
                        // int count = 0;
                        // Navigator.popUntil(context, (route) {
                        //   return count++ == 2;
                        // });
                        Navigator.pop(context);
                        popToSeat();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ],
        );
      },
    );
  }

  void feesDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Base Fare :',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    baseFare.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              //qty
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Qty :',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    '$seatCounter',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              //subtotal
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Subtotal :',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    subTotal.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              //discounts
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '* Discount :',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    '- ' + totalDiscount.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0,
                ),
                child: Divider(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total Fare :',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    //'PHP ' + totalPrice.toStringAsFixed(2),
                    'PHP ' + totalPrice.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              SizedBox(height: 5.0),
            ],
          ),
          elevation: 30.0,
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          actions: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(0, 35),
                        primary: primaryColor,
                      ),
                      child: Text(
                        'Enter cash amount',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        enterAmountDialog();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
              ],
            ),
          ],
        );
      },
    );
  }

  void enterAmountDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.0),
              Text(
                'Enter amount',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 8.0),
              Form(
                key: cashAmountFormKey,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  style: Theme.of(context).textTheme.subtitle1,
                  onSaved: (val) {
                    setState(() {
                      cashAmount = double.parse(val);
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(defaultPadding),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(0, 189, 56, 1.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          elevation: 30.0,
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          actions: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(0, 35),
                        primary: primaryColor,
                      ),
                      child: Text(
                        'Enter',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      onPressed: () {
                        cashAmountFormKey.currentState.save();
                        Navigator.pop(context);
                        cashChangeDialog();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
              ],
            ),
          ],
        );
      },
    );
  }

  void cashChangeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Cash :',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    cashAmount.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Fare :',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    '- ' + totalPrice.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0,
                ),
                child: Divider(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Change :',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    (cashAmount - totalPrice).toStringAsFixed(2),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ],
          ),
          elevation: 30.0,
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          actions: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(0, 35),
                        primary: primaryColor,
                      ),
                      child: Text(
                        'Download Ticket/s',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        navKey.currentState.pushReplacementNamed(routeWalkIn);
                        await printData();
                        for (int i = 0; i < seatCounter; i++) {
                          await downloadInvoicePDF(
                              ticketIDList[i],
                              passengerFirstName[i],
                              passengerLastName[i],
                              passengerEmailAddress[i],
                              selectedSeats[i],
                              passengerType[i],
                              listDiscount[i],
                              eachSubTotal[i],
                              eachDiscount[i]);
                        }
                        await bookPayment();

                        await db.updateBusAvailabilitySeatCompanyTrips();
                        await db.updateBusAvailabilitySeatAllTrips();
                        await db.updateCompanyTicketCounter();
                        await db.updateAllTicketCounter();

                        await db.updateAllSeatStatus();
                        await db.updateCompanySeatStatus();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
              ],
            ),
          ],
        );
      },
    );
  }
  Widget coupon() => Container(
      child: Column(
        children: [
          SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Align(
                        child: TextFormField(
                            // controller: usageUserController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Coupon Code',
                              contentPadding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
                            ),
                            onChanged: (value) {
                              setState(() {
                              });
                            }
                        ),
                    ),
                  ),
                     Expanded(
                       child: Align(
                        child: ElevatedButton.icon(
                          style: TextButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: defaultPadding * 1,
                              vertical:
                              defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                            ),
                          ),
                          onPressed: () async {
                              db.addCoupon();
                          },
                          icon: Icon(Icons.add),
                          label: Text("Apply Coupon"),
                        ),
                    ),
                     ),
                ],
              ),
              // Container(
              //   child: Align(
              //     child: ElevatedButton.icon(
              //       style: TextButton.styleFrom(
              //         backgroundColor: primaryColor,
              //         padding: EdgeInsets.symmetric(
              //           horizontal: defaultPadding * 1,
              //           vertical:
              //           defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
              //         ),
              //       ),
              //       onPressed: () async {
              //           db.addCoupon();
              //       },
              //       icon: Icon(Icons.add),
              //       label: Text("Apply Coupon"),
              //     ),
              //   ),
              // ),
            ],
      ));
}

