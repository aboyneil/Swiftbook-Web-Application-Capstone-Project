import 'package:admin/constants.dart';
import 'package:admin/globals.dart';
import 'package:flutter/material.dart';

import '../../../responsive.dart';
import '../../../widget/alert_dialog.dart';

class GenerateSeat extends StatefulWidget {
  const GenerateSeat({Key key}) : super(key: key);

  @override
  _GenerateSeatState createState() => _GenerateSeatState();
}

class _GenerateSeatState extends State<GenerateSeat> {


  int j = 0;
  int z = 0;
  int h = 0;
  int k = 0;
  int n = 0;
  int m = 0;
  int rightBottom = 1;

  @override
  Widget build(BuildContext context) {
    int rightRowsNum = rightRowNumber;
    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "*Please save seat first before adding a bus!",
                style: TextStyle(fontStyle: FontStyle.italic,
                  color: Colors.redAccent,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Front',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            SizedBox(height: 10),
            Row(
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
                        itemCount: leftRowNumber,
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
                        itemCount: rightRowsNum,
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
            SizedBox(height: defaultPadding),
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
              bottomSeats(),
              ],
              ),
            );
            },
            ),

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

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: bgColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1,
                    vertical:
                    defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () async {
                  final action = await AlertDialogs.yesCancelDialog(context,
                      'Adding Bus Seat Number', 'Generating Seat. . .');

                  if (action == DialogsAction.yes) {
                    for (int i = 0; i < leftformKeyList.length; i++) {
                      if (leftformKeyList[i].currentState.validate()) {
                        leftformKeyList[i].currentState.save();
                        k++;
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
                    for (int i = 0; i < rightformKeyList.length; i++) {
                      if (rightformKeyList[i].currentState.validate()) {
                        rightformKeyList[i].currentState.save();
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
                        m++;
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
                    j = 0;
                    z = 0;
                    h = 0;
                    k = 0;
                    m = 0;
                    n = 0;
                    await AlertDialogs.successDialog(
                        context, 'Please proceed saving bus details', 'Successfully Generate seat Number');
                    }

                },
                icon: Icon(Icons.save),
                label: Text("Save Seat Numbers"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget leftSideSeats() {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < leftColNumber; i++) {
      list.add(
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: 1 , vertical: 0),
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 1.5), // changes position of shadow
              ),
            ],
          ),

            child: Form(
              key: leftformKeyList[h],
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(0.0),
                ),
                onSaved: (val) {
                  print(val);
                  setState(() {
                    leftGeneratedSeat.insert(k, val);
                  });
                },
              ),
            ),
          ),

      );
      h++;
    }
    print('Widget List: ' + list.length.toString());
    return new Row(children: list);
  }

  Widget rightSideSeats() {
    int rightColNum = rightColNumber;
    List<Widget> list = <Widget>[];
    for (var i = 0; i < rightColNum; i++) {
      print("Column");
      list.add(
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: 1, vertical: 0),
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 2,
                offset: Offset(0, 1.5), // changes position of shadow
              ),
            ],
          ),

            child: Form(
              key: rightformKeyList[j],
              child: TextFormField(
                cursorColor: Colors.black,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(0.0),
                ),

                onSaved: (val) {
                  print(val);
                  setState(() {
                    rightGeneratedSeat.insert(z, val);
                  });
                },
              ),
            ),
          ),
      );
      //
      j++;
    }
    return new Row(children: list);
  }
  Widget bottomSeats() {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < bottomColNumber; i++) {
      list.add(
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: 1 , vertical: 0),
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 1.5), // changes position of shadow
              ),
            ],
          ),
            child: Form(
              key: bottomFormKeyList[n],
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(0.0),
                ),
                onSaved: (val) {
                  print(val);
                  setState(() {
                    bottomGeneratedSeat.insert(m, val);
                  });
                },
              ),
            ),
          ),
      );
      n++;
    }
    return new Row(children: list);
  }
}
