
class Trip{
  String origin;
  String destination;
  String deptTime;
  String deptDate;
  String travelStatus;
  // String busClass;
  // String busCode;
  // String busPlateNumber;
  // String busCapacity;
  // String busStatus;
  // String busType;

  Trip();

  Trip.fromMap(Map<String, dynamic> data){
    origin = data['Origin Route'];
    destination = data['Destination Route'];
    deptDate = data['Departure Date'];
    deptTime = data['Departure Time'];
    travelStatus = data['Travel Status'].toString();
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'Bus Code': busCode,
  //     'Bus Plate Number': busPlateNumber,
  //     'Bus Class': busClass,
  //     'Bus Seat Capacity': busCapacity,
  //     'Bus Status': busStatus,
  //     'Bus Type': busType,
  //   };
  // }

}
final List<String> tripDetailsColumns = [
  'Origin',
  'Destination',
  'Departure Date',
  'Time',
  'Travel Status',
  'Action'
];
final List<String> salesDetailsColumns = [
  'Date',
  'Total Sales',
];