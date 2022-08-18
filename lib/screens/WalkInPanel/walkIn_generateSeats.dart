import 'package:admin/screens/WalkInPanel/walkIn_billingForm.dart';
import 'package:admin/screens/WalkInPanel/walkIn_passengerForm.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../globals.dart';
import '../../responsive.dart';

class WalkInGenerateSeats extends StatefulWidget {
  const WalkInGenerateSeats({Key key}) : super(key: key);

  @override
  _WalkInGenerateSeatsState createState() => _WalkInGenerateSeatsState();
}

class _WalkInGenerateSeatsState extends State<WalkInGenerateSeats> {
  final List<GlobalKey<FormState>> formKeyList =
      List.generate(seatCounter, (index) => GlobalKey<FormState>());

  int j = 0;
  int k = 0;
  int m = 0;

  String error = '';

  @override
  Widget build(BuildContext context) {
    print('***WALK IN GENERATE SEATS***');
    print('Seats: ' + '$seatCounter');
    //print('***Generate Rows & Col***');
    print('Left Col Size: ' + '$leftColSize');
    print('Left Row Size: ' + '$leftRowSize');
    print('Right Col Size: ' + '$rightColSize');
    print('Right Row Size: ' + '$rightRowSize');
    print('List Right Seat: ' + walkInRightSeatList.toString());
    print('Right Seat Status: ' + walkInRightSeatStatus.toString());
    print('List Left Seat: ' + walkInListLeftSeat.toString());
    print('Left Seat Status: ' + walkInLeftSeatStatus.toString());
    print('List Bottom Seat: ' + walkInListBottomSeat.toString());
    print('Bottom Seat Status: ' + walkInBottomSeatStatus.toString());
    print('Selected Seats: ' + selectedSeats.toString());
    print('Value List: ' + valueList.toString());

    return Scaffold(
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              SizedBox(height: defaultPadding),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //available
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 0.5,
                              ),
                              child: Container(
                                width: 30.0,
                                height: 30.0,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 0),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Available',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        //taken
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 0.5,
                              ),
                              child: Container(
                                width: 30.0,
                                height: 30.0,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 0),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Taken',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: defaultPadding),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: defaultPadding),
                    SizedBox(height: defaultPadding),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Front',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    SizedBox(height: defaultPadding),
                    SizedBox(height: defaultPadding),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15.0),
                                ListView.separated(
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 20.0),
                                  itemCount: leftRowSize,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.fromLTRB(2, 0, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          leftSideSeats(),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15.0),
                                ListView.separated(
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 20.0),
                                  itemCount: rightRowSize,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          rightSideSeats(),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: defaultPadding),
                    //bottom seat
                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 40.0),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              bottomSeat(),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: defaultPadding),
                    SizedBox(height: defaultPadding),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Back',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    SizedBox(height: defaultPadding),
                    SizedBox(height: defaultPadding),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: defaultPadding),
              SizedBox(height: defaultPadding),
              SizedBox(height: defaultPadding),
              //passenger dropdown list
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  padding: EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 4),
                      ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: seatCounter,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 20.0),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.0),
                              child: Form(
                                key: formKeyList[index],
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: defaultPadding),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 9),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Passenger " + (index + 1).toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: DropdownButtonFormField(
                                        onChanged: (val) {
                                          setState(() {
                                            //seatSelected.insert(index, val);
                                            valueList[index] = val;
                                            print('Value List - ' +
                                                valueList.toString());
                                          });
                                        },
                                        value: valueList[index],
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Select a field';
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (val) {
                                          selectedSeats.insert(index, val);
                                        },
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white,
                                          size: 10.0,
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  0, 189, 56, 1.0),
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red
                                                    .withOpacity(0.8)),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red
                                                    .withOpacity(0.8)),
                                          ),
                                        ),
                                        isExpanded: true,
                                        isDense: true,
                                        items: seatNameDropdownItem.map((item) {
                                          return new DropdownMenuItem<String>(
                                            child: Row(
                                              children: [
                                                Text(item.toString()),
                                              ],
                                            ),
                                            value: item,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                      SizedBox(height: defaultPadding),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            error,
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'Poppins',
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 3),
                    ],
                  ),
                ),
              ),
              SizedBox(height: defaultPadding),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80.0),
                      child: ElevatedButton(
                        onPressed: () {
                          selectedSeats.clear();
                          List<bool> validateForm = [];
                          for (int i = 0; i < formKeyList.length; i++) {
                            formKeyList[i].currentState.save();
                            if (formKeyList[i].currentState.validate()) {
                              validateForm.insert(
                                  i, formKeyList[i].currentState.validate());
                            } else {
                              validateForm.insert(i, false);
                            }
                          }
                          print('Selected Seats: ' + selectedSeats.toString());
                          var valFormRes =
                              validateForm.every((element) => element == true);
                          print('Validate - ' + validateForm.toString());
                          print('Validate Form Result - ' + '$valFormRes');

                          if (valFormRes == true) {
                            final noDuplicate = selectedSeats.toSet().toList();
                            print(noDuplicate);

                            if (selectedSeats.length != noDuplicate.length) {
                              setState(() {
                                error =
                                    'Duplicate seats are not allowed. Please choose another seat.';
                              });
                              print(error);
                            } else {
                              setState(() {
                                error = '';
                              });
                              print('None');
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return WalkInBillingForm();
                              }));
                            }
                          } else {
                            print('Validate Form Result - ' + '$valFormRes');
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding * 1,
                            vertical: defaultPadding /
                                (Responsive.isMobile(context) ? 2 : 1),
                          ),
                        ),
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: defaultPadding),
                  ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget leftSideSeats() {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < leftColSize; i++) {
      list.add(
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Container(
            width: 50.0,
            height: 50.0,
            margin: EdgeInsets.symmetric(horizontal: 1, vertical: 0),
            decoration: BoxDecoration(
              color:
                  walkInLeftSeatStatus[j] == true ? primaryColor : Colors.grey,
              // : listLeftSeat[j] == tempSeatSelected[tempSeatSelectedIndex]
              //   ? Colors.black
              //   : Colors.grey,
              borderRadius: BorderRadius.circular(10),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.5),
              //     spreadRadius: 3,
              //     blurRadius: 4,
              //     offset: Offset(0, 1.5), // changes position of shadow
              //   ),
              // ],
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  walkInListLeftSeat[j].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      j++;
      if (j == walkInListLeftSeat.length) {
        j = 0;
      }
    }
    return new Row(children: list);
  }

  Widget rightSideSeats() {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < rightColSize; i++) {
      list.add(
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Container(
            width: 50.0,
            height: 50.0,
            margin: EdgeInsets.symmetric(horizontal: 1, vertical: 0),
            decoration: BoxDecoration(
              color:
                  walkInRightSeatStatus[k] == true ? primaryColor : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  walkInRightSeatList[k].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      k++;
      if (k == walkInRightSeatList.length) {
        k = 0;
      }
    }
    return new Row(children: list);
  }

  Widget bottomSeat() {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < walkInListBottomSeat.length; i++) {
      list.add(
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Container(
            width: 50.0,
            height: 50.0,
            margin: EdgeInsets.symmetric(horizontal: 1, vertical: 0),
            decoration: BoxDecoration(
              color: walkInBottomSeatStatus[m] == true
                  ? primaryColor
                  : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  walkInListBottomSeat[m].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      m++;
      if (m == walkInListBottomSeat.length) {
        m = 0;
      }
    }
    return new Row(children: list);
  }
}
