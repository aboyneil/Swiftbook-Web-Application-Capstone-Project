import 'package:admin/screens/Account/components/uppermenu.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../globals.dart';
import '../../responsive.dart';

class AccountPanel extends StatefulWidget {
  const AccountPanel({ Key key }) : super(key: key);

  @override
  _AccountPanelState createState() => _AccountPanelState();
}

class _AccountPanelState extends State<AccountPanel> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            if(userJobAccess != 'ticketing clerk')
              UpperMenu(),
            if(userJobAccess == 'ticketing clerk')
              Text('You don\u0027t have permission to access this panel!', style: TextStyle(color: Colors.redAccent)),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      SizedBox(height: defaultPadding),
                      // AccountTable(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                    ],
                  ),
                ),
              ],
            ),
            if(userJobAccess != 'ticketing clerk')
              Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('$company'+'_accounts').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return new Text('Loading...');
                        return DataTable(
                          headingRowColor:
                          MaterialStateColor.resolveWith((states) => Color(0xFF212332)),
                          sortColumnIndex: 0,
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Full Name',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Email',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Username',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Job Access',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                          rows: _createRows(snapshot.data),
                        );
                      }

                  ),
                ),
              ),
            if(userJobAccess == 'ticketing clerk')
              Text('You don\u0027t have permission to access this panel!', style: TextStyle(color: Colors.redAccent))

          ],
        ),
      ),
    );
  }
}

List<DataRow> _createRows(QuerySnapshot snapshot) {
  List<DataRow> newList =
  snapshot.docs.map((DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data();
    return new DataRow(cells: [
      DataCell(Text(data['fullname'].toString())),
      DataCell(Text(data['email'].toString())),
      DataCell(Text(data['username'].toString())),
      DataCell(Text(data['job_access'].toString())),
    ]);
  }).toList();

  return newList;
}
