import 'package:admin/api/bus_api.dart';
import 'dart:js' as js;
import 'package:admin/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/constants.dart';
import 'package:admin/models/bus_model.dart';
import 'package:admin/notifier/bus_notifier.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../responsive.dart';
import '../../widget/alert_dialog.dart';
import '../WalkInPanel/walkIn_generateSeats.dart';
import 'components/popup_Busdetails_form.dart';

class BusDetailsPanel extends StatefulWidget {
  @override
  _BusDetailsPanel createState() => _BusDetailsPanel();
}

class _BusDetailsPanel extends State<BusDetailsPanel> {
  List listItem = ["Bus Code", "Bus Plate Number", "Bus Class"];
  List statusItem = ["Active", "Inactive"];
  @override
  void initState(){
    BusNotifier busNotifier = Provider.of<BusNotifier>(this.context, listen: false);
    getBus(busNotifier);
    super.initState();
    print(busList);
    // _currentBus = Bus();
  }

  var checkStatus = '';
  int indexStatus = 0;
  var textStatus = '';
  String fieldStatus = 'Active';
  String searchField = '';
  String searchType;


  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BusNotifier busNotifier = Provider.of<BusNotifier>(context);
    print(fieldStatus);
    return Scaffold(
        body: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
                children: [
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
                          onPressed: ()async{
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
                            print('CSV');
                            //get bus details
                            List<String> uidList = [];
                            int i = 0;
                            var result = await FirebaseFirestore.instance
                                .collection('$company' + '_bus')
                                .get();
                            //Insert UIDs to List String
                            result.docs.forEach((res) {
                              uidList.insert(i, res.id);
                              if (i < result.docs.length - 1) {
                                i++;
                              }
                            });

                            var tempArray = [];
                            var array = List.generate(uidList.length, (i) => List(6),
                                growable: false);

                            //Get bus details
                            for (int i = 0; i < uidList.length; i++) {
                              //Get Data in Fields
                              var documentData = await FirebaseFirestore.instance
                                  .collection('$company' + '_bus')
                                  .doc(uidList[i])
                                  .get();
                              //Insert data to a temporary Array
                              setState(() {
                                tempArray.insert(0, documentData.get('Bus Code'));
                                tempArray.insert(1, documentData.get('Bus Plate Number'));
                                tempArray.insert(2, documentData.get('Bus Class'));
                                tempArray.insert(3, documentData.get('Bus Type'));
                                tempArray.insert(4, documentData.get('Bus Seat Capacity'));
                                tempArray.insert(5, documentData.get('Bus Status'));
                              });
                              for (int j = 0; j < 6; j++) {
                                array[i][j] = tempArray[j].toString();
                              }
                              tempArray.clear();
                              tempArray = [];
                            }
                            //print(array);
                            print(array);

                            for (int i = 0; i < array.length; i++) {
                              for (int j = 0; j < array[i].length; j++) {
                                js.context.callMethod('getCounter', [j]);
                                js.context.callMethod('getList', [array[i][j]]);
                              }
                              js.context.callMethod('listPushClear');

                            }
                            js.context.callMethod('getCompany', [userCompany]);
                            js.context.callMethod('downloadBusDetails');
                            js.context.callMethod('clearAll');
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
                                          stream: (searchField != "" && searchField != null)
                                              ? FirebaseFirestore.instance
                                              .collection('$company'+'_bus')
                                              .where(searchType, isEqualTo: searchField.toUpperCase())
                                              .where("Bus Status", isEqualTo: fieldStatus == 'Active' ? true : false)
                                              .snapshots()
                                              : FirebaseFirestore.instance.collection('$company'+'_bus')
                                              .where("Bus Status", isEqualTo: fieldStatus == 'Active' ? true : false)
                                              .snapshots(),
                                          builder: (context, snapshot) {

                                            return (snapshot.connectionState == ConnectionState.waiting)
                                                ? Center(child: CircularProgressIndicator())
                                                : DataTable(
                                              headingRowColor:
                                              MaterialStateColor.resolveWith((states) => Color(0xFF212332)),
                                              sortColumnIndex: 0,
                                              columns: busDetailsColumns
                                                  .map(
                                                    (String column) => DataColumn(label: Center(child: Text(column)),),)
                                                  .toList(),
                                              rows: _createRows(snapshot.data),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],),
                          ))
                    ],
                  ),
                ]),
        ));

  }
  List<DataRow> _createRows(QuerySnapshot snapshot) {
    // print(snapshot.docs.length);
    List<DataRow> newList =
    snapshot.docs.map((DocumentSnapshot documentSnapshot) {
      return new DataRow(cells: [
        DataCell(Text(documentSnapshot['Bus Code'].toString())),
        DataCell(Text(documentSnapshot['Bus Plate Number'].toString())),
        DataCell(Text(documentSnapshot['Bus Class'].toString())),
        DataCell(Text(documentSnapshot['Bus Type'].toString())),
        DataCell(Text(documentSnapshot['Bus Seat Capacity'].toString())),
        DataCell(Container(
            child: Row(children: [
              Icon(
                documentSnapshot['Bus Status'].toString() == 'true' ? Icons.check_circle : Icons.cancel ,
                color: documentSnapshot["Bus Status"].toString() == 'true' ?
                Color.fromRGBO(41, 171, 135, 1.0) : Color.fromRGBO(220, 20, 60, 1.0),
              ),
              Text(documentSnapshot['Bus Status'].toString() == 'true'? "Active" : "Inactive"),
            ],))),
        DataCell(Container(
          child: Row(children: [
            Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.edit),
                color: Color.fromRGBO(24, 168, 30, 1.0),
                onPressed: () async {
                  busPlateNumber = documentSnapshot['Bus Plate Number'];
                  var result = await FirebaseFirestore.instance
                      .collection('$company' + '_bus')
                      .where('Bus Plate Number', isEqualTo: busPlateNumber)
                      .get();
                  result.docs.forEach((document) {
                    docUid = document.id;
                    leftColSize = document['Left Col Size'];
                    leftRowSize = document['Left Row Size'];
                    rightColSize = document['Right Col Size'];
                    rightRowSize = document['Right Row Size'];
                    bottomColNumber = document['Bottom Col Size'];
                    walkInRightSeatList = document['List Right Seat'];
                    walkInRightSeatStatus = document['Right Seat Status'];
                    walkInListLeftSeat = document['List Left Seat'];
                    walkInLeftSeatStatus = document['Left Seat Status'];
                    walkInListBottomSeat = document['List Bottom Seat'];
                    walkInBottomSeatStatus = document['Bottom Seat Status'];
                  });
                  var resultTrip = await FirebaseFirestore.instance
                      .collection('$company' + '_trips')
                      .where('Bus Plate Number', isEqualTo: busPlateNumber)
                      .where('Travel Status', isEqualTo: 'Upcoming')
                      .get();
                  if(resultTrip.docs.length != 0){
                    await AlertDialogs.errorDialog(
                        context,
                        'You cannot edit bus that has upcoming trip!',
                        '');
                  }else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Mock()),
                    );
                  }

                },
              ),
            ),
          ]),)),
      ]);
    }).toList();
    return newList;
  }
}

