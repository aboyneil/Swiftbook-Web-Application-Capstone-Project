
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirestoreService{
//   FirebaseFirestore db = FirebaseFirestore.instance;


//   //Read data from firestore
//   Stream<List<Bus>> getBus(){
//     return db
//     .collection('cagsawa_bus')
//     .snapshots()
//     .map((snapshot) => snapshot.docs
//     .map((doc) => Bus.fromJson(doc.data()))
//     .toList());
//   }

//   //Update and Insert

//   //Create function, will overwrite anything pass in
//   Future<void> setBus(Bus bus){
//     var options = SetOptions(merge: true);

//     return db
//     .collection('cagsawa_bus')
//     .doc(bus.bus_plate_number)
//     .set(bus.toMap());
//   }

//   //Delete
//   Future<void> removeBus(String bus_plate_number){
//     return db.collection('cagsawa_bus')
//     .doc(bus_plate_number)
//     .delete();
//   }
// }