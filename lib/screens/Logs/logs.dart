import 'package:admin/globals.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';

class LogsPanel extends StatefulWidget {
  const LogsPanel({Key key}) : super(key: key);

  @override
  _LogsPanelState createState() => _LogsPanelState();
}

class _LogsPanelState extends State<LogsPanel> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            //UpperMenu(),
            SizedBox(height: defaultPadding),
            Table(
              columnWidths: {
                0: FlexColumnWidth(2.0),
                1: FlexColumnWidth(2.0),
                2: FlexColumnWidth(4.0),
              },
              children: [
                TableRow(children: [
                  TableCell(child: Text('DATE/TIME')),
                  TableCell(child: Text('EMAIL')),
                  TableCell(child: Text('ACTION')),
                ])
              ],
            ),
            SizedBox(height: defaultPadding),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('$userCompany'+'_logs')
                    .orderBy('datetime', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  return (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data == null)
                      ? new Center(child: CircularProgressIndicator())
                      : Expanded(
                    flex: 0,
                    child: SizedBox(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        separatorBuilder: (context, int) =>
                            SizedBox(height: 15.0),
                        itemBuilder: (context, index) {
                          DocumentSnapshot data =
                          snapshot.data.docs[index];
                          return Table(
                            columnWidths: {
                              0: FlexColumnWidth(2.0),
                              1: FlexColumnWidth(2.0),
                              2: FlexColumnWidth(4.0),
                            },
                            children: [
                              TableRow(children: [
                                TableCell(
                                    child: Text(
                                        data['datetime'].toString())),
                                TableCell(
                                    child:
                                    Text(data['email'].toString())),
                                TableCell(
                                    child: Text(data['text'].toString())),
                              ])
                            ],
                          );
                        },
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
