import 'package:admin/services/database.dart';
import 'package:admin/widget/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../globals.dart';
import '../../../responsive.dart';

class baggageCheck extends StatefulWidget {
  const baggageCheck({Key key}) : super(key: key);

  @override
  _baggageCheckState createState() => _baggageCheckState();
}

class _baggageCheckState extends State<baggageCheck> {
  final DatabaseService db = DatabaseService();
  @override
  Widget build(BuildContext context) {
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
            "Charge for Extra Baggage?",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: defaultPadding),
          Row(
            children: [
              Switch(
                value: checkBaggage,
                onChanged: (bool value) {
                  print(checkBaggage);
                  setState(() {
                    checkBaggage = value;
                  });
                  db.updateBaggage();
                },
              ),
              SizedBox(width: defaultPadding),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Origin Route'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SingleChildScrollView(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('$company' + '_origin')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return new Text('Loading...');
                  return DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Origin Route',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                    rows: _createRows(snapshot.data),
                  );
                }),
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
      DataCell(Text(data['location'].toString())),
    ]);
  }).toList();

  return newList;
}
