library swiftbook.globals;

import 'package:flutter/material.dart';

//create account
var fullname;
var email;
var ticketID;
var username;
var job_access;
var company = '';

//Add Bus Details Variable
String busName = '';
String busType = '';
String busCode = '';
String busClass = '';
String busPlateNumber = '';
String busSeatNumber = '';
int busSeatCapacity;
int seatAvailability;
String valueChoose;
int intBusSeatCapacity = 0;
String busTripName = '';
bool busStatus = true;

//edit trips
String editTripBus;
String editTripDriver;
String editDepartureDate;
String bookingDocUid;
String driverDocUid;

//Add New Trip Variable
String tripName = '';
String terminalDescription = '';
String addNewOrigin = '';
String originRoutes;
String busDriver;
String addAddNewDestination = '';
String destinationRoutes;
String priceCategory;
String readBusPlateNumber;
String readBusCapacity = '';
String readBusType = '';
String readBusClass = '';
String readBusCode = '';
String priceDetails = '';
int intPriceDetails = 0;
int intAvailabilitySeat = 0;
List departureDate;
String departureTime = '';
String availabilitySeat = '';
int valLength = 0;
String docUid = '';
bool tripStatus = true;
int intReadBusCapacity = 0;
String driverID = '';

//Account Restiction Variables
String userEmail = '';
String userCompany = '';
String userJobAccess = '';

String buttonFlag = 'No';

String ForgotPass = '';

var busCompanyController = TextEditingController();

String addNewBusClass;
String addNewPriceCategory;
String addNewPriceDiscount;
List tempBusList = [];
List busList = [];

String discountIDFullName;
String discountIDEmail;
String discountID;
String selectedDiscountIDCategory;
String feeCategory;

//Baggage Variables
String minimumBaggage;
String maximumBaggage;
String pesoPerBaggage;
bool checkBaggage = false;
int year;
var finalYear = "2022";
//Coupon Variables
String couponCode;
String discountType = "Fixed Amount";
String couponAmount;
String minimumSpend;
String limitUser;
String limitCoupon;
String startDate = '';
String endDate = '';

//sales
String salesDate = '';
DateTime salesMonth;
double salesTotal;
String dateMonth;
String dateDay;
String dateYear;

bool checkRebooking = false;
bool checkCoupon = false;
bool checkRefund = false;
//Display Trip Details
List tempTripList = [];
List tripList = [];

//Generate Seat
int leftColNumber = 0;
int leftRowNumber = 0;
int rightColNumber = 0;
int rightRowNumber = 0;
int bottomColNumber = 0;

List<GlobalKey<FormState>> bottomFormKeyList =
    List.generate(bottomColNumber, (index) => GlobalKey<FormState>());

List<GlobalKey<FormState>> leftformKeyList = List.generate(
    leftColNumber * leftRowNumber, (index) => GlobalKey<FormState>());

List<GlobalKey<FormState>> rightformKeyList = List.generate(
    rightColNumber * rightRowNumber, (index) => GlobalKey<FormState>());

List rightGeneratedSeat = [];
List leftGeneratedSeat = [];
List rightSeatStatus = [];
List leftSeatStatus = [];
List bottomGeneratedSeat = [];
List bottomSeatStatus = [];

//walk in reservation variable
String selectedDepartureDate;
String selectedDepartureTime;
String selectedTrueDepartureDate;
String selectedTrueDepartureTime;
String selectedTripID;
String selectedOrigin;
String selectedDestination;
String selectedBusType;
String selectedBusClass;
String selectedTerminalName;
String selectedPriceDetails;
String selectedBusCode;
String selectedBusPlateNumber;
String selectedBusSeatCapacity;
String selectedBusAvailabilitySeat;
String selectedTripStatus;
String selectedDriverID;
String selectedCounter;
String selectedPassengerCategory;
String selectedBookingStatus;
String discount;
List tempDiscount = [];
List<String> passengerType = [];
List<String> passengerFirstName = [];
List<String> passengerLastName = [];
List<String> passengerEmailAddress = [];
List<String> passengerMobileNum = [];
List<String> passengerDiscountID = [];
List<String> listDiscount = [];
int seatCounter = 1;
int formKeyListNum = 1;
double totalPrice = 0;
double totalDiscount;
List productDiscount = [];
double paymentprice = 0;
List eachSubTotal = [];
List eachDiscount = [];
int ticketCounter = 0;
List ticketIDList = [];

//walk in generate rows & col - seat
List walkInRightSeatList = [];
List walkInListLeftSeat = [];
List walkInLeftSeatStatus = [];
List walkInRightSeatStatus = [];
List walkInListBottomSeat = [];
List walkInBottomSeatStatus = [];
int leftColSize = 0;
int leftRowSize = 0;
int rightColSize = 0;
int rightRowSize = 0;
int bottomColSize = 0;
List seatNameDropdownItem = [];
List<String> selectedSeats = [];
List allSeat = [];
List allSeatStatus = [];
List seatsName = [];
List seatsNameStatus = [];
List<String> valueList = [];
//String busDocID;
double baseFare = 0;
double subTotal = 0;
double discountPrice = 0;
int percentageDiscount = 0;
int selectedPercentageDiscount;
int seatNumber = 0;

//billing form
var billingFormName;
var billingFormEmail;
var billingFormMobileNum;
var billingFormAddress;
var paymentMode;

//update seat status
List updateLeftSeatStatus = [];
List updateRightSeatStatus = [];
List updateBottomSeatStatus = [];

String busDocID;
var tripSnapshot;
