import 'package:admin/models/bus_model.dart';
import 'package:admin/services/database.dart';
import 'package:admin/widget/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../globals.dart';
import '../../../responsive.dart';

class BusClass extends StatefulWidget {
  const BusClass({Key key}) : super(key: key);

  @override
  _BusClassState createState() => _BusClassState();
}

class _BusClassState extends State<BusClass> {
  final DatabaseService db = DatabaseService();

  @override
  Widget build (BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bus Class",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: defaultPadding),
          Row(
            children: [
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
                    final action = await AlertDialogs.BusClassFieldDialog(context);

                    if (action == DialogsAction.yes) {
                      db.addBusClass();
                      await AlertDialogs.successDialog(
                          context, 'You successfully added a Bus Class!', '');
                    } else {}
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add New"),
                ),
              ),
              SizedBox(width: defaultPadding),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: bgColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1,
                      vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => _buildPopupDialog(context),
                    );
                  },
                  icon: Icon(Icons.remove_red_eye_sharp),
                  label: Text("View"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Price Categories'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SingleChildScrollView(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('$company'+'_busClass').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return new Text('Loading...');
                  return DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Destination Route',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                    rows: _createRows(snapshot.data),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}
List<DataRow> _createRows(QuerySnapshot snapshot) {
  List<DataRow> newList =
  snapshot.docs.map((DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data();
    return new DataRow(cells: [
      DataCell(Text(data['bus class'].toString())),
    ]);
  }).toList();

  return newList;
}
