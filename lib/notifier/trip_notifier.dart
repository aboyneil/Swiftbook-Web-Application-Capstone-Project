import 'dart:collection';
import 'package:flutter/cupertino.dart';

import '../models/trip_model.dart';

class TripNotifier with ChangeNotifier{
  List<Trip> _tripList = [];
  Trip _currentTrip;

  UnmodifiableListView<Trip> get tripList => UnmodifiableListView(_tripList);

  Trip get currentTrip => _currentTrip;

  set tripList(List<Trip>tripList){
    _tripList = tripList;
    notifyListeners();
  }

  set currentBus(Trip trip){
    _currentTrip = trip;
    notifyListeners();
  }
  // deleteBus(Bus bus) {
  //   _busList.removeWhere((_bus) => _bus.busPlateNumber == bus.busPlateNumber);
  //   notifyListeners();
  // }

}