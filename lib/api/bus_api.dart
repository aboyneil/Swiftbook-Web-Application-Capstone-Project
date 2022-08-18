import 'package:admin/globals.dart';
import 'package:admin/models/bus_model.dart';
import 'package:admin/notifier/bus_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

getBus(BusNotifier busNotifier) async{
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('$company'+'_bus').get();

  List<Bus> _busList = [];

  snapshot.docs.forEach((document) {
    Bus bus = Bus.fromMap(document.data());
    _busList.add(bus);
  });
  
  busNotifier.busList = _busList;
}

CollectionReference busCollection =
FirebaseFirestore.instance.collection('$company' + '_bus');

updateBus(Bus bus, bool isUpdating, String updated) async {
  var flag = 0;

  var busSnapshot = await FirebaseFirestore.instance
      .collection('$company' + '_bus')
      .where('Bus Plate Number', isEqualTo: bus.busPlateNumber).get();

  busSnapshot.docs.forEach((res) async {
    docUid = res.id;
    flag = 1;

    await busCollection.doc(docUid).update(bus.toMap());
  });

  var tripSnapshot = await FirebaseFirestore.instance
      .collection('$company' + '_trips')
      .where('Bus Plate Number', isEqualTo: bus.busPlateNumber).get();
  flag = 1;
  tripSnapshot.docs.forEach((res) async{
    docUid = res.id;
    CollectionReference tripCollection =
    FirebaseFirestore.instance.collection('$company' + '_trips');
    await tripCollection.doc(docUid).update(bus.toMap());
  });

  var allTripSnapshot = await FirebaseFirestore.instance
      .collection('all_trips')
      .where('Bus Plate Number', isEqualTo: bus.busPlateNumber).get();
  flag = 1;
  allTripSnapshot.docs.forEach((res) async{
    docUid = res.id;
    CollectionReference tripCollection =
    FirebaseFirestore.instance.collection('all_trips');
    await tripCollection.doc(docUid).update(bus.toMap());
  });
if(flag==1){
  updated = "success";
}
}
addBus(Bus bus, bool isAdded) async{

  await busCollection.add(bus.toMap());
  isAdded = true;

}

deleteBus(Bus bus, Function busDeleted) async {
  var isBook;
  var onTrip;
  final CollectionReference adminCollection =
  FirebaseFirestore.instance.collection('$company' + '_trips');

  QuerySnapshot querySnapshot = await adminCollection.get();

  final CollectionReference bookingsCollection =
  FirebaseFirestore.instance.collection('bookings form');

  QuerySnapshot bookingsSnapshot = await bookingsCollection.get();

  var tripSnapshot = await FirebaseFirestore.instance
      .collection('$company' + '_trips')
      .where('Bus Plate Number', isEqualTo: bus.busPlateNumber).get();

  tripSnapshot.docs.forEach((res) async{
    docUid = res.id;


    for (int i = 0; i < querySnapshot.docs.length; i++) {
      print("First loop here in trips");
      var checkBusPlateNumber = querySnapshot
          .docs[i]
          .get('Bus Plate Number');

      if(bus.busPlateNumber == checkBusPlateNumber) {
        print("Bus Plate number read");
        ticketID = querySnapshot
            .docs[i]
            .get('Trip ID');
        onTrip = true;
        print("TICKET ID:" + '$ticketID');

        for (int i = 0; i < bookingsSnapshot.docs.length; i++) {
          var checkticketID = bookingsSnapshot
              .docs[i]
              .get('Trip ID');

          print("check ticket:"+"$checkticketID");
          if(ticketID == checkticketID) {
            print("Here in booking");
          }
        }

      }
    }
    print("this is ontrip:"+"$onTrip");
    print("this is ontrip:"+"$docUid");
    if(onTrip == true){
      print("I can't delete");
    }else{
      await FirebaseFirestore.instance.collection('$company' + '_bus').doc(docUid).delete();
      busDeleted(bus);
      print("I can delete");
    }

  });


}
