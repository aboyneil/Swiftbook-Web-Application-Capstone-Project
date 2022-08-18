import 'package:meta/meta.dart';

class City {
  final String busName;
  final String plateNumber;
  final String busClass;
  final String busType;
  final String busSeat;
  

  const City({
    @required this.busName,
    @required this.plateNumber,
    @required this.busClass,
    @required this.busType,
    @required this.busSeat,
  });
}


class Account {
  final String username;
  final String email;
  final String firstName;
  final String jobAccess;

  const Account({
    @required this.username,
    @required this.email,
    @required this.firstName,
    @required this.jobAccess,
  });
}

class Logs {
  final String username;
  final String email;
  final String fullName;
  final String busCompany;
  final String dateModified;
  final String description;
  final String jobAccess;

  const Logs({
    @required this.username,
    @required this.email,
    @required this.fullName,
    @required this.busCompany,
    @required this.dateModified,
    @required this.description,
    @required this.jobAccess,
  });

}
