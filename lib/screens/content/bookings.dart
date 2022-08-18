import 'package:admin/api/bus_api.dart';
import 'dart:js' as js;
import 'package:admin/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/constants.dart';
import 'package:admin/notifier/bus_notifier.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../responsive.dart';

class BookingsPage extends StatefulWidget {
  @override
  _BookingsPage createState() => _BookingsPage();
}

class _BookingsPage extends State<BookingsPage> {
  final List<String> bookDetailsColumns = [
    'Full Name',
    'Email',
    'Number',
    'Booking Status',
    'Action'
  ];
  List listItem = ["Last Name", "Ticket ID", "Bus Plate Number"];
  List statusItem = ["Active", "Absent", "Done", "Cancelled"];

  var checkStatus = '';
  int indexStatus = 0;
  var textStatus = '';
  String fieldStatus = 'Active';
  String searchField = '';
  String searchType;

  TextEditingController controller = TextEditingController();

  //Download reservation details
  Future<void> downloadReservationDetails() async {
    //get trip details
    List<String> uidList = [];
    int i = 0;
    var result = await FirebaseFirestore.instance
        .collection('$company' + '_bookingForms')
        .get();
    //Insert UIDs to List String
    result.docs.forEach((res) {
      uidList.insert(i, res.id);
      if (i < result.docs.length - 1) {
        i++;
      }
    });
    var tempFirstName;
    var tempLastName;
    var tempArray = [];
    var array = List.generate(uidList.length, (i) => List(19), growable: false);

    //Get bus details
    for (int i = 0; i < uidList.length; i++) {
      //Get Data in Fields
      var documentData = await FirebaseFirestore.instance
          .collection('$company' + '_bookingForms')
          .doc(uidList[i])
          .get();

      DateTime tempDate = new DateFormat("yyyy-MM-dd HH:mm:ss")
          .parse(documentData.get('Departure Date'));
      var date = DateFormat('MMMM-dd-yyyy').format(tempDate);

      DateTime tempTime = new DateFormat("0000-00-00 HH:mm:ss")
          .parse(documentData.get('Departure Time'));
      var time = DateFormat('h:mm a').format(tempTime);
      //Insert data to a temporary Array
      setState(() {
        tempArray.insert(0, documentData.get('Company Name'));
        tempArray.insert(1, documentData.get('Terminal Name'));
        tempFirstName = documentData.get('First Name');
        tempLastName = documentData.get('Last Name');
        tempArray.insert(2, tempFirstName + ' ' + tempLastName);
        tempArray.insert(3, documentData.get('Email'));
        tempArray.insert(4, documentData.get('Mobile Num'));
        tempArray.insert(5, documentData.get('Passenger Category'));
        tempArray.insert(6, documentData.get('ID'));
        tempArray.insert(7, documentData.get('Seat Number'));
        tempArray.insert(8, documentData.get('Percentage Discount'));
        tempArray.insert(9, documentData.get('Discount'));
        tempArray.insert(10, documentData.get('Bus Code'));
        tempArray.insert(11, documentData.get('Bus Class'));
        tempArray.insert(12, documentData.get('Bus Plate Number'));
        tempArray.insert(13, documentData.get('Bus Type'));
        tempArray.insert(14, documentData.get('Origin Route'));
        tempArray.insert(15, documentData.get('Destination Route'));
        tempArray.insert(16, date);
        tempArray.insert(17, time);
        tempArray.insert(18, documentData.get('Total Price'));
      });
      for (int j = 0; j < 19; j++) {
        array[i][j] = tempArray[j].toString();
      }
      tempArray.clear();
      tempArray = [];
    }
    print(array);

    for (int i = 0; i < array.length; i++) {
      for (int j = 0; j < array[i].length; j++) {
        js.context.callMethod('getCounter', [j]);
        js.context.callMethod('getList', [array[i][j]]);
      }
      js.context.callMethod('listPushClear');
    }
    //js.context.callMethod('printData');
    js.context.callMethod('getCompany', [company.toUpperCase()]);
    js.context.callMethod('downloadReservationDetails');
    js.context.callMethod('clearAll');
  }

  @override
  Widget build(BuildContext context) {
    BusNotifier busNotifier = Provider.of<BusNotifier>(context);
    print(fieldStatus);
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
            SizedBox(width: defaultPadding),
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
                  await downloadReservationDetails();
                },
                icon: Icon(Icons.print_outlined),
                label: Text("Download CSV"),
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
                                            .collection(
                                                '$company' + '_bookingForms')
                                            .where(searchType,
                                                isEqualTo:
                                                    searchField.toUpperCase())
                                            .where("Booking Status",
                                                isEqualTo: fieldStatus)
                                            .snapshots()
                                        : FirebaseFirestore.instance
                                            .collection(
                                                '$company' + '_bookingForms')
                                            .where("Booking Status",
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
                                          columns: bookDetailsColumns
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
        DataCell(Text(documentSnapshot['First Name'].toUpperCase() +
            " " +
            documentSnapshot['Last Name'].toUpperCase())),
        DataCell(Text(documentSnapshot['Email'].toString())),
        DataCell(Text(documentSnapshot['Mobile Num'].toString())),
        DataCell(Container(
            child: Row(
          children: [
            Text(documentSnapshot['Booking Status'].toString()),
          ],
        ))),
        DataCell( Container(
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
                      backgroundColor: Color(0xFF212332),
                      content: SingleChildScrollView(
                        child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                color: secondaryColor,
                                border: Border.all(color: Colors.white54),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        5.0) //                 <--- border radius here
                                    ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "TRIP DETAILS ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "ORIGIN: ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        documentSnapshot["Origin Route"]
                                            .toUpperCase(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "DESTINATION: ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        documentSnapshot["Destination Route"]
                                            .toUpperCase(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "DEPARTURE DATE: ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        date.toString(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "DEPARTURE TIME: ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        time.toString(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "SEAT NUMBER: ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        documentSnapshot["Seat Number"]
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "TICKET ID: ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        documentSnapshot["Ticket ID"]
                                            .toUpperCase(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: defaultPadding),
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                color: secondaryColor,
                                border: Border.all(color: Colors.white54),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        5.0) //                 <--- border radius here
                                    ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "PAYMENT DETAILS ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "DISCOUNT CATEGORY: ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        documentSnapshot["Passenger Category"]
                                            .toUpperCase(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "SUBTOTAL: ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        documentSnapshot["Subtotal"].toString(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "DISCOUNT: ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        documentSnapshot["Discount"].toString(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "TOTAL PRICE: ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        documentSnapshot["Total Price"]
                                            .toString(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: defaultPadding),
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                color: secondaryColor,
                                border: Border.all(color: Colors.white54),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        5.0) //                 <--- border radius here
                                    ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "BUS DETAILS ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                        "BUS TYPE: ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        documentSnapshot["Bus Type"]
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
                                        documentSnapshot["Bus Class"]
                                            .toUpperCase(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ]);
    }).toList();
    return newList;
  }
}
