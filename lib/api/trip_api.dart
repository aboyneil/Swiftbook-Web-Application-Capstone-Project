import 'package:admin/globals.dart';
import 'package:admin/models/bus_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/trip_model.dart';
import '../notifier/trip_notifier.dart';

getTrip(TripNotifier tripNotifier) async{
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('$company'+'_trip').get();

  List<Trip> _tripList = [];

  snapshot.docs.forEach((document) {
    Trip trip = Trip.fromMap(document.data());
    _tripList.add(trip);
  });

  tripNotifier.tripList = _tripList;
}

CollectionReference busCollection =
FirebaseFirestore.instance.collection('$company' + '_bus');

// updateBus(Bus bus, bool isUpdating, String updated) async {
//   var flag = 0;
//
//   var busSnapshot = await FirebaseFirestore.instance
//       .collection('$company' + '_bus')
//       .where('Bus Plate Number', isEqualTo: bus.busPlateNumber).get();
//
//   busSnapshot.docs.forEach((res) async {
//     docUid = res.id;
//     flag = 1;
//
//     await busCollection.doc(docUid).update(bus.toMap());
//   });
//
//   var tripSnapshot = await FirebaseFirestore.instance
//       .collection('$company' + '_trips')
//       .where('Bus Plate Number', isEqualTo: bus.busPlateNumber).get();
//   flag = 1;
//   tripSnapshot.docs.forEach((res) async{
//     docUid = res.id;
//     CollectionReference tripCollection =
//     FirebaseFirestore.instance.collection('$company' + '_trips');
//     await tripCollection.doc(docUid).update(bus.toMap());
//   });
//
//   var allTripSnapshot = await FirebaseFirestore.instance
//       .collection('all_trips')
//       .where('Bus Plate Number', isEqualTo: bus.busPlateNumber).get();
//   flag = 1;
//   allTripSnapshot.docs.forEach((res) async{
//     docUid = res.id;
//     CollectionReference tripCollection =
//     FirebaseFirestore.instance.collection('all_trips');
//     await tripCollection.doc(docUid).update(bus.toMap());
//   });
//   if(flag==1){
//     updated = "success";
//   }
// }
addBus(Bus bus, bool isAdded) async{

  await busCollection.add(bus.toMap());
  isAdded = true;

}
