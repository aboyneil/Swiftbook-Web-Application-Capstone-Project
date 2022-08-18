
// import 'package:admin/api/bus_api.dart';
// import 'package:admin/constants.dart';
// import 'package:admin/data/data.dart';
// import 'package:admin/globals.dart';
// import 'package:admin/models/city.dart';
// import 'package:admin/notifier/bus_notifier.dart';
// import 'package:admin/screens/BusDetails/components/popup_Busdetails_form.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

// class DataTableWidget extends StatefulWidget {
//   @override
//   DataTableWidgetState createState() => DataTableWidgetState();
// }

// class DataTableWidgetState extends State<DataTableWidget> {
//   bool ascending;

//   @override
//     @override
//   void initState(){
//   BusNotifier busNotifier = Provider.of<BusNotifier>(this.context, listen: false);
//    getBus(busNotifier);
//    super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//       BusNotifier busNotifier = Provider.of<BusNotifier>(context);
//     // var busProvider = Provider.of<BusProvider>(co
//     // ntext);
//        return Scaffold(
      
//       body:   new Row(
//       children: <Widget>[
//         Expanded(
//           child: SizedBox(
//             height: 200.0,
            
//             child: new  ListView.builder(
//                                   itemBuilder: (BuildContext context, int index){
//                                     return ListTile(
//                                       title: Text(
//                                         busNotifier.busList[index].busClass
//                                         ),
//                                     );
//                                   }, 
                                  
//               ),
//           ),
//         ),
//       ])
      

//     );
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


//   Widget buildDataTable() => Column(
//     children: [
//       Container(

        // child: DataTable(
        //             headingRowColor:
        //             MaterialStateColor.resolveWith((states) => Color(0xFF212332)),
        //             sortAscending: ascending,
        //             sortColumnIndex: 0,
        //             columns: busDetailsColumns
        //                 .map(
        //                   (String column) => DataColumn(
        //                         label: Text(column),
                          
        //                       ),
        //                 )
        //                 .toList(),
        //             rows: busdetails
        //                 .map((BusDetails city) => DataRow(
        //                       cells: [
        //                         DataCell(Text('${city.plateNumber}')),
        //                         DataCell(Text('${city.busClass}')),
        //                         DataCell(Text('${city.busType}')),
        //                         DataCell(Text('${city.busSeat}')),
        //                         DataCell(
        //                           Container(
        //                           child: Row(children: [
        //                             IconButton(
        //                             icon: Icon(Icons.border_color_outlined),
        //                             color: Color.fromRGBO(41, 171, 135, 1.0),
        //                               onPressed: () async {
                                  
                              // final action = await BusDetailsFormDIalog.yesCancelDialog(
                              //   context,
                              //   'Are you sure you want to add Trip Details?',
                              //   'Adding Trip Details');

                              //     if (action == DialogsAction.yes) {
                              //       } else {
                              //     }
                                // },
                                // ),
                                //     IconButton(
                                //     icon: Icon(Icons.delete_outline_outlined),
                                //     color: Color.fromRGBO(220, 20, 60, 1.0),
                                //     onPressed: (){},

                                // )
                  //               ],
                  //               ))),
                  //             ],
                  //           ))
                  //       .toList(),
                  // ))]
                  // );
                

//   void onSortColumn({int columnIndex, bool ascending}) {
//     if (columnIndex == 0) {
//       setState(() {
//         if (ascending) {
//           busdetails.sort((a, b) => a.plateNumber.compareTo(b.plateNumber));
//         } else {
//           busdetails.sort((a, b) => b.plateNumber.compareTo(a.plateNumber));
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
// Column(
//   children: [
//       Container(
    
//         child: DataTable(
//                     headingRowColor:
//                     MaterialStateColor.resolveWith((states) => Color(0xFF212332)),
//                     sortColumnIndex: 0,
//                     columns: busDetailsColumns
//                         .map(
//                           (String column) => DataColumn(
//                                 label: Text(column),
                          
//                               ),
//                         )
//                         .toList(),

//                  rows:  busNotifier.busList[index].busClass
//               .map(
//                 (sale) =>  DataRow(
//                               cells: [
//                                 DataCell(Text('${city.plateNumber}')),
//                                 DataCell(Text('${city.busClass}')),
//                                 DataCell(Text('${city.busType}')),
//                                 DataCell(Text('${city.busSeat}')),
//                                 DataCell(
//                                   Container(
//                                   child: Row(children: [
//                                     IconButton(
//                                     icon: Icon(Icons.border_color_outlined),
//                                     color: Color.fromRGBO(41, 171, 135, 1.0),
//                                       onPressed: () async {
                                  
                              // final action = await BusDetailsFormDIalog.yesCancelDialog(
                              //   context,
                              //   'Are you sure you want to add Trip Details?',
                              //   'Adding Trip Details');

                              //     if (action == DialogsAction.yes) {
                              //       } else {
                              //     }
                               
                                //     IconButton(
                                //     icon: Icon(Icons.delete_outline_outlined),
                                //     color: Color.fromRGBO(220, 20, 60, 1.0),
                                //     onPressed: (){},

                                // )
                                
                        //         ))),
                        //       ],
                        //     ))
                        // .toList(),
                        
        //             rows: List.generate(length, (index) => null)(BuildContext context, (index) =>
        //       DataRow(
        //         cells: <DataCell>[
        //           DataCell(Text(busNotifier.busList[index].busClass)),
        //           DataCell(Text(usersFiltered[index].age.toString())),
        //           DataCell(Text(usersFiltered[index].role)),
        //            ],
        //                         ))),
        //                       ],
        //                     ))
        //                 .toList(),
      //   )
          
      // )]
      //  );