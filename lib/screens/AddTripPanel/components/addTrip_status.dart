import 'dart:html';

import 'package:admin/globals.dart';
import 'package:admin/responsive.dart';
import 'package:admin/routes/routeName.dart';
import 'package:admin/widget/alert_dialog.dart';
import 'package:admin/widget/bus_imgUpload.dart';
import 'package:admin/widget/bus_radioButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:admin/services/database.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';

class AddTripStatus extends StatelessWidget {
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
            "Trip Status",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          BusInfoCard(),
        ],
      ),
    );
  }
}

class BusInfoCard extends StatefulWidget {
  @override
  State<BusInfoCard> createState() => _BusInfoCardState();
}

class _BusInfoCardState extends State<BusInfoCard> {
  @override
  Widget build(BuildContext context) {
    bool tappedYes = false;

    return Container(
        margin: EdgeInsets.only(top: defaultPadding),
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
          borderRadius: const BorderRadius.all(
            Radius.circular(defaultPadding),
          ),
        ),
        child: Column(
          children: [
            RadioButtonGroupWidget(),
            // ElevatedButton.icon(
            //   style: TextButton.styleFrom(
            //     backgroundColor: primaryColor,
            //     padding: EdgeInsets.symmetric(
            //       horizontal: defaultPadding * 1.5,
            //       vertical:
            //           defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
            //     ),
            //   ),
            //   onPressed: () async {
            //     final action = await AlertDialogs.yesCancelDialog(
            //         context,
            //         'Are you sure you want to add Trip Details?',
            //         'Adding Trip Details');
            //
            //     var dbResult = await FirebaseFirestore.instance
            //         .collection('$company' + '_drivers')
            //         .where('fullname', isEqualTo: busDriver)
            //         .get();
            //
            //     dbResult.docs.forEach((val) {
            //       driverID = val.id.toString();
            //     });
            //
            //     print(driverID);
            //
            //     if (action == DialogsAction.yes) {
            //       //
            //       //check fields
            //       if (terminalDescription == null ||
            //           originRoutes == null ||
            //           destinationRoutes == null ||
            //           readBusPlateNumber == null ||
            //           intAvailabilitySeat == null ||
            //           readBusCode == null ||
            //           readBusClass == null ||
            //           readBusType == null ||
            //           priceDetails == null ||
            //           departureDate == null ||
            //           departureTime == null ||
            //           readBusCapacity == null ||
            //           busDriver == null) {
            //         await AlertDialogs.ErroralertDialog(context);
            //       } else {
            //         //Execute
            //         //
            //         //
            //         bool checkerDate;
            //         var now = DateTime.now();
            //         for (int i = 0; i < departureDate.length; i++) {
            //           if (now.isAfter(departureDate[i])) {
            //             checkerDate = true;
            //             break;
            //           } else
            //             checkerDate = false;
            //         }
            //         if (checkerDate == true) {
            //           await AlertDialogs.errorDate(context);
            //         } else {
            //           try {
            //             intBusSeatNumber = int.parse(readBusCapacity);
            //             intAvailabilitySeat = int.parse(availabilitySeat);
            //             intPriceDetails = int.parse(priceDetails);
            //             intReadBusCapacity = int.parse(readBusCapacity);
            //
            //             //
            //             List dateExist = [];
            //             int counter = 0;
            //             //Check if trip already exist
            //             for (int i = 0; i < valLength; i++) {
            //               String tempDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            //                   .format(departureDate[i]);
            //               var dbResult = await FirebaseFirestore.instance
            //                   .collection('$company' + '_trips')
            //                   .where('Terminal', isEqualTo: terminalDescription)
            //                   .where('Origin Route', isEqualTo: originRoutes)
            //                   .where('Destination Route',
            //                       isEqualTo: destinationRoutes)
            //                   .where('Bus Plate Number',
            //                       isEqualTo: readBusPlateNumber)
            //                   .where('Bus Availability Seat',
            //                       isEqualTo: intAvailabilitySeat)
            //                   .where('Bus Code', isEqualTo: readBusCode)
            //                   .where('Bus Class', isEqualTo: readBusClass)
            //                   .where('Bus Type', isEqualTo: readBusType)
            //                   .where('Price Details', isEqualTo: priceDetails)
            //                   .where('Departure Date', isEqualTo: tempDate)
            //                   .where('Departure Time', isEqualTo: departureTime)
            //                   .where('Trip Status', isEqualTo: tripStatus)
            //                   .where('Bus Seat Capacity',
            //                       isEqualTo: intReadBusCapacity)
            //                   .where('Bus Driver',
            //                       isEqualTo: busDriver.toLowerCase())
            //                   .where('Driver ID', isEqualTo: driverID)
            //                   .get();
            //
            //               if (dbResult.docs.length != 0) {
            //                 dateExist.insert(counter, tempDate);
            //                 counter++;
            //               }
            //             }
            //             if (dateExist.length != 0) {
            //               print(dateExist.length);
            //               await AlertDialogs.errorAddTrip(context);
            //             } else {
            //               //
            //               //Add Trip to Database
            //               for (int i = 0; i < valLength; i++) {
            //                 String tempDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            //                     .format(departureDate[i]);
            //                 db.addCompanyTrip(tempDate);
            //
            //                 //To get the document ID
            //                 var result = await FirebaseFirestore.instance
            //                     .collection('$company' + '_trips')
            //                     .where('Terminal',
            //                         isEqualTo: terminalDescription)
            //                     .where('Origin Route', isEqualTo: originRoutes)
            //                     .where('Destination Route',
            //                         isEqualTo: destinationRoutes)
            //                     .where('Bus Plate Number',
            //                         isEqualTo: readBusPlateNumber)
            //                     .where('Bus Availability Seat',
            //                         isEqualTo: intAvailabilitySeat)
            //                     .where('Bus Code', isEqualTo: readBusCode)
            //                     .where('Bus Class', isEqualTo: readBusClass)
            //                     .where('Bus Type', isEqualTo: readBusType)
            //                     .where('Price Details', isEqualTo: priceDetails)
            //                     .where('Departure Date', isEqualTo: tempDate)
            //                     .where('Departure Time',
            //                         isEqualTo: departureTime)
            //                     .where('Trip Status', isEqualTo: tripStatus)
            //                     .where('Bus Seat Capacity',
            //                         isEqualTo: intReadBusCapacity)
            //                     .where('Bus Driver',
            //                         isEqualTo: busDriver.toLowerCase())
            //                     .where('Driver ID', isEqualTo: driverID)
            //                     .get();
            //
            //                 result.docs.forEach((res) {
            //                   docUid = res.id;
            //                   //
            //                   //Add to All Trips
            //                   db.addAllTrip(tempDate);
            //                   db.updateCompanyTripID();
            //                 });
            //               }
            //               await AlertDialogs.successDialog(
            //                   context, 'You successfully added a trip!', '');
            //             }
            //
            //             dateExist.clear();
            //             checkerDate = null;
            //             now = null;
            //             counter = 0;
            //             tripName = null;
            //             terminalDescription = null;
            //             addNewOrigin = null;
            //             busDriver = null;
            //             addAddNewDestination = null;
            //             priceCategory = null;
            //             readBusPlateNumber = null;
            //             readBusCapacity = null;
            //             readBusType = null;
            //             readBusClass = null;
            //             readBusCode = null;
            //             priceDetails = null;
            //             intPriceDetails = 0;
            //             intAvailabilitySeat = 0;
            //             departureTime = null;
            //             availabilitySeat = null;
            //             intReadBusCapacity = 0;
            //             driverID = null;
            //             navKey.currentState.pushNamed(routeAddTrip);
            //           } catch (e) {
            //             print(e.toString());
            //             await AlertDialogs.ErroralertDialog(
            //               context,
            //             );
            //             return null;
            //           }
            //
            //           tappedYes = true;
            //         }
            //       }
            //     } else {
            //       tappedYes = false;
            //     }
            //   },
            //   icon: Icon(Icons.add),
            //   label: Text("Add Trip"),
            // ),
          ],
        ));
  }
}
