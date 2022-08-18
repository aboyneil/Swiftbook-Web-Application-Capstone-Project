import 'dart:js' as js;
import 'package:admin/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/constants.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/trip_model.dart';
import '../../responsive.dart';
import '../../widget/alert_dialog.dart';
import '../../widget/date_time_picker.dart';

class TripDetailsPanel extends StatefulWidget {
  @override
  _TripDetailsPanel createState() => _TripDetailsPanel();
}

class _TripDetailsPanel extends State<TripDetailsPanel> {
  List listItem = ["Origin Route", "Destination Route"];
  List statusItem = ["Upcoming", "Ongoing", "Completed"];

  bool flag = false;
  var checkStatus = '';
  int indexStatus = 0;
  var textStatus = '';
  String fieldStatus = 'Upcoming';
  String searchField = '';
  String searchType;

  TextEditingController controller = TextEditingController();

  Future<void> downloadTripDetails() async {
    //get trip details
    List<String> uidList = [];
    int i = 0;
    var result = await FirebaseFirestore.instance
        .collection('$company' + '_trips')
        .get();
    //Insert UIDs to List String
    result.docs.forEach((res) {
      uidList.insert(i, res.id);
      if (i < result.docs.length - 1) {
        i++;
      }
    });
    var tempArray = [];
    var array = List.generate(uidList.length, (i) => List(15), growable: false);

    //Get bus details
    for (int i = 0; i < uidList.length; i++) {
      //Get Data in Fields
      var documentData = await FirebaseFirestore.instance
          .collection('$company' + '_trips')
          .doc(uidList[i])
          .get();
      //Insert data to a temporary Array
      DateTime tempDate = new DateFormat("yyyy-MM-dd HH:mm:ss")
          .parse(documentData.get('Departure Date'));
      var date = DateFormat('MMMM-dd-yyyy').format(tempDate);

      DateTime tempTime = new DateFormat("0000-00-00 HH:mm:ss")
          .parse(documentData.get('Departure Time'));
      var time = DateFormat('h:mm a').format(tempTime);
      setState(() {
        tempArray.insert(0, documentData.get('Company Name'));
        tempArray.insert(1, documentData.get('Terminal'));
        tempArray.insert(2, documentData.get('Bus Class'));
        tempArray.insert(3, documentData.get('Bus Code'));
        tempArray.insert(4, documentData.get('Bus Driver'));
        tempArray.insert(5, documentData.get('Bus Seat Capacity'));
        tempArray.insert(6, documentData.get('Bus Availability Seat'));
        tempArray.insert(7, documentData.get('Bus Type'));
        tempArray.insert(8, date);
        tempArray.insert(9, time);
        tempArray.insert(10, documentData.get('Origin Route'));
        tempArray.insert(11, documentData.get('Destination Route'));
        tempArray.insert(12, documentData.get('Price Details'));
        tempArray.insert(13, documentData.get('Travel Status'));
        tempArray.insert(14, documentData.get('Trip Status'));
        if (tempArray[14] == true) {
          tempArray.insert(14, 'Active');
        } else {
          tempArray.insert(14, 'Inactive');
        }
      });
      for (int j = 0; j < 15; j++) {
        array[i][j] = tempArray[j].toString();
      }
      tempArray.clear();
      tempArray = [];
    }
    for (int i = 0; i < array.length; i++) {
      for (int j = 0; j < array[i].length; j++) {
        js.context.callMethod('getCounter', [j]);
        js.context.callMethod('getList', [array[i][j]]);
      }
      js.context.callMethod('listPushClear');
    }
    js.context.callMethod('getCompany', [company.toUpperCase()]);
    js.context.callMethod('downloadTripDetails');
    js.context.callMethod('clearAll');
  }

  @override
  Widget build(BuildContext context) {
    //print(fieldStatus);
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
                      downloadTripDetails();
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
            Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.edit),
                color: Color.fromRGBO(24, 168, 30, 1.0),
                onPressed: () async {
                  editTripBus =  documentSnapshot["Bus Plate Number"];
                  editTripDriver = documentSnapshot["Bus Driver"];
                  busClass =  documentSnapshot["Bus Class"];
                  await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.all(30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Edit Trip Details"),
                              SizedBox(height: defaultPadding),
                              Column(
                                children: [
                                  Align( alignment: Alignment.topLeft,child:Text("Update Bus")),
                                  Container(
                                    child: new StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('$company' + '_bus')
                                            .where("Bus Class", isEqualTo: busClass)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: CupertinoActivityIndicator(),
                                            );
                                          } else {
                                            return DropdownButtonFormField(
                                              value: editTripBus,
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
                                              hint: Text(
                                                "Select Bus",
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  editTripBus = value.toUpperCase();
                                                });
                                              },
                                              items: snapshot.data.docs.map((DocumentSnapshot docs) {
                                                return new DropdownMenuItem<String>(
                                                  value: docs['Bus Plate Number'],
                                                  child: new Text(
                                                    docs['Bus Plate Number'].toUpperCase(),
                                                  ),
                                                );
                                              }).toList(),
                                            );
                                          }
                                        }),
                                  ),
                                ],
                              ),
                              SizedBox(height: defaultPadding),
                              Column(
                                children: [
                                  Align( alignment: Alignment.topLeft,child:Text("Update Driver")),
                                  Container(
                                    child: new StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('$company' + '_drivers')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: CupertinoActivityIndicator(),
                                            );
                                          } else {
                                            return DropdownButtonFormField(
                                              value: editTripDriver,
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
                                              hint: Text(
                                                "Select Driver",
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  editTripDriver = value.toUpperCase();
                                                });
                                              },
                                              items: snapshot.data.docs.map((DocumentSnapshot docs) {
                                                return new DropdownMenuItem<String>(
                                                  value: docs['fullname'],
                                                  child: new Text(
                                                    docs['fullname'].toUpperCase(),
                                                  ),
                                                );
                                              }).toList(),
                                            );
                                          }
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () =>
                                  Navigator.of(context).pop(DialogsAction.cancel),
                              child: const Text('Cancel'),
                              style: TextButton.styleFrom(
                                backgroundColor: errorColor,
                                padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding * 1.5,
                                  vertical:
                                  defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: ()async{
                                print(editTripBus);
                                busPlateNumber = documentSnapshot['Bus Plate Number'];
                                editDepartureDate = documentSnapshot['Departure Date'];
                                var result = await FirebaseFirestore.instance
                                    .collection('$company' + '_trips')
                                    .where('Bus Plate Number', isEqualTo: busPlateNumber)
                                    .where('Departure Date', isEqualTo: editDepartureDate)
                                    .get();
                                var editResult = await FirebaseFirestore.instance
                                    .collection('$company' + '_bus')
                                    .where('Bus Plate Number', isEqualTo: editTripBus).get();
                                var bookingResult = await FirebaseFirestore.instance
                                    .collection('$company' + '_bookingForms')
                                    .where('Bus Plate Number', isEqualTo: busPlateNumber)
                                    .where('Departure Date', isEqualTo: editDepartureDate)
                                    .get();

                                result.docs.forEach((document) {
                                  docUid = document.id;
                                  editResult.docs.forEach((document){
                                    intAvailabilitySeat = document['Bus Availability Seat'];
                                    busClass =  document['Bus Class'];
                                    busCode = document['Bus Code'];
                                    busType = document['Bus Type'];
                                    busCode = document['Bus Code'];
                                    busSeatCapacity = document['Bus Seat Capacity'];
                                    updateLeftSeatStatus = document['Left Seat Status'];
                                    updateRightSeatStatus = document['Right Seat Status'];
                                    updateBottomSeatStatus = document['Bottom Seat Status'];
                                    rightGeneratedSeat = document['List Right Seat'];
                                    leftGeneratedSeat = document['List Left Seat'];
                                    bottomGeneratedSeat = document['List Bottom Seat'];
                                  });
                                  bookingResult.docs.forEach((document) {
                                    bookingDocUid = document.id;
                                    int i = 0;
                                    if(i==1){
                                      flag = true;
                                    }
                                    i++;
                                  });
                                });
                                if(flag == true){
                                  db.updateBookingTrip();
                                }
                                db.updateTrip();
                                db.updateAllTrip();
                                await AlertDialogs.successDialog(
                                    context,
                                    'You successfully added a trip!',
                                    '');
                                Navigator.pop(context);

                                print("*** UPDATE BUS ***");
                                print("Plate N:"+"$busPlateNumber");
                                print("Available Seat:"+"$intAvailabilitySeat");
                                print("Class:"+"$busClass");
                                print("Code:"+"$busCode");
                                print("Type:"+"$busType");
                                print("Left Seat:"+"$leftGeneratedSeat");
                              },
                              child: const Text('Update'),
                              style: TextButton.styleFrom(
                                backgroundColor: primaryColor,
                                padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding * 1.5,
                                  vertical:
                                  defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                },
              ),
            ),
          ]),
        )),
      ]);
    }).toList();
    return newList;
  }
}
