// //
// // import 'package:admin/constants.dart';
// // import 'package:admin/data/data.dart';
// // import 'package:admin/models/city.dart';
// // import 'package:flutter/material.dart';
// //
// // class LogsTable extends StatefulWidget {
// //   @override
// //   LogsTableState createState() => LogsTableState();
// // }
// //
// // class LogsTableState extends State<LogsTable> {
// //   bool ascending;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     ascending = false;
// //   }
// //
// //   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.topLeft,
//       child: Container(
//         padding: EdgeInsets.all(defaultPadding),
//           decoration: BoxDecoration(
//             color: secondaryColor,
//             borderRadius: const BorderRadius.all(Radius.circular(10)),
//           ),
//         child: ScrollableWidget(),
//
//       ),
//     );
//   }
// //
// //   Widget buildDataTable() => DataTable(
// //         headingRowColor:
// //         MaterialStateColor.resolveWith((states) => Color(0xFF212332)),
// //         sortAscending: ascending,
// //         sortColumnIndex: 0,
// //         columns: logsColumns
// //             .map(
// //               (String column) => DataColumn(
// //                     label: Text(column),
// //                     onSort: (int columnIndex, bool ascending) => onSortColumn(
// //                         columnIndex: columnIndex, ascending: ascending),
// //                   ),
// //             )
// //             .toList(),
// //         rows: logs
// //             .map((Logs logs) => DataRow(
// //                   cells: [
// //                     DataCell(Text('${logs.dateModified}')),
// //                     DataCell(Text('${logs.username}')),
// //                     DataCell(Text('${logs.jobAccess}')),
// //                     DataCell(Text('${logs.description}')),
// //                     DataCell(
// //                       Container(
// //                       child: Row(children: [
// //                         IconButton(
// //                         icon: Icon(Icons.remove_red_eye_outlined),
// //                         color: Color.fromRGBO(41, 171, 135, 1.0),
// //                           onPressed: () async {
// //
// //                    final action = await BusDetailsFormDIalog.yesCancelDialog(
// //                     context,
// //                     'On THE PROCESS',
// //                     'FURTHER DETAILS');
// //
// //                       if (action == DialogsAction.yes) {
// //                         } else {
// //                       }
// //                      },
// //                     ),
// //
// //                     ],
// //                     ))),
// //                   ],
// //                 ))
// //             .toList(),
// //       );
// //
// //   void onSortColumn({int columnIndex, bool ascending}) {
// //     if (columnIndex == 0) {
// //       setState(() {
// //         if (ascending) {
// //           cities.sort((a, b) => a.busName.compareTo(b.busName));
// //         } else {
// //           cities.sort((a, b) => b.busName.compareTo(a.busName));
// //         }
// //         this.ascending = ascending;
// //       });
// //     }
// //   }
// //
// //   @override
// //   Widget ScrollableWidget({Widget child}) => SingleChildScrollView(
// //           physics: BouncingScrollPhysics(),
// //           scrollDirection: Axis.horizontal,
// //           child: SingleChildScrollView(
// //           physics: BouncingScrollPhysics(),
// //           scrollDirection: Axis.vertical,
// //              child: buildDataTable(),
// //           ),
// //         );
// // }
