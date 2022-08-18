// ignore_for_file: close_sinks
import 'dart:async';
import 'package:admin/globals.dart';
import 'package:admin/screens/WalkInPanel/walkIn_generateSeats.dart';
import 'package:admin/screens/WalkInPanel/walkIn_passengerForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/constants.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../api/trip_api.dart';
import '../../models/trip_model.dart';
import '../../notifier/trip_notifier.dart';
import '../../responsive.dart';

class WalkInPanel extends StatefulWidget {
  @override
  _WalkInPanel createState() => _WalkInPanel();
}

class _WalkInPanel extends State<WalkInPanel> {
  @override
  void initState() {
    TripNotifier tripNotifier =
        Provider.of<TripNotifier>(this.context, listen: false);
    getTrip(tripNotifier);
    super.initState();
  }

  List listItem = ["Origin Route", "Destination Route"];
  List statusItem = ["Upcoming", "Ongoing", "Completed"];

  var checkStatus = '';
  int indexStatus = 0;
  var textStatus = '';
  var search = "false";
  var temporary = [];
  String fieldStatus = 'Upcoming';
  String searchField = '';
  String searchType;

  TextEditingController controller = TextEditingController();

  Future<void> getBusDocID() async {
    var result = await FirebaseFirestore.instance
        .collection('$company' + '_bus')
        .where('Bus Plate Number', isEqualTo: selectedBusPlateNumber)
        .get();
    result.docs.forEach((val) {
      busDocID = val.id;
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WalkInPassengerForm()))
        .then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    TripNotifier tripNotifier = Provider.of<TripNotifier>(context);
    var date;
    var time;
    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.all(defaultPadding),
      child: Column(children: [
        Header(),
        SizedBox(height: defaultPadding),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF2A2D3E), width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButtonFormField(
                  isExpanded: true,
                  value: fieldStatus,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.8),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 189, 56, 1.0),
                      ),
                    ),
                  ),
                  hint: Text('Select Status'),
                  onChanged: (newValue) {
                    setState(() {
                      fieldStatus = newValue;
                    });
                  },
                  items: statusItem.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF2A2D3E), width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButtonFormField(
                  isExpanded: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.8),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 189, 56, 1.0),
                      ),
                    ),
                  ),
                  value: searchType,
                  hint: Text('Select Filter'),
                  onChanged: (newValue) {
                    setState(() {
                      searchType = newValue;
                    });
                  },
                  items: listItem.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(width: defaultPadding),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Search",
                  fillColor: secondaryColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: new IconButton(
                      icon: new Icon(Icons.cancel),
                      onPressed: () {
                        setState(() {
                          controller.clear();
                          searchField = controller.text;
                          busList = tempBusList;
                        });
                      },
                    ),
                  ),
                ),
              ),
            )),
            SizedBox(width: defaultPadding),
//Download CSV file
            Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    searchField = controller.text;

                  });
                },
                icon: Icon(Icons.search_outlined),
                label: Text("Filter"),
              ),
            ),
          ],
        ),
//Table Displaying bus details
        SizedBox(height: defaultPadding),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Center(
                              child: StreamBuilder<QuerySnapshot>(
                                stream:
                                    (searchField != "" && searchField != null)
                                        ? FirebaseFirestore.instance
                                            .collection('$company' + '_trips')
                                            .where(searchType,
                                                isEqualTo:
                                                    searchField.toUpperCase())
                                            .where("Travel Status",
                                                isEqualTo: fieldStatus)
                                            .snapshots()
                                        : FirebaseFirestore.instance
                                            .collection('$company' + '_trips')
                                            .where("Travel Status",
                                                isEqualTo: fieldStatus)
                                            .snapshots(),
                                builder: (context, snapshot) {
                                  return (snapshot.connectionState ==
                                          ConnectionState.waiting)
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : DataTable(
                                          headingRowColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) =>
                                                      Color(0xFF212332)),
                                          sortColumnIndex: 0,
                                          columns: tripDetailsColumns
                                              .map(
                                                (String column) => DataColumn(
                                                  label: Center(
                                                      child: Text(column)),
                                                ),
                                              )
                                              .toList(),
                                          rows: _createRows(snapshot.data),
                                        );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ]),
    ));
  }

  List<DataRow> _createRows(QuerySnapshot snapshot) {
    List<DataRow> newList =
        snapshot.docs.map((DocumentSnapshot documentSnapshot) {
      DateTime tempDate = new DateFormat("yyyy-MM-dd HH:mm:ss")
          .parse(documentSnapshot['Departure Date']);
      var date = DateFormat('MMMM-dd-yyyy').format(tempDate);

      DateTime tempTime = new DateFormat("0000-00-00 HH:mm:ss")
          .parse(documentSnapshot['Departure Time']);
      var time = DateFormat('h:mm a').format(tempTime);
      return new DataRow(cells: [
        DataCell(Text(documentSnapshot['Origin Route'].toString())),
        DataCell(Text(documentSnapshot['Destination Route'].toString())),
        DataCell(Text(date.toString())),
        DataCell(Text(time.toString())),
        DataCell(Text(documentSnapshot['Travel Status'].toString())),
        DataCell(Container(
          child: Row(children: [
            Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.remove_red_eye),
                color: Color.fromRGBO(24, 168, 30, 1.0),
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Full Details'),
                    content: new Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              "BUS DRIVER: ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              documentSnapshot["Bus Driver"].toUpperCase(),
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "PLATE NUMBER: ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              documentSnapshot["Bus Plate Number"]
                                  .toUpperCase(),
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "BUS CLASS: ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              documentSnapshot["Bus Class"].toUpperCase(),
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "BUS TYPE: ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              documentSnapshot["Bus Type"].toUpperCase(),
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "TERMINAL: ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              documentSnapshot["Terminal"],
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "SEAT AVAILABILITY: ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              documentSnapshot["Bus Availability Seat"]
                                  .toString(),
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "PRICE: ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              documentSnapshot["Price Details"].toString(),
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 3.5),
            //book now button
            Container(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () async {

                  selectedBusAvailabilitySeat =
                      documentSnapshot[
                      "Bus Availability Seat"]
                          .toString();
                  if (selectedBusAvailabilitySeat == '0'){
                    fullyBookedDialog();
                  } else {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          StreamController<String> controlling =
                          StreamController<String>.broadcast();
                          return AlertDialog(
                            backgroundColor: bgColor,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "\nPlease select a number of seats",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0),
                                ),
                                SizedBox(height: 20.0),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    //add number of seat
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        //minus number of seat
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.0),
                                            child: Center(
                                                child: IconButton(
                                                  icon: Icon(
                                                      Icons.remove_rounded),
                                                  iconSize: 30.0,
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    if (seatCounter > 1) {
                                                      seatCounter--;
                                                      controlling.add(
                                                          "$seatCounter");
                                                    }
                                                  },
                                                ))),

                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 0,
                                          ),
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            margin: EdgeInsets.all(0),
                                            padding: EdgeInsets.all(0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              color: secondaryColor,
                                            ),
                                            child: Center(
                                              child: StreamBuilder(
                                                  stream: controlling.stream,
                                                  builder: (
                                                      BuildContext context,
                                                      AsyncSnapshot<String>
                                                      snapshot) {
                                                    return Text(
                                                      snapshot.hasData
                                                          ? snapshot.data
                                                          : '$seatCounter',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 20.0,
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ),
                                        ),
                                        //add number of seat
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 2,
                                            ),
                                            child: Center(
                                                child: IconButton(
                                                  icon: Icon(Icons.add_rounded),
                                                  iconSize: 30,
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    seatCounter++;
                                                    controlling.add(
                                                        "$seatCounter");
                                                  },
                                                ))),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            actions: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    child: Divider(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 30.0),
                                      TextButton(
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(
                                            70.0,
                                            5.0,
                                          ),
                                          primary: bgColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        child: Text(
                                          "OK",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Poppins',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.1,
                                          ),
                                        ),
                                        onPressed: () async {
                                          selectedDepartureDate =
                                              tempDate.toString();
                                          selectedDepartureTime =
                                              documentSnapshot["Departure Time"];
                                          selectedTripID =
                                              documentSnapshot["Trip ID"]
                                                  .toString();
                                          selectedOrigin =
                                              documentSnapshot["Origin Route"]
                                                  .toString();
                                          selectedDestination =
                                              documentSnapshot[
                                              "Destination Route"]
                                                  .toString();
                                          selectedBusType =
                                              documentSnapshot["Bus Type"]
                                                  .toString();
                                          selectedBusClass =
                                              documentSnapshot["Bus Class"]
                                                  .toString();
                                          selectedTerminalName =
                                              documentSnapshot["Terminal"]
                                                  .toString();
                                          selectedPriceDetails =
                                              documentSnapshot["Price Details"]
                                                  .toString();
                                          selectedBusCode =
                                              documentSnapshot["Bus Code"]
                                                  .toString();
                                          selectedBusPlateNumber =
                                              documentSnapshot["Bus Plate Number"]
                                                  .toString();
                                          selectedBusSeatCapacity =
                                              documentSnapshot[
                                              "Bus Seat Capacity"]
                                                  .toString();
                                          selectedTripStatus =
                                              documentSnapshot["Trip Status"]
                                                  .toString();
                                          selectedDriverID =
                                              documentSnapshot["Driver ID"]
                                                  .toString();
                                          selectedCounter =
                                              documentSnapshot["counter"]
                                                  .toString();

                                          print('*** SELECTED BUS TRIP ***');
                                          print(selectedDepartureDate);
                                          print(selectedDepartureTime);
                                          print(selectedTripID);
                                          print(selectedOrigin);
                                          print(selectedDestination);
                                          print(selectedBusType);
                                          print(selectedBusClass);
                                          print(selectedTerminalName);
                                          print(selectedPriceDetails);
                                          print(selectedBusCode);
                                          print(selectedBusPlateNumber);
                                          print(selectedBusSeatCapacity);
                                          print(selectedBusAvailabilitySeat);
                                          print(selectedTripStatus);
                                          print(selectedDriverID);
                                          print(selectedCounter);

                                          Navigator.pop(context);
                                          await getBusDocID();
                                          // //Navigator.of(context).pop();
                                          // Navigator.push(context, MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         WalkInPassengerForm()));
                                        },
                                      ),
                                      SizedBox(height: 30.0),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        });
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(0, 35),
                  primary: primaryColor,
                ),
                child: Text(
                  'Book Now',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ]),
        )),
      ]);
    }).toList();
    return newList;
  }

  void fullyBookedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            "\nFully Booked!",
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

}
