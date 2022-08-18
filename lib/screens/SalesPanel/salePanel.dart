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

class SalesPage extends StatefulWidget {
  @override
  _SalesPage createState() => _SalesPage();
}

class _SalesPage extends State<SalesPage> {
  List listItem = ["Origin Route", "Destination Route"];
  List statusItem = ["Daily", "Annual"];

  bool flag = false;
  var checkStatus = '';
  int indexStatus = 0;
  var textStatus = '';
  String fieldStatus = 'Daily';
  String searchField = '';
  String searchType;
  DateTime nowYear = DateTime.now();
  DateTime start;
  DateTime end;
  TextEditingController startDateInput = TextEditingController();
  TextEditingController DateInput = TextEditingController()..text = finalYear;
  TextEditingController controller = TextEditingController();

  Future<void> downloadTripDetails() async {
  }

  @override
  Widget build(BuildContext context) {

    searchField = "2023";
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
                Align(
                  alignment: Alignment.centerRight,
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
                      start = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          initialDatePickerMode: DatePickerMode.year,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      if (start != null) {
                        //print(pickedDate); //pickedDate output
                        startDate = DateFormat('yyyy-MM-dd').format(start);

                        setState(() {
                          int tempYear = start.year;
                          String finalDate = tempYear.toString();
                          finalYear = finalDate;
                          DateInput.text = finalYear;
                          finalYear  = DateInput.text;
                          //set output date to TextField value.
                          year = start.year;
                        });
                      } else {
                      }
                      print(year);
                    },
                    icon: Icon(Icons.date_range),
                    label: Text(DateInput.text),
                  ),
                ),
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
                        print(startDateInput.text);
                        searchField = startDateInput.text;
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
            fieldStatus == "Daily"
                ?
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
                                    (fieldStatus == "Daily" && searchField == "2022")
                                        ? FirebaseFirestore.instance
                                        .collection('$company' + '_salesByDaily')
                                        .where('year',
                                        isEqualTo:
                                        int.parse(finalYear))
                                        .snapshots()
                                        :  FirebaseFirestore.instance
                                        .collection('$company' + '_salesByDaily')
                                        .where('year',
                                        isEqualTo:
                                        int.parse(finalYear))
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
                                        columns: salesDetailsColumns
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
            ) : Row(
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
                                    (searchField == "2022")
                                        ? FirebaseFirestore.instance
                                        .collection('$company' + '_salesByMonthly')
                                        .orderBy('index', descending: false)
                                        .snapshots()
                                        :  FirebaseFirestore.instance
                                        .collection('$company' + '_salesByMonthly')
                                        .where('year',
                                        isEqualTo:
                                        int.parse(finalYear))
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
                                        columns: salesDetailsColumns
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
            )
          ]),
        ));
  }

  List<DataRow> _createRows(QuerySnapshot snapshot) {
    List<DataRow> newList =
    snapshot.docs.map((DocumentSnapshot documentSnapshot) {

      return new DataRow(cells: [
        DataCell(Text(documentSnapshot['date'])),
        DataCell(Text(documentSnapshot['total'].toString())),
      ]);
    }).toList();
    return newList;
  }
}
