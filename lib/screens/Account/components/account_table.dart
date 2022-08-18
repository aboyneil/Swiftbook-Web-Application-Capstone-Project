
// import 'package:admin/constants.dart';
// import 'package:admin/data/data.dart';
// import 'package:admin/models/city.dart';
// import 'package:admin/screens/BusDetails/components/popup_Busdetails_form.dart';
// import 'package:flutter/material.dart';

// class AccountTable extends StatefulWidget {
//   @override
//   AccountTableState createState() => AccountTableState();
// }

// class AccountTableState extends State<AccountTable> {
//   bool ascending;

//   @override
//   void initState() {
//     super.initState();

//     ascending = false;
//   }

//   @override
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
        
//       ),
//     );
//   }

//   Widget buildDataTable() => DataTable(
//         headingRowColor:
//         MaterialStateColor.resolveWith((states) => Color(0xFF212332)),
//         sortAscending: ascending,
//         sortColumnIndex: 0,
//         columns: accountColumns
//             .map(
//               (String column) => DataColumn(
//                     label: Text(column),
//                     onSort: (int columnIndex, bool ascending) => onSortColumn(
//                         columnIndex: columnIndex, ascending: ascending),
//                   ),
//             )
//             .toList(),
//         rows: account
//             .map((Account account) => DataRow(
//                   cells: [
//                     DataCell(Text('${account.firstName}')),
//                     DataCell(Text('${account.username}')),
//                     DataCell(Text('${account.email}')),
//                     DataCell(Text('${account.jobAccess}')),
//                     DataCell(
//                       Container(
//                       child: Row(children: [
//                         IconButton(
//                         icon: Icon(Icons.border_color_outlined),
//                         color: Color.fromRGBO(41, 171, 135, 1.0),
//                           onPressed: () async {
                      
//                    final action = await BusDetailsFormDIalog.yesCancelDialog(
//                     context,
//                     'Are you sure you want to add Trip Details?',
//                     'Adding Trip Details');

//                       if (action == DialogsAction.yes) {
//                         } else {
//                       }
//                      },
//                     ),
//                         IconButton(
//                         icon: Icon(Icons.delete_outline_outlined),
//                         color: Color.fromRGBO(220, 20, 60, 1.0),
//                         onPressed: (){},

//                     )
//                     ],
//                     ))),
//                   ],
//                 ))
//             .toList(),
//       );

//   void onSortColumn({int columnIndex, bool ascending}) {
//     if (columnIndex == 0) {
//       setState(() {
//         if (ascending) {
//           cities.sort((a, b) => a.busName.compareTo(b.busName));
//         } else {
//           cities.sort((a, b) => b.busName.compareTo(a.busName));
//         }
//         this.ascending = ascending;
//       });
//     }
//   }
  
//   @override
//   Widget ScrollableWidget({Widget child}) => SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           scrollDirection: Axis.horizontal,
//           child: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           scrollDirection: Axis.vertical,
//              child: buildDataTable(),
//           ),
//         );
// }
