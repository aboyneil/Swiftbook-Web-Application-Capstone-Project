import 'package:admin/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'logs_database.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final LogsService _logs = LogsService();

  //collection reference
  final CollectionReference infoCollection =
      FirebaseFirestore.instance.collection('$company' + '_admins');
  final CollectionReference bookingCollection = FirebaseFirestore.instance
      .collection(company.toString() + '_bookingForms');
  final CollectionReference allBookingCollection =
      FirebaseFirestore.instance.collection('all_bookingForms');
  final CollectionReference tripsCollection =
      FirebaseFirestore.instance.collection('all_trips');
  final CollectionReference companyTripsCollection =
      FirebaseFirestore.instance.collection(company + '_trips');
  final CollectionReference companyBillingCollection = FirebaseFirestore
      .instance
      .collection(company.toString() + '_billingForms');
  final CollectionReference allBillingCollection =
      FirebaseFirestore.instance.collection('all_billingForms');

  //Add Bus Details
  Future<void> addBusWithBaggage() async {
    try {
      busSeatCapacity = (((rightColNumber * rightRowNumber) +
              (leftColNumber * leftRowNumber)) +
          bottomColNumber);
      print(busSeatCapacity);
      seatAvailability = busSeatCapacity;
      for (int i = 0; i < allSeat.length; i++) {
        if (allSeat[i] == 'X' || allSeat[i] == 'x') {
          seatAvailability = busSeatCapacity - 1;
          busSeatCapacity = seatAvailability;
          print("BUS SEAT C:" + "$busSeatCapacity");
        } else {
          seatAvailability = busSeatCapacity;
        }
      }

      CollectionReference busCollection =
          FirebaseFirestore.instance.collection('$company' + '_bus');
      busCollection.add({
        'Right Row Size': rightRowNumber,
        'Right Col Size': rightColNumber,
        'Left Row Size': leftRowNumber,
        'Left Col Size': leftColNumber,
        'Bottom Col Size': bottomColNumber,
        'Right Seat Status': rightSeatStatus,
        'List Right Seat': rightGeneratedSeat,
        'Left Seat Status': leftSeatStatus,
        'List Left Seat': leftGeneratedSeat,
        'List Bottom Seat': bottomGeneratedSeat,
        'Bottom Seat Status': bottomSeatStatus,
        'Bus Code': busCode,
        'Bus Class': busClass,
        'Bus Seat Capacity': busSeatCapacity,
        'Bus Availability Seat': seatAvailability,
        'Bus Type': busType,
        'Bus Plate Number': busPlateNumber,
        'Bus Status': busStatus,
        'Minimum Baggage': minimumBaggage,
        'Maximum Baggage': maximumBaggage,
        'Peso Per Baggage': pesoPerBaggage,
      });
      _logs.addLogs('Added a Bus $busCode');
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> addBusWithoutBaggage() async {
    try {
      busSeatCapacity = (((rightColNumber * rightRowNumber) +
              (leftColNumber * leftRowNumber)) +
          bottomColNumber);
      print(busSeatCapacity);
      seatAvailability = busSeatCapacity;
      for (int i = 0; i < allSeat.length; i++) {
        if (allSeat[i] == 'X' || allSeat[i] == 'x') {
          seatAvailability = busSeatCapacity - 1;
          busSeatCapacity = seatAvailability;
          print("BUS SEAT C:" + "$busSeatCapacity");
        } else {
          seatAvailability = busSeatCapacity;
        }
      }

      CollectionReference busCollection =
          FirebaseFirestore.instance.collection('$company' + '_bus');
      busCollection.add({
        'Right Row Size': rightRowNumber,
        'Right Col Size': rightColNumber,
        'Left Row Size': leftRowNumber,
        'Left Col Size': leftColNumber,
        'Bottom Col Size': bottomColNumber,
        'Right Seat Status': rightSeatStatus,
        'List Right Seat': rightGeneratedSeat,
        'Left Seat Status': leftSeatStatus,
        'List Left Seat': leftGeneratedSeat,
        'List Bottom Seat': bottomGeneratedSeat,
        'Bottom Seat Status': bottomSeatStatus,
        'Bus Code': busCode,
        'Bus Class': busClass,
        'Bus Seat Capacity': busSeatCapacity,
        'Bus Availability Seat': seatAvailability,
        'Bus Type': busType,
        'Bus Plate Number': busPlateNumber,
        'Bus Status': busStatus,
      });
      _logs.addLogs('Added a Bus $busCode');
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> updateBaggage() async {
    try {
      String tempUID;
      var result = await FirebaseFirestore.instance
          .collection('$company' + '_Policies')
          .where('category', isEqualTo: 'baggage')
          .get();

      result.docs.forEach((val) {
        tempUID = val.id;
      });

      CollectionReference bagaggeCollection =
          FirebaseFirestore.instance.collection('$company' + '_Policies');

      bagaggeCollection.doc(tempUID).set({
        'category': 'baggage',
        'status': checkBaggage,
      });
    } catch (e) {}
  }

  Future<void> updateRebooking() async {
    try {
      String tempUID;
      var result = await FirebaseFirestore.instance
          .collection('$company' + '_Policies')
          .where('category', isEqualTo: 'rebooking')
          .get();

      result.docs.forEach((val) {
        tempUID = val.id;
      });

      CollectionReference bagaggeCollection =
          FirebaseFirestore.instance.collection('$company' + '_Policies');

      bagaggeCollection.doc(tempUID).set({
        'category': 'rebooking',
        'fee': feeCategory,
        'status': checkRebooking,
      });
    } catch (e) {}
  }
  Future<void> updateCoupon() async {
    try {
      String tempUID;
      var result = await FirebaseFirestore.instance
          .collection('$company' + '_Policies')
          .where('category', isEqualTo: 'coupon')
          .get();

      result.docs.forEach((val) {
        tempUID = val.id;
      });

      CollectionReference couponCollection =
      FirebaseFirestore.instance.collection('$company' + '_Policies');

      couponCollection.doc(tempUID).set({
        'category': 'coupon',
        'fee': feeCategory,
        'status': checkCoupon,
      });
    } catch (e) {}
  }
  Future<void> updateRefund() async {
    try {
      String tempUID;
      var result = await FirebaseFirestore.instance
          .collection('$company' + '_Policies')
          .where('category', isEqualTo: 'refund')
          .get();

      result.docs.forEach((val) {
        tempUID = val.id;
      });

      CollectionReference couponCollection =
      FirebaseFirestore.instance.collection('$company' + '_Policies');

      couponCollection.doc(tempUID).set({
        'category': 'refund',
        'fee': feeCategory,
        'status': checkRefund,
      });
    } catch (e) {}
  }
  Future updateTrip() async {
    var driverResult = await FirebaseFirestore.instance
        .collection('$company' + '_drivers')
        .where('fullname', isEqualTo: editTripDriver.toLowerCase())
        .get();
    driverResult.docs.forEach((document) {
      driverID = document.id;
    });
    print(editTripBus);
    return await FirebaseFirestore.instance
        .collection('$company' + '_trips')
        .doc(docUid)
        .update({
      'Bus Plate Number': editTripBus,
      'Bus Availability Seat': intAvailabilitySeat,
      'Bus Class': busClass,
      'Bus Code': busCode,
      'Bus Type': busType,
      'Bus Driver' : editTripDriver.toLowerCase(),
      'Driver ID': driverID,
    });
  }
  Future updateAllTrip() async {
    // var driverResult = await FirebaseFirestore.instance
    //     .collection('$company' + '_drivers')
    //     .where('fullname', isEqualTo: busDriver)
    //     .get();
    // driverResult.docs.forEach((document) {
    //   driverID = document.id;
    // });
    // print(driverResult);
    return await FirebaseFirestore.instance
        .collection('all_trips')
        .doc(docUid)
        .update({
      'Bus Plate Number': editTripBus,
      'Bus Availability Seat': intAvailabilitySeat,
      'Bus Class': busClass,
      'Bus Code': busCode,
      'Bus Type': busType,
      'Bus Driver' : editTripDriver.toLowerCase(),
      'Driver ID': driverID,
    });
  }
  Future updateBookingTrip() async {
    return await FirebaseFirestore.instance
        .collection('$company' + '_bookingForms')
        .doc(bookingDocUid)
        .update({
      'Bus Plate Number': editTripBus,
      'Bus Availability Seat': intAvailabilitySeat,
      'Bus Class': busClass,
      'Bus Code': busCode,
      'Bus Type': busType,
    });
  }
  Future updateTripDriver() async {
    return await FirebaseFirestore.instance
        .collection('all_bookingForms')
        .doc(bookingDocUid)
        .update({
      'Bus Plate Number': editTripBus,
      'Bus Availability Seat': intAvailabilitySeat,
      'Bus Class': busClass,
      'Bus Code': busCode,
      'Bus Type': busType,
    });
  }

  //Add Trip Details
  Future addCompanyTrip(String date) async {
    try {
      CollectionReference addTripCollection =
          FirebaseFirestore.instance.collection('$company' + '_trips');
      addTripCollection.add({
        'Company Name': userCompany,
        'Terminal': terminalDescription,
        'Origin Route': originRoutes,
        'Destination Route': destinationRoutes,
        'Bus Plate Number': readBusPlateNumber,
        'Bus Availability Seat': seatAvailability,
        'Bus Code': readBusCode,
        'Bus Class': readBusClass,
        'Bus Type': readBusType,
        'Price Details': priceDetails,
        'Departure Date': date,
        'Departure Time': departureTime,
        'Trip Status': tripStatus,
        'Bus Seat Capacity': intReadBusCapacity,
        'Bus Driver': busDriver,
        'Driver ID': driverID,
        'Trip ID': '',
        'Start Trip DateTime': "",
        'End Trip DateTime': "",
        'Travel Status': 'Upcoming',
        'counter': 1,
        'List Bottom Seat': tripSnapshot.docs[0].get('List Bottom Seat'),
        'Bottom Seat Status': tripSnapshot.docs[0].get('Bottom Seat Status'),
        'List Right Seat': tripSnapshot.docs[0].get('List Right Seat'),
        'Right Seat Status': tripSnapshot.docs[0].get('Right Seat Status'),
        'List Left Seat': tripSnapshot.docs[0].get('List Left Seat'),
        'Left Seat Status': tripSnapshot.docs[0].get('Left Seat Status'),
      });
      _logs.addLogs('Added a Trip $docUid');
    } catch (e) {
      print(e.toString());

      return null;
    }
  }

  Future updateCompanyTripID() async {
    return await FirebaseFirestore.instance
        .collection('$company' + '_trips')
        .doc(docUid)
        .update({'Trip ID': docUid});
  }

  Future updateBusSeat() async {
    busSeatCapacity =
        (((rightColSize * rightRowSize) + (leftColSize * leftRowSize)) +
            bottomColNumber);
    print(busSeatCapacity);
    for (int i = 0; i < allSeat.length; i++) {
      if (allSeat[i] == 'X' || allSeat[i] == 'x') {
        busSeatCapacity = busSeatCapacity - 1;
      }
    }
    return await FirebaseFirestore.instance
        .collection('$company' + '_bus')
        .doc(docUid)
        .update({
      'List Bottom Seat': bottomGeneratedSeat,
      'Bottom Seat Status': bottomSeatStatus,
      'List Left Seat': leftGeneratedSeat,
      'Left Seat Status': leftSeatStatus,
      'List Right Seat': rightGeneratedSeat,
      'Right Seat Status': rightSeatStatus,
      'Bus Seat Capacity': busSeatCapacity,
      'Bus Status': busStatus,
    });
  }

  Future addAllTrip(String date) async {
    try {
      CollectionReference addTripCollection =
          FirebaseFirestore.instance.collection('all_trips');
      addTripCollection.doc(docUid).set({
        'Company Name': userCompany,
        'Terminal': terminalDescription,
        'Origin Route': originRoutes,
        'Destination Route': destinationRoutes,
        'Bus Plate Number': readBusPlateNumber,
        'Bus Availability Seat': seatAvailability,
        'Bus Code': readBusCode,
        'Bus Class': readBusClass,
        'Bus Type': readBusType,
        'Price Details': priceDetails,
        'Departure Date': date,
        'Departure Time': departureTime,
        'Trip Status': tripStatus,
        'Bus Seat Capacity': intReadBusCapacity,
        'Bus Driver': busDriver,
        'Driver ID': driverID,
        'Trip ID': docUid,
        'Start Trip DateTime': "",
        'End Trip DateTime': "",
        'Travel Status': 'Upcoming',
        'counter': 1,
        'List Bottom Seat': tripSnapshot.docs[0].get('List Bottom Seat'),
        'Bottom Seat Status': tripSnapshot.docs[0].get('Bottom Seat Status'),
        'List Right Seat': tripSnapshot.docs[0].get('List Right Seat'),
        'Right Seat Status': tripSnapshot.docs[0].get('Right Seat Status'),
        'List Left Seat': tripSnapshot.docs[0].get('List Left Seat'),
        'Left Seat Status': tripSnapshot.docs[0].get('Left Seat Status'),
      });
    } catch (e) {
      print(e.toString());

      return null;
    }
  }

  //Add New Origin Route to Company Collection and All_Origin Collection
  Future<void> addOrigin() async {
    var result = await FirebaseFirestore.instance
        .collection('$company' + '_origin')
        .where('location', isEqualTo: addNewOrigin.toUpperCase())
        .get();

    if (result.docs.length == 0) {
      CollectionReference addOrigins =
          FirebaseFirestore.instance.collection('$company' + '_origin');
      addOrigins.add({'location': addNewOrigin.toUpperCase()});
      _logs.addLogs('Added an Origin Route $addNewOrigin');
    }

    result = await FirebaseFirestore.instance
        .collection('all_origin')
        .where('location', isEqualTo: addNewOrigin.toUpperCase())
        .get();

    if (result.docs.length == 0) {
      CollectionReference addOrigins =
          FirebaseFirestore.instance.collection('all_origin');
      addOrigins.add({'location': addNewOrigin.toUpperCase()});
    }
  }

  //Add new bus class
  Future<void> addBusClass() async {
    var result = await FirebaseFirestore.instance
        .collection('$company' + '_busClass')
        .where('bus class', isEqualTo: addNewBusClass.toLowerCase())
        .get();

    if (result.docs.length == 0) {
      CollectionReference add_busClass =
          FirebaseFirestore.instance.collection('$company' + '_busClass');
      add_busClass.add({'bus class': addNewBusClass.toLowerCase()});
      _logs.addLogs('Added a Bus Class $addNewBusClass');
    }
  }

  Future<void> addBaggageLimit() async {
    var result = await FirebaseFirestore.instance
        .collection('$company' + '_baggageLimit')
        .where('minimum baggage', isEqualTo: minimumBaggage)
        .where('maximum baggage', isEqualTo: maximumBaggage)
        .where('peso per baggage', isEqualTo: pesoPerBaggage)
        .get();

    if (result.docs.length == 0) {
      CollectionReference addBaggageLimit =
          FirebaseFirestore.instance.collection('$company' + '_baggageLimit');
      addBaggageLimit.add({
        'minimum baggage': minimumBaggage,
        'maximum baggage': maximumBaggage,
        'peso per baggage': pesoPerBaggage,
      });
      _logs.addLogs('Added a Bus Class $addNewBusClass');
    }
  }
  Future addCoupon() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('$company' + '_couponCode')
          .where( 'coupon code', isEqualTo: couponCode.toUpperCase(),)
          .get();

      if (result.docs.length == 0) {
        CollectionReference addCouponCollection = FirebaseFirestore.instance
            .collection('$company' + '_couponCode');
        addCouponCollection.add({
          'coupon code': couponCode.toUpperCase(),
          'discount type': discountType,
          'coupon amount': int.parse(couponAmount),
          'minimum spend': int.parse(minimumSpend),
          'limit user': int.parse(limitUser),
          'limit coupon': int.parse(limitCoupon),
          'counter': int.parse(limitCoupon),
          'start date': startDate,
          'end date': endDate,
        });
      }
    } catch (e) {
      print(e.toString());

      return null;
    }
  }
  Future addSalesByDaily() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('$company' + '_salesByDaily')
          .where( 'date', isEqualTo: salesDate)
          .get();

      if (result.docs.length == 0) {
        CollectionReference addSalesCollection = FirebaseFirestore.instance
            .collection('$company' + '_salesByDaily');

        addSalesCollection.add({
          'date': salesDate,
          'total': salesTotal,
        });
      }else{
        result.docs.forEach((document) {
          docUid = document.id;
          salesTotal = document['total']+salesTotal;
        });
        updateSalesDaily();

        // print(salesTotal);
      }
    } catch (e) {
      print(e.toString());

      return null;
    }
  }
  Future addSalesByMonthly() async {
    try {
      DateTime now = salesMonth;
      String month = '';
      if(now.month == 4){
        month = 'April';
      }
      var tempMonth = now.month;
      var temDay = now.day;
      var tempYear = now.year;
      print(now.month);
  //    DateTime lastDayOfMonth = new DateTime(now.year, now.month + 1, 0);
      // print("${lastDayOfMonth.month}/${lastDayOfMonth.day}");

      print(month);

      var result = await FirebaseFirestore.instance
          .collection('$company' + '_salesByMonthly')
          .where( 'date', isEqualTo: month )
          .get();

      if (result.docs.length == 0) {
         List monthDates = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
        CollectionReference addSalesCollection = FirebaseFirestore.instance
            .collection('$company' + '_salesByMonthly');
          for(int i=0; i<monthDates.length; i++){
            if(month==monthDates[i]){
              addSalesCollection.add({
                'date': monthDates[i],
                'date year': tempYear,
                'index': i,
                'year' : now.year,
                'total': salesTotal,
              });
            }else{
              addSalesCollection.add({
                'date': monthDates[i],
                'date year': tempYear,
                'index': i,
                'year' : now.year,
                'total': 0,
              });
           }
        }
      }else{
        result.docs.forEach((document) {
          docUid = document.id;
          salesTotal = document['total']+salesTotal;
        });
        updateSalesMonthly();
      }
    } catch (e) {
      print(e.toString());

      return null;
    }
  }
  Future updateSalesDaily() async {
    return await FirebaseFirestore.instance
        .collection('$company' + '_salesByDaily')
        .doc(docUid)
        .update({
        'total': salesTotal,
    });
  }
  Future updateSalesMonthly() async {

    return await FirebaseFirestore.instance
        .collection('$company' + '_salesByMonthly')
        .doc(docUid)
        .update({
      'total': salesTotal,
    });
  }
  Future addPriceCategory() async {
    print(addNewPriceCategory);
    print(addNewPriceDiscount);
    try {
      var result = await FirebaseFirestore.instance
          .collection('$company' + '_priceCategories')
          .where('category', isEqualTo: addNewPriceCategory.toUpperCase())
          .get();

      if (result.docs.length == 0) {
        CollectionReference addPriceCollection = FirebaseFirestore.instance
            .collection('$company' + '_priceCategories');
        addPriceCollection.add({
          'category': addNewPriceCategory.toUpperCase(),
          'discount': addNewPriceDiscount,
        });
        _logs.addLogs('Added an Origin Route $addNewPriceCategory');
      }
      // CollectionReference addPriceCollection = FirebaseFirestore.instance
      //     .collection('$company' + '_priceCategories');
      // addPriceCollection.doc(docUid).set({
      //   'category': addNewPriceCategory.toUpperCase(),
      //   'discount': addNewPriceDiscount,
      // });
      // _logs.addLogs('Added an Origin Route $addNewPriceCategory');
    } catch (e) {
      print(e.toString());

      return null;
    }
  }

  Future addDiscountID() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('all_discountIDs')
          .where('full name', isEqualTo: discountIDFullName.toLowerCase())
          .where('email', isEqualTo: discountIDEmail)
          .where('category',
              isEqualTo: selectedDiscountIDCategory.toLowerCase())
          .where('discount ID', isEqualTo: discountID)
          .get();

      if (result.docs.length == 0) {
        CollectionReference addDiscountCollection =
            FirebaseFirestore.instance.collection('all_discountIDs');
        addDiscountCollection.add({
          'full name': discountIDFullName.toLowerCase(),
          'email': discountIDEmail,
          'category': selectedDiscountIDCategory.toLowerCase(),
          'discount ID': discountID
        });
        _logs.addLogs('Added new discount ID $discountID');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //Add New Destination Route to Company Collection and All_Destination Collection
  Future<void> addDestination() async {
    var result = await FirebaseFirestore.instance
        .collection('$company' + '_destination')
        .where('location', isEqualTo: addAddNewDestination.toUpperCase())
        .get();

    if (result.docs.length == 0) {
      CollectionReference addDestination =
          FirebaseFirestore.instance.collection('$company' + '_destination');
      addDestination.add({'location': addAddNewDestination.toUpperCase()});
      _logs.addLogs('Added an Origin Route $addAddNewDestination');
    }

    result = await FirebaseFirestore.instance
        .collection('all_destination')
        .where('location', isEqualTo: addAddNewDestination.toUpperCase())
        .get();

    if (result.docs.length == 0) {
      CollectionReference addOrigins =
          FirebaseFirestore.instance.collection('all_destination');
      addOrigins.add({'location': addAddNewDestination.toUpperCase()});
    }
  }

  //
  Future updateUserdata(String fullname, String email, String username,
      String jobAccess, String company) async {
    return await infoCollection.doc(uid).set({
      'fullname': fullname,
      'email': email,
      'username': username,
      'job_access': jobAccess,
      'company': company,
    });
  }

  Future accRegisterAdmins(
      regEmail, regFullname, regJob_access, regUsername, regUid) async {
    CollectionReference registerAccount =
        FirebaseFirestore.instance.collection('$company' + '_admins');
    registerAccount.doc(regUid).set({
      'company': company.toLowerCase(),
      'email': regEmail,
      'fullname': regFullname.toString().toLowerCase(),
      'job_access': regJob_access.toString().toLowerCase(),
      'username': regUsername,
    });
  }

  Future accRegisterDrivers(
      regEmail, regFullname, regJob_access, regUsername, regUid) async {
    CollectionReference registerAccount =
        FirebaseFirestore.instance.collection('$company' + '_drivers');
    registerAccount.doc(regUid).set({
      'company': company.toLowerCase(),
      'email': regEmail,
      'fullname': regFullname.toString().toLowerCase(),
      'job_access': regJob_access.toString().toLowerCase(),
      'username': regUsername,
    });
  }

  Future accCompany(
      regEmail, regFullname, regJob_access, regUsername, regUid) async {
    CollectionReference registerAccount =
        FirebaseFirestore.instance.collection('$company' + '_accounts');
    registerAccount.doc(regUid).set({
      'company': company.toLowerCase(),
      'email': regEmail,
      'fullname': regFullname.toString().toLowerCase(),
      'job_access': regJob_access.toString().toLowerCase(),
      'username': regUsername,
    });
  }

  Future<void> addCompanyBookingFormDetails(
      tempPassengerType,
      tempFirstName,
      tempLastName,
      tempEmailAddress,
      tempMobileNum,
      tempSelectSeats,
      temporaryDiscount,
      tempPercentageDiscount,
      tempDiscountID,
      tempTicketID) async {
    String storeUid = FirebaseAuth.instance.currentUser.uid.toString();
    bookingCollection.add({
      'UID': storeUid,
      'Trip ID': selectedTripID,
      'Origin Route': selectedOrigin,
      'Destination Route': selectedDestination,
      'Departure Date': selectedDepartureDate,
      'Departure Time': selectedDepartureTime,
      'Bus Type': selectedBusType,
      'Bus Class': selectedBusClass,
      'Company Name': company,
      'Bus Seats': 1,
      'Terminal Name': selectedTerminalName,
      'Bus Code': selectedBusCode,
      'Bus Plate Number': selectedBusPlateNumber,
      'Subtotal': selectedPriceDetails,
      'Discount': temporaryDiscount,
      'Total Price':
          double.parse(selectedPriceDetails) - double.parse(temporaryDiscount),
      'Percentage Discount': tempPercentageDiscount,
      'First Name': tempFirstName.toString().toLowerCase(),
      'Last Name': tempLastName.toString().toLowerCase(),
      'Email': tempEmailAddress,
      'Mobile Num': tempMobileNum,
      'Seat Number': tempSelectSeats,
      'Ticket ID': tempTicketID,
      'Driver ID': selectedDriverID,
      'Booking Status': 'Active',
      'Present': false,
      'Passenger Category': tempPassengerType,
      'ID': tempPercentageDiscount == 0 ? 'none' : tempDiscountID
    });
  }

  Future<void> addAllBookingFormDetails(
      tempPassengerType,
      tempFirstName,
      tempLastName,
      tempEmailAddress,
      tempMobileNum,
      tempSelectSeats,
      temporaryDiscount,
      tempPercentageDiscount,
      tempDiscountID,
      tempTicketID,
      tempdocUID) async {
    String storeUid = FirebaseAuth.instance.currentUser.uid.toString();
    allBookingCollection.doc(tempdocUID).set({
      'UID': storeUid,
      'Trip ID': selectedTripID,
      'Origin Route': selectedOrigin,
      'Destination Route': selectedDestination,
      'Departure Date': selectedDepartureDate,
      'Departure Time': selectedDepartureTime,
      'Bus Type': selectedBusType,
      'Bus Class': selectedBusClass,
      'Company Name': company,
      'Bus Seats': 1,
      'Terminal Name': selectedTerminalName,
      'Bus Code': selectedBusCode,
      'Bus Plate Number': selectedBusPlateNumber,
      'Subtotal': selectedPriceDetails,
      'Discount': temporaryDiscount,
      'Total Price':
          double.parse(selectedPriceDetails) - double.parse(temporaryDiscount),
      'Percentage Discount': tempPercentageDiscount,
      'First Name': tempFirstName.toString().toLowerCase(),
      'Last Name': tempLastName.toString().toLowerCase(),
      'Email': tempEmailAddress,
      'Mobile Num': tempMobileNum,
      'Seat Number': tempSelectSeats,
      'Ticket ID': tempTicketID,
      'Driver ID': selectedDriverID,
      'Booking Status': 'Active',
      'Present': false,
      'Passenger Category': tempPassengerType,
      'ID': tempPercentageDiscount == 0 ? 'none' : tempDiscountID
    });
  }

  Future<void> addCompanyBillingForm(
      tempDiscount, tempSubTotal, tempPriceTotal, tempTixID, tempDate) async {
    companyBillingCollection.add({
      'Name': billingFormName.toString().toUpperCase(),
      'Email': billingFormEmail,
      'Phone Number': billingFormMobileNum,
      'Address': billingFormAddress.toString().toLowerCase(),
      'Date of Payment': tempDate,
      'Mode of Payment': 'Cash',
      'Qty': seatCounter,
      'Discount': tempDiscount,
      'Subtotal': tempSubTotal,
      'Total Price': tempPriceTotal,
      'Ticket ID': tempTixID,
    });
  }

  Future<void> addAllBillingForm(tempDiscount, tempSubTotal, tempPriceTotal,
      tempTixID, tempDate, tempUID) async {

    allBillingCollection.doc(tempUID).set({
      'Name': billingFormName.toString().toUpperCase(),
      'Email': billingFormEmail,
      'Phone Number': billingFormMobileNum,
      'Address': billingFormAddress.toString().toLowerCase(),
      'Date of Payment': tempDate,
      'Mode of Payment': 'Cash',
      'Qty': seatCounter,
      'Discount': tempDiscount,
      'Subtotal': tempSubTotal,
      'Total Price': tempSubTotal,
      'Ticket ID': tempTixID,
    });
  }

  Future updateAllSeatStatus() async {
    return await FirebaseFirestore.instance
        .collection('all_trips')
        .doc(selectedTripID)
        .update({
      'Left Seat Status': updateLeftSeatStatus,
      'Right Seat Status': updateRightSeatStatus,
      'Bottom Seat Status': updateBottomSeatStatus,
    });
  }

  Future updateCompanySeatStatus() async {
    return await FirebaseFirestore.instance
        .collection(company.toString() + '_trips')
        .doc(selectedTripID)
        .update({
      'Left Seat Status': updateLeftSeatStatus,
      'Right Seat Status': updateRightSeatStatus,
      'Bottom Seat Status': updateBottomSeatStatus,
    });
  }

  //update all trips collection
  Future updateBusAvailabilitySeatAllTrips() async {
    return await tripsCollection.doc(selectedTripID).update({
      'Bus Availability Seat':
          int.parse(selectedBusAvailabilitySeat) - seatCounter,
    });
  }

  //update company trips collection
  Future updateBusAvailabilitySeatCompanyTrips() async {
    return await companyTripsCollection.doc(selectedTripID).update({
      'Bus Availability Seat':
          int.parse(selectedBusAvailabilitySeat) - seatCounter,
    });
  }

  Future updateAllTicketCounter() async {
    return await tripsCollection.doc(selectedTripID).update({
      'counter': int.parse(selectedCounter) + seatCounter,
    });
  }

  //update ticket counter - company trips
  Future updateCompanyTicketCounter() async {
    return await companyTripsCollection.doc(selectedTripID).update({
      'counter': int.parse(selectedCounter) + seatCounter,
    });
  }
}
