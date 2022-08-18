class Bus {
  String busClass;
  String busCode;
  String busPlateNumber;
  String busCapacity;
  String busStatus;
  String busType;

  Bus();

  Bus.fromMap(Map<String, dynamic> data) {
    busCode = data['Bus Code'];
    busPlateNumber = data['Bus Plate Number'];
    busClass = data['Bus Class'];
    busCapacity = data['Bus Seat Capacity'];
    busStatus = data['Bus Status'].toString();
    busType = data['Bus Type'];
  }

  Map<String, dynamic> toMap() {
    return {
      'Bus Code': busCode.toUpperCase(),
      'Bus Plate Number': busPlateNumber.toUpperCase(),
      'Bus Class': busClass.toLowerCase(),
      'Bus Seat Capacity': busCapacity,
      'Bus Status': busStatus,
      'Bus Type': busType,
    };
  }
}

final List<String> busDetailsColumns = [
  'Bus Code',
  'Plate Number',
  'Class',
  'Type',
  'Seat Capacity',
  'Status',
  'Action'
];
