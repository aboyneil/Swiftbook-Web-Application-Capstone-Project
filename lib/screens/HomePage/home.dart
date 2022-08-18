import 'dart:js' as js;
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:admin/globals.dart';

import '../../constants.dart';
import '../../responsive.dart';
import 'components/analytic_cards.dart';
import 'components/users_reservation.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService db = DatabaseService();
  @override
  Widget build(BuildContext context) {
    //admins
    Stream<QuerySnapshot> adminsCount() {
      return FirebaseFirestore.instance
          .collection('$company' + '_admins')
          .snapshots();
    }
    //drivers
    Stream<QuerySnapshot> driversCount() {
      return FirebaseFirestore.instance
          .collection('$company' + '_drivers')
          .snapshots();
    }
    //bus
    Stream<QuerySnapshot> busCount() {
      return FirebaseFirestore.instance
          .collection('$company' + '_bus')
          .snapshots();
    }
    //bus class
    Stream<QuerySnapshot> busClassCount() {
      return FirebaseFirestore.instance
          .collection('$company' + '_busClass')
          .snapshots();
    }
    //trips
    Stream<QuerySnapshot> tripsCount() {
      return FirebaseFirestore.instance
          .collection('$company' + '_trips')
          .snapshots();
    }
    //reservations or bookings
    Stream<QuerySnapshot> reservationsCount() {
      return FirebaseFirestore.instance
          .collection('$company' + '_bookingForms')
          .snapshots();
    }
    return Scaffold(
     body: SingleChildScrollView(
       padding: EdgeInsets.all(defaultPadding),
       child: Column(
         children: [
           Header(),
           SizedBox(height: defaultPadding),
           SizedBox(height: defaultPadding),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Expanded(
                 child: Column(
                   children: [
                     AnalyticCards(),
                     SizedBox(
                       height: 15,
                     ),
                     //if (Responsive.isMobile(context)) UsersByDevice(),
                   ],
                 ),
               ),
             ],
           ),
         ],
       ),
     ),
   );
  }
}

// String sentenceCase(String inCaps) {
//   String temp0 = inCaps[0].toUpperCase();
//   String temp1 = inCaps.substring(1).toLowerCase();
//
//   String finalVar = temp0 + temp1;
//
//   return finalVar;
// }
//
// //
// //donwload trip details
// Future<void> downloadTripDetails() async {
//   //get trip details
//   List<String> uidList = [];
//   int i = 0;
//   var result = await FirebaseFirestore.instance
//       .collection('$company' + '_trips')
//       .get();
//   //Insert UIDs to List String
//   result.docs.forEach((res) {
//     uidList.insert(i, res.id);
//     if (i < result.docs.length - 1) {
//       i++;
//     }
//   });
//   var tempArray = [];
//   var array =
//   List.generate(uidList.length, (i) => List(15), growable: false);
//
//   //Get trip details
//   for (int i = 0; i < uidList.length; i++) {
//     //Get Data in Fields
//     var documentData = await FirebaseFirestore.instance
//         .collection('$company' + '_trips')
//         .doc(uidList[i])
//         .get();
//     //Insert data to a temporary Array
//     setState(() {
//       tempArray.insert(0, documentData.get('Company Name'));
//       tempArray.insert(1, documentData.get('Terminal'));
//       tempArray.insert(2, documentData.get('Bus Class'));
//       tempArray.insert(3, documentData.get('Bus Code'));
//       tempArray.insert(4, documentData.get('Bus Driver'));
//       tempArray.insert(5, documentData.get('Bus Seat Capacity'));
//       tempArray.insert(6, documentData.get('Bus Availability Seat'));
//       tempArray.insert(7, documentData.get('Bus Type'));
//       tempArray.insert(8, documentData.get('Departure Date'));
//       tempArray.insert(9, documentData.get('Departure Time'));
//       tempArray.insert(10, documentData.get('Origin Route'));
//       tempArray.insert(11, documentData.get('Destination Route'));
//       tempArray.insert(12, documentData.get('Price Details'));
//       tempArray.insert(13, documentData.get('Travel Status'));
//       tempArray.insert(14, documentData.get('Trip Status'));
//     });
//     for (int j = 0; j < 15; j++) {
//       array[i][j] = tempArray[j].toString();
//     }
//     tempArray.clear();
//     tempArray = [];
//   }
//   print(array);
//
//   for (int i = 0; i < array.length; i++) {
//     for (int j = 0; j < array[i].length; j++) {
//       js.context.callMethod('getCounter', [j]);
//       js.context.callMethod('getList', [array[i][j]]);
//     }
//     js.context.callMethod('listPushClear');
//   }
//   //js.context.callMethod('printData');
//   js.context.callMethod('getCompany', [company.toUpperCase()]);
//   js.context.callMethod('downloadTripDetails');
//   js.context.callMethod('clearAll');
// }
//
// //
// //
// //Download reservation details
// Future<void> downloadReservationDetails() async {
//   //get trip details
//   List<String> uidList = [];
//   int i = 0;
//   var result = await FirebaseFirestore.instance
//       .collection('$company' + '_bookingForms')
//       .get();
//   //Insert UIDs to List String
//   result.docs.forEach((res) {
//     uidList.insert(i, res.id);
//     if (i < result.docs.length - 1) {
//       i++;
//     }
//   });
//   var tempFirstName;
//   var tempLastName;
//   var tempArray = [];
//   var array =
//   List.generate(uidList.length, (i) => List(19), growable: false);
//
//   //Get bus details
//   for (int i = 0; i < uidList.length; i++) {
//     //Get Data in Fields
//     var documentData = await FirebaseFirestore.instance
//         .collection('$company' + '_bookingForms')
//         .doc(uidList[i])
//         .get();
//     //Insert data to a temporary Array
//     setState(() {
//       tempArray.insert(0, documentData.get('Company Name'));
//       tempArray.insert(0, sentenceCase(tempArray[0]));
//       tempArray.insert(1, documentData.get('Terminal Name'));
//       tempFirstName = documentData.get('First Name');
//       tempFirstName = sentenceCase(tempFirstName);
//       tempLastName = documentData.get('Last Name');
//       tempLastName = sentenceCase(tempLastName);
//       tempArray.insert(2, tempFirstName + ' ' + tempLastName);
//       tempArray.insert(3, documentData.get('Email'));
//       tempArray.insert(4, documentData.get('Mobile Num'));
//       tempArray.insert(5, documentData.get('Passenger Category'));
//       tempArray.insert(6, documentData.get('ID'));
//       tempArray.insert(7, documentData.get('Seat Number'));
//       tempArray.insert(8, documentData.get('Percentage Discount'));
//       tempArray.insert(9, documentData.get('Discount'));
//       tempArray.insert(10, documentData.get('Bus Code'));
//       tempArray.insert(11, documentData.get('Bus Class'));
//       tempArray.insert(12, documentData.get('Bus Plate Number'));
//       tempArray.insert(13, documentData.get('Bus Type'));
//       tempArray.insert(14, documentData.get('Origin Route'));
//       tempArray.insert(14, sentenceCase(tempArray[14]));
//       tempArray.insert(15, documentData.get('Destination Route'));
//       tempArray.insert(15, sentenceCase(tempArray[15]));
//       tempArray.insert(16, documentData.get('Departure Date'));
//       tempArray.insert(17, documentData.get('Departure Time'));
//       tempArray.insert(18, documentData.get('Total Price'));
//     });
//     for (int j = 0; j < 19; j++) {
//       array[i][j] = tempArray[j].toString();
//     }
//     tempArray.clear();
//     tempArray = [];
//   }
//   print(array);
//
//   for (int i = 0; i < array.length; i++) {
//     for (int j = 0; j < array[i].length; j++) {
//       js.context.callMethod('getCounter', [j]);
//       js.context.callMethod('getList', [array[i][j]]);
//     }
//     js.context.callMethod('listPushClear');
//   }
//   //js.context.callMethod('printData');
//   js.context.callMethod('getCompany', [company.toUpperCase()]);
//   js.context.callMethod('downloadReservationDetails');
//   js.context.callMethod('clearAll');
// }
//
// //
// return Scaffold(
// body: SingleChildScrollView(
// child: Column(
// children: [
// ElevatedButton(
// child: Text("download trip details"),
// onPressed: () async {
// downloadTripDetails();
// }),
//
// //
// //
// ElevatedButton(
// child: Text("download reservation details"),
// onPressed: () async {
// downloadReservationDetails();
// }),
//
// // ),
//
// //     ElevatedButton(
// //       child: Text('Try', style: TextStyle(fontSize: 20.0),),
// //          onPressed: () =>
// //
// //
// //
// // );
//
// //        File file = /storage/emulated/0/Download/;// generated somewhere
// //        final rawData = file.readAsBytesSync();
// //     final content = base64Encode(rawData);
// // final anchor = AnchorElement(
// //     href: "data:application/octet-stream;charset=utf-16le;base64,$content")
// //   ..setAttribute("download", "file.txt")
// //   ..click();
// //        ),
// ],
// )),