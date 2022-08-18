import 'package:admin/screens/WalkInPanel/walkIn_passengerForm.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants.dart';
import '../../../globals.dart';
import '../../../responsive.dart';
import '../../../widget/alert_dialog.dart';
import '../../../widget/bus_radioButton.dart';


class Mock extends StatefulWidget {
  const Mock({Key key}) : super(key: key);

  @override
  _MockState createState() => _MockState();
}

class _MockState extends State<Mock> {

  final List<GlobalKey<FormState>> formKeyList =
  List.generate(seatCounter, (index) => GlobalKey<FormState>());

  int j = 0;
  int k = 0;
  int m = 0;
  int h = 0;
  int n = 0;
  int z = 0;

  List seatsName =
  [walkInListLeftSeat, walkInRightSeatList, walkInListBottomSeat].expand((x) => x).toList();
  List seatsNameStatus = [walkInLeftSeatStatus, walkInRightSeatStatus, walkInBottomSeatStatus]
      .expand((x) => x)
      .toList();
  String seatSelected;
  String error = '';
  List<String> tempSeatSelected = [];
  int tempSeatSelectedIndex = 0;

  final List<GlobalKey<FormState>> bottomFormKeyList =
  List.generate(bottomColNumber, (index) => GlobalKey<FormState>());

  final List<GlobalKey<FormState>> leftFormKeyList =
  List.generate(leftColSize*leftRowSize, (index) => GlobalKey<FormState>());

  final List<GlobalKey<FormState>> rightFormKeyList =
  List.generate(rightColSize*rightRowSize, (index) => GlobalKey<FormState>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appBar: AppBar(
      //     title: const Text('Bus Details'),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios),
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //   ),
      // ),
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
              Row(
                children: [
                  IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                  Text('Go Back to Bus Details'),
                ],
              ),
              SizedBox(height: defaultPadding),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    SizedBox(height: defaultPadding),
                    Container(
                      padding: EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Column(
                        children: [
                          Text('Update Bus Status',
                            textAlign: TextAlign.left,
                          ),
                          Text(busStatus.toString(),
                            textAlign: TextAlign.left,
                          ),
                          RadioButtonGroupWidget(),
                        ],
                      ),

                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: defaultPadding),
                    Text('Update Bus Seat Number',
                      textAlign: TextAlign.left,
                    ),
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
                                      padding: EdgeInsets.fromLTRB(
                                          2,
                                          0,
                                          0,
                                          0),
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
                                      padding: EdgeInsets.fromLTRB(0, 0,
                                          0, 0),
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
                          padding: EdgeInsets.fromLTRB(
                              0, 0, 0, 0),
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
                    SizedBox(height:defaultPadding),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Back',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    SizedBox(height:defaultPadding),
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
              SizedBox(height:defaultPadding),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 80.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          for (int i = 0; i < leftFormKeyList.length; i++) {
                            if (leftFormKeyList[i].currentState.validate()) {
                              leftFormKeyList[i].currentState.save();
                              h++;
                            }
                            if(leftGeneratedSeat[i] == 'X' || leftGeneratedSeat[i] == 'x'){
                              leftSeatStatus.add(false);
                              allSeat.add(leftGeneratedSeat[i]);
                              allSeatStatus.add(false);
                            }else{
                              leftSeatStatus.add(true);
                              allSeat.add(leftGeneratedSeat[i]);
                              allSeatStatus.add(true);
                            }
                          }
                          for (int i = 0; i < rightFormKeyList.length; i++) {
                            if (rightFormKeyList[i].currentState.validate()) {
                              rightFormKeyList[i].currentState.save();
                              z++;
                            }
                            if(rightGeneratedSeat[i] == 'X' || rightGeneratedSeat[i] == 'x'){
                              rightSeatStatus.add(false);
                              allSeat.add(rightGeneratedSeat[i]);
                              allSeatStatus.add(false);
                            }else{
                              rightSeatStatus.add(true);
                              allSeat.add(rightGeneratedSeat[i]);
                              allSeatStatus.add(true);
                            }
                          }
                          for (int i = 0; i < bottomFormKeyList.length; i++) {
                            if (bottomFormKeyList[i].currentState.validate()) {
                              bottomFormKeyList[i].currentState.save();
                              n++;
                            }
                            if(bottomGeneratedSeat[i] == 'X' || bottomGeneratedSeat[i] == 'x'){
                              bottomSeatStatus.add(false);
                              allSeat.add(bottomGeneratedSeat[i]);
                              allSeatStatus.add(false);
                              // busSeatCapacity= busSeatCapacity++;
                            }else{
                              bottomSeatStatus.add(true);
                              allSeat.add(bottomGeneratedSeat[i]);
                              allSeatStatus.add(true);
                            }
                          }

                          db.updateBusSeat();
                          await AlertDialogs.successDialog(
                              context,
                              'You successfully updated the bus!',
                              '');


                          // print("Bus Status"+"$busStatus");
                          // print("bottom"+"$bottomGeneratedSeat");
                          // print("bottom S"+"$bottomSeatStatus");
                          // print("Left"+"$leftGeneratedSeat");
                          // print("Left S"+"$leftSeatStatus");
                          // print("Right"+"$rightGeneratedSeat");
                          // print("Right S"+"$rightSeatStatus");
                          // print("All"+"$allSeat");
                          // print("All"+"$allSeatStatus");
                          m = 0;
                          n = 0;
                          z = 0;
                          h = 0;
                          k = 0;
                          j = 0;
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding * 1,
                            vertical:
                            defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                          ),
                        ),
                        child: Text(
                          'UPDATE',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height:defaultPadding),
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
            margin: EdgeInsets.symmetric(
                horizontal: 1, vertical: 0),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3, // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Form(
                  key: leftFormKeyList[j],
                  child: TextFormField(
                    initialValue: walkInListLeftSeat[j].toString(),
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(0.0),
                    ),
                    onSaved: (val) {
                      print(val);
                      setState(() {
                        leftGeneratedSeat.insert(h, val);
                      });
                    },
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
            margin: EdgeInsets.symmetric(
                horizontal: 1, vertical: 0),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3, // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Form(
                  key: rightFormKeyList[k],
                  child: TextFormField(
                    initialValue: walkInRightSeatList[k].toString(),
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(0.0),
                    ),
                  onSaved: (val) {
                    setState(() {
                      rightGeneratedSeat.insert(z, val);
                    });
                  },
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
            margin: EdgeInsets.symmetric(
                horizontal: 1, vertical: 0),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3, // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Form(
                  key: bottomFormKeyList[m],
                  child: TextFormField(
                    initialValue: walkInListBottomSeat[m].toString(),
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(0.0),
                    ),
                    onSaved: (val) {
                      print(val);
                      setState(() {
                        bottomGeneratedSeat.insert(n, val);
                      });
                    },
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
