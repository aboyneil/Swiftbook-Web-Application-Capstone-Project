import 'package:admin/constants.dart';
import 'package:admin/globals.dart';
import 'package:admin/screens/AddTripPanel/components/checkBoxState.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/widget/date_time_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../responsive.dart';
import '../../routes/routeName.dart';
import '../../services/database.dart';
import '../../widget/alert_dialog.dart';
import 'components/addTrip_field_details.dart';
import 'components/addTrip_status.dart';

class AddTripPanelPage extends StatefulWidget {
  @override
  _AddTripPanelPageState createState() => _AddTripPanelPageState();
}

class _AddTripPanelPageState extends State<AddTripPanelPage> {
  final DatabaseService db = DatabaseService();

  //toggle button
  List<bool> isSelected = [false, false];
  int selectedToggle = 0; //0 for none(default), 1 for multi, 2 for rotational
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  int difference = 0;
  String _rangeCount = '';
  String stringDate = '';
  String startDate = '';
  var flag = false;
  String endDate = '';
  DateTime start;
  DateTime end;
  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  var listDate = ['MO', 'SU'];

  final weekList = [
    CheckBoxState(title: 'Sunday'),
    CheckBoxState(title: 'Monday'),
    CheckBoxState(title: 'Tuesday'),
    CheckBoxState(title: 'Wednesday'),
    CheckBoxState(title: 'Thursday'),
    CheckBoxState(title: 'Friday'),
    CheckBoxState(title: 'Saturday'),
  ];

  List<String> selectedDays = [];
  var distinctSelectedDays;

  @override
  Widget build(BuildContext context) {
    //print(selectedDays.toSet());
    distinctSelectedDays = selectedDays.toSet().toList();
    print(distinctSelectedDays);
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: defaultPadding),
                          AddTripBusDetails(),
                          Text(
                            "Schedule Details",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          //toggle button
                          SizedBox(height: defaultPadding),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 0),
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Select Time Departure",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  SizedBox(height: defaultPadding),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 16),
                                    child: DateTimePicker(),
                                  ),
                                  SizedBox(height: defaultPadding),
                                  //checkbox
                                  Column(
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // ...weekList.map(buildSingleCheckbox)
                                      //     .toList(),
                                    ],
                                  ),
                                  SizedBox(height: defaultPadding),
                                  SizedBox(height: defaultPadding),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5,
                                      top: 5,
                                    ),
                                    child: Text(
                                      "Calendar Type",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ),
                                  SizedBox(height: defaultPadding),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 10),
                                          child: ToggleButtons(
                                            children: <Widget>[
                                              //fix padding sizing
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 120,
                                                    vertical: 8),
                                                child: Text(
                                                  "Multi",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1,
                                                ),
                                              ),
                                              //fix padding sizing
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 120,
                                                    vertical: 8),
                                                child: Text(
                                                  "Rotational",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1,
                                                ),
                                              ),
                                            ],
                                            isSelected: isSelected,
                                            onPressed: (int index) {
                                              setState(() {
                                                for (int indexBtn = 0;
                                                    indexBtn <
                                                        isSelected.length;
                                                    indexBtn++) {
                                                  if (indexBtn == index) {
                                                    isSelected[indexBtn] = true;
                                                  } else {
                                                    isSelected[indexBtn] =
                                                        false;
                                                  }
                                                }
                                                // [0] - multi
                                                // [1] - rotational
                                                if (isSelected[0] == true) {
                                                  selectedToggle = 1;
                                                } else if (isSelected[1] ==
                                                    true) {
                                                  selectedToggle = 2;
                                                } else {
                                                  selectedToggle = 0;
                                                }

                                                print(selectedToggle);
                                              });
                                            },
                                            constraints: BoxConstraints(
                                                minWidth: 25, minHeight: 4.5),
                                            color: Color.fromRGBO(
                                                112, 112, 112, 1.0),
                                            selectedColor: Colors.white,
                                            fillColor: Colors.grey,
                                            //borderColor: Colors.transparent,
                                            borderColor:
                                                Colors.grey.withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            selectedBorderColor: Colors.grey,
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 1),
                                ]),
                          ),
                          //toggle button result condition
                          // if toggle is 1 or multi
                          selectedToggle == 1
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 16),
                                      child: SfDateRangePicker(
                                        view: DateRangePickerView.month,
                                        selectionMode:
                                            DateRangePickerSelectionMode
                                                .multiple,
                                        onSelectionChanged: _onSelectionChanged,
                                      ),
                                    ),
                                  ],
                                )
                              // if toggle is 2 or rotational
                              : selectedToggle == 2
                                  ? Column(
                                      children: [
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                                '*Please choose days this trip will be available')),
                                        ...weekList
                                            .map(buildSingleCheckbox)
                                            .toList(),
                                        SizedBox(height: defaultPadding),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                                '*Rotational will only allow 30 days from start to end date')),
                                        datePicker(),
                                        SizedBox(height: defaultPadding),
                                        // ignore: missing_required_param
                                        ElevatedButton(onPressed: () {
                                          setState(() {
                                            difference =
                                                daysBetween(start, end);
                                          });
                                        }),
                                        if (difference <= 30 && difference != 0)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 16),
                                            child: SfCalendar(
                                              view: CalendarView.week,
                                              specialRegions: _getTimeRegions(),
                                              showDatePickerButton: true,
                                            ),
                                          ),
                                        if (difference == 0)
                                          Text(
                                              "Please Select start date and end date"),
                                        if (difference > 30)
                                          Text(
                                              "Start and End date intervals should not be higher than 30 days",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.redAccent)),
                                      ],
                                    )
                                  // if toggle is 0 or none
                                  : Center(
                                      child: Container(
                                        child: Text(
                                          'Select Trip Schedule',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                      ),
                                    ),
                          AddTripStatus(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              style: TextButton.styleFrom(
                                backgroundColor: primaryColor,
                                padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding * 1.5,
                                  vertical: defaultPadding /
                                      (Responsive.isMobile(context) ? 2 : 1),
                                ),
                              ),
                              onPressed: () async {
                                final action = await AlertDialogs.yesCancelDialog(
                                    context,
                                    'Are you sure you want to add Trip Details?',
                                    'Adding Trip Details');

                                var dbResult = await FirebaseFirestore.instance
                                    .collection('$company' + '_drivers')
                                    .where('fullname', isEqualTo: busDriver)
                                    .get();

                                dbResult.docs.forEach((val) {
                                  driverID = val.id.toString();
                                });

                                if (action == DialogsAction.yes) {
                                  //
                                  print("Origin:" + "$originRoutes");
                                  print("Dest:" + "$destinationRoutes");
                                  print("Plate:" + "$readBusPlateNumber");
                                  print("Availability:" + "$seatAvailability");
                                  print("Class:" + "$readBusClass");
                                  print("Code:" + "$readBusCode");
                                  print("Type:" + "$readBusType");
                                  print("price:" + "$priceDetails");
                                  print("Date:" + "$departureDate");
                                  print("Time:" + "$departureTime");
                                  print("capacity:" + "$readBusCapacity");
                                  print("Driver:" + "$busDriver");

                                  //check fields
                                  if (terminalDescription == null ||
                                      originRoutes == null ||
                                      destinationRoutes == null ||
                                      readBusPlateNumber == null ||
                                      seatAvailability == null ||
                                      readBusCode == null ||
                                      readBusClass == null ||
                                      readBusType == null ||
                                      priceDetails == null ||
                                      departureDate == null ||
                                      departureTime == null ||
                                      readBusCapacity == null ||
                                      busDriver == null) {
                                    await AlertDialogs.ErroralertDialog(
                                        context);
                                  } else {
                                    //Execute
                                    bool checkerDate;
                                    var now = DateTime.now();
                                    for (int i = 0;
                                        i < departureDate.length;
                                        i++) {
                                      if (now.isAfter(departureDate[i])) {
                                        checkerDate = true;
                                        break;
                                      } else
                                        checkerDate = false;
                                    }
                                    if (checkerDate == true) {
                                      await AlertDialogs.errorDate(context);
                                    } else {
                                      try {
                                        //intBusSeatNumber = int.parse(readBusCapacity);
                                        // intAvailabilitySeat =
                                        //     int.parse(availabilitySeat);
                                        intPriceDetails =
                                            int.parse(priceDetails);
                                        intReadBusCapacity =
                                            int.parse(readBusCapacity);

                                        //
                                        List dateExist = [];
                                        int counter = 0;
                                        //Check if trip already exist
                                        for (int i = 0; i < valLength; i++) {
                                          String tempDate =
                                              DateFormat("yyyy-MM-dd HH:mm:ss")
                                                  .format(departureDate[i]);
                                          var dbResult = await FirebaseFirestore
                                              .instance
                                              .collection('$company' + '_trips')
                                              .where('Terminal',
                                                  isEqualTo:
                                                      terminalDescription)
                                              .where('Origin Route',
                                                  isEqualTo: originRoutes)
                                              .where('Destination Route',
                                                  isEqualTo: destinationRoutes)
                                              .where('Bus Plate Number',
                                                  isEqualTo: readBusPlateNumber)
                                              .where('Bus Availability Seat',
                                                  isEqualTo: seatAvailability)
                                              .where('Bus Code',
                                                  isEqualTo: readBusCode)
                                              .where('Bus Class',
                                                  isEqualTo: readBusClass)
                                              .where('Bus Type',
                                                  isEqualTo: readBusType)
                                              .where('Price Details',
                                                  isEqualTo: priceDetails)
                                              .where('Departure Date',
                                                  isEqualTo: tempDate)
                                              .where('Departure Time',
                                                  isEqualTo: departureTime)
                                              .where('Trip Status',
                                                  isEqualTo: tripStatus)
                                              .where('Bus Seat Capacity',
                                                  isEqualTo: intReadBusCapacity)
                                              .where('Bus Driver',
                                                  isEqualTo:
                                                      busDriver.toLowerCase())
                                              .where('Driver ID',
                                                  isEqualTo: driverID)
                                              .get();

                                          if (dbResult.docs.length != 0) {
                                            dateExist.insert(counter, tempDate);
                                            counter++;
                                          }
                                        }
                                        if (dateExist.length != 0) {
                                          print(dateExist.length);
                                          await AlertDialogs.errorAddTrip(
                                              context);
                                        } else {
                                          //Add Trip to Database
                                          for (int i = 0; i < valLength; i++) {
                                            String tempDate = DateFormat(
                                                    "yyyy-MM-dd HH:mm:ss")
                                                .format(departureDate[i]);
                                            //Read list data
                                            tripSnapshot =
                                                await FirebaseFirestore.instance
                                                    .collection(
                                                        '$company' + '_bus')
                                                    .where('Bus Plate Number',
                                                        isEqualTo:
                                                            readBusPlateNumber)
                                                    .get();
                                            db.addCompanyTrip(tempDate);

                                            //To get the document ID
                                            var result = await FirebaseFirestore
                                                .instance
                                                .collection(
                                                    '$company' + '_trips')
                                                .where('Terminal',
                                                    isEqualTo:
                                                        terminalDescription)
                                                .where('Origin Route',
                                                    isEqualTo: originRoutes)
                                                .where('Destination Route',
                                                    isEqualTo:
                                                        destinationRoutes)
                                                .where('Bus Plate Number',
                                                    isEqualTo:
                                                        readBusPlateNumber)
                                                .where('Bus Availability Seat',
                                                    isEqualTo: seatAvailability)
                                                .where('Bus Code',
                                                    isEqualTo: readBusCode)
                                                .where('Bus Class',
                                                    isEqualTo: readBusClass)
                                                .where('Bus Type',
                                                    isEqualTo: readBusType)
                                                .where('Price Details',
                                                    isEqualTo: priceDetails)
                                                .where('Departure Date',
                                                    isEqualTo: tempDate)
                                                .where('Departure Time',
                                                    isEqualTo: departureTime)
                                                .where('Bus Seat Capacity',
                                                    isEqualTo:
                                                        intReadBusCapacity)
                                                .where('Bus Driver',
                                                    isEqualTo: busDriver)
                                                .where('Driver ID',
                                                    isEqualTo: driverID)
                                                .get();

                                            result.docs.forEach((val) {
                                              docUid = val.id;
                                            });
                                            print('DOC UID = ' + docUid);
                                            //Add to All Trips

                                            await db.addAllTrip(tempDate);
                                            await db.updateCompanyTripID();
                                          }

                                          await AlertDialogs.successDialog(
                                              context,
                                              'You successfully added a trip!',
                                              '');
                                        }

                                        dateExist.clear();
                                        checkerDate = null;
                                        now = null;
                                        counter = 0;
                                        tripName = null;
                                        terminalDescription = null;
                                        addNewOrigin = null;
                                        busDriver = null;
                                        addAddNewDestination = null;
                                        priceCategory = null;
                                        readBusPlateNumber = null;
                                        readBusCapacity = null;
                                        readBusType = null;
                                        readBusClass = null;
                                        readBusCode = null;
                                        priceDetails = null;
                                        intPriceDetails = 0;
                                        intAvailabilitySeat = 0;
                                        departureTime = null;
                                        availabilitySeat = null;
                                        intReadBusCapacity = 0;
                                        driverID = null;
                                        navKey.currentState
                                            .pushNamed(routeAddTrip);
                                      } catch (e) {
                                        print(e.toString());
                                        await AlertDialogs.ErroralertDialog(
                                          context,
                                        );
                                        return null;
                                      }
                                    }
                                  }
                                }
                              },
                              icon: Icon(Icons.add),
                              label: Text("Add Trip"),
                            ),
                          ),
                          // if (Responsive.isMobile(context))
                          //   SizedBox(height: defaultPadding),
                          // if (Responsive.isMobile(context)) AddTripStatus(),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }

  Widget buildSingleCheckbox(CheckBoxState checkbox) => ListView(
        shrinkWrap: true,
        children: [
          CheckboxListTile(
              activeColor: Colors.green,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                checkbox.title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              value: checkbox.value,
              onChanged: (value) {
                setState(() {
                  checkbox.value = value;
                  var command = '';
                  command = checkbox.title.toString();
                  switch (command) {
                    case 'Sunday':
                      stringDate = "SU";
                      break;
                    case 'Monday':
                      stringDate = "MO";
                      break;
                    case 'Tuesday':
                      stringDate = "TU";
                      break;
                    case 'Thursday':
                      stringDate = "TH";
                      break;
                    case 'Wednesday':
                      stringDate = "WE";
                      break;
                    case 'Friday':
                      stringDate = "FR";
                      break;
                    case 'Saturday':
                      stringDate = "SA";
                      break;
                  }
                  if (checkbox.value == true) {
                    selectedDays.add(stringDate);
                  } else if (checkbox.value == false) {
                    selectedDays.remove(stringDate);
                  }
                });
              }),
        ],
      );

  List<TimeRegion> _getTimeRegions() {
    final List<TimeRegion> regions = <TimeRegion>[];
    String formattedDate = DateFormat('yyyyMMdd').format(end);
    String startformatted = DateFormat('yyyyMMdd').format(start);
    print(start);
    regions.add(TimeRegion(
        startTime: start,
        endTime: start.add(Duration(hours: 1)),
        enablePointerInteraction: false,
        recurrenceRule:
            'FREQ=WEEKLY;INTERVAL=1;BYDAY=$distinctSelectedDays;UNTIL=$formattedDate',
        textStyle: TextStyle(color: Colors.white, fontSize: 15),
        color: Colors.teal,
        // recurrenceExceptionDates: [DateTime.now().add(Duration(days: 30))],
        text: 'Trip'));
    List<DateTime> dateCollection = SfCalendar.getRecurrenceDateTimeCollection(
        'FREQ=WEEKLY;INTERVAL=1;BYDAY=$distinctSelectedDays;UNTIL=$formattedDate',
        start);
    departureDate = dateCollection;
    valLength = departureDate.length;
    print(departureDate);
    return regions;
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
      departureDate = args.value;
      valLength = departureDate.length;
      print(departureDate);
    });
  }

  Widget datePicker() => Container(
          child: Column(
        children: [
          Center(
              child: TextField(
            controller: startDateInput,
            //editing controller TextField
            decoration: InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: "Select Start Date"),
            readOnly: true,
            //set it true, so that user will not able to edit text
            onTap: () async {
              start = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101));

              if (start != null) {
                //print(pickedDate); //pickedDate output
                startDate = DateFormat('yyyy-MM-dd').format(start);

                setState(() {
                  startDateInput.text = startDate;
                  print("Start Date:" +
                      '$startDate'); //set output date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
          )),
          Center(
              child: TextField(
            controller: endDateInput,
            //editing controller TextField
            decoration: InputDecoration(
                icon: Icon(Icons.calendar_today), labelText: "Select End Date"),
            readOnly: true,
            //set it true, so that user will not able to edit text
            onTap: () async {
              end = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101));

              if (end != null) {
                //print(pickedDate); //pickedDate output
                endDate = DateFormat('yyyy-MM-dd').format(end);

                setState(() {
                  endDateInput.text = endDate;
                  print("End Date:" +
                      '$endDate'); //set output date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
          )),
        ],
      ));

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text("Loading"),
            ],
          ),
        );
      },
    );
    // new Future.delayed(new Duration(seconds: 3), () {
    //   Navigator.pop(context); //pop dialog
    //   navKey.currentState
    //       .pushNamed(routeAddTrip);
    // });
  }
}
