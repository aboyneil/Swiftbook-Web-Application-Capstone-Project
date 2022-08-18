import 'dart:collection';

import 'package:admin/models/bus_model.dart';
import 'package:flutter/cupertino.dart';

class BusNotifier with ChangeNotifier{
  List<Bus> _busList = [];
  Bus _currentBus;

  UnmodifiableListView<Bus> get busList => UnmodifiableListView(_busList);
  
  Bus get currentBus => _currentBus;

  set busList(List<Bus>busList){
    _busList = busList;
    notifyListeners();
  }

  set currentBus(Bus bus){
    _currentBus = bus;
    notifyListeners();
  }
  deleteBus(Bus bus) {
    _busList.removeWhere((_bus) => _bus.busPlateNumber == bus.busPlateNumber);
    notifyListeners();
  }

}