import 'package:admin/constants.dart';
import 'package:admin/routes/routeName.dart';
import 'package:flutter/material.dart';
import 'package:admin/globals.dart';
import 'package:admin/models/bus_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../../api/bus_api.dart';
import '../../../notifier/bus_notifier.dart';
import '../../../responsive.dart';
import '../../../widget/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin/services/database.dart';

import 'generateSeat.dart';

String dataType = 'String';

class BusDetails extends StatefulWidget {
  const BusDetails({
    Key key,
  }) : super(key: key);

  _BusDetails createState() => _BusDetails();
}

class _BusDetails extends State<BusDetails> {
  final DatabaseService db = DatabaseService();
  final _formKey = GlobalKey<FormState>();

  List listItem = ["AC", "Non-AC", "Sleeper"];

  var codeController = TextEditingController();
  var leftColController = TextEditingController();
  var leftRowController = TextEditingController();
  var rightColController = TextEditingController();
  var rightRowController = TextEditingController();
  var bottomRowController = TextEditingController();
  var plateController = TextEditingController();
  var classController = TextEditingController();
  var typeController = TextEditingController();
  var capacityController = TextEditingController();
  var flagSeat = false;

  var minBagController = TextEditingController();
  var maxBagController = TextEditingController();
  var pesoPerBagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (checkBaggage == true) {
      return Container(
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Add New Bus Details",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: busCodeField(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: busPlateNumberField(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: minBaggage(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: maxBaggage(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: pesoPerBagagge(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: busClassField(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: busTypeField(),
                ),
                Text(
                  "Generate Seats",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Row(
                  children: [
                    busLeftColumn(),
                    busLeftRow(),
                  ],
                ),
                Row(
                  children: [
                    busRightColumn(),
                    busRightRow(),
                  ],
                ),
                Row(
                  children: [
                    busBottomRow(),
                  ],
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1,
                        vertical: defaultPadding /
                            (Responsive.isMobile(context) ? 2 : 1),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        flagSeat = true;
                      });
                    },
                    icon: Icon(Icons.settings),
                    label: Text("Generate"),
                  ),
                ),
                if (flagSeat == false)
                  Container(
                    child: Center(
                      child: Text(
                        "*Please click the generate button",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                if (flagSeat == true) GenerateSeat(),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: defaultPadding /
                          (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () async {
                    final action = await AlertDialogs.yesCancelDialog(context,
                        'Are you sure you want to add new bus?', 'Adding Bus');

                    if (action == DialogsAction.yes) {
                      if (_formKey.currentState.validate()) {
                        var dbResult = await FirebaseFirestore.instance
                            .collection('$company' + '_bus')
                            .where('Bus Plate Number',
                                isEqualTo: busPlateNumber.toUpperCase())
                            .get();
                        if (dbResult.docs.length != 0) {
                          await AlertDialogs.errorAddBus(context);
                        } else {
                          db.addBusWithBaggage();

                          await AlertDialogs.successDialog(
                              context, 'You successfully added a bus!', '');

                          navKey.currentState.pushNamed(routeAddBus);
                        }
                      }
                    } else {
                      await AlertDialogs.ErroralertDialog(context);
                    }
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add Bus"),
                ),
              ],
            ),
          ));
    } else {
      return Container(
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Add New Bus Details",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: busCodeField(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: busPlateNumberField(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: busClassField(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: busTypeField(),
                ),
                Text(
                  "Generate Seats",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Row(
                  children: [
                    busLeftColumn(),
                    busLeftRow(),
                  ],
                ),
                Row(
                  children: [
                    busRightColumn(),
                    busRightRow(),
                  ],
                ),
                Row(
                  children: [
                    busBottomRow(),
                  ],
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1,
                        vertical: defaultPadding /
                            (Responsive.isMobile(context) ? 2 : 1),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        flagSeat = true;
                      });
                    },
                    icon: Icon(Icons.settings),
                    label: Text("Generate"),
                  ),
                ),
                if (flagSeat == false)
                  Container(
                    child: Center(
                      child: Text(
                        "*Please click the generate button",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                if (flagSeat == true) GenerateSeat(),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: defaultPadding /
                          (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () async {
                    final action = await AlertDialogs.yesCancelDialog(context,
                        'Are you sure you want to add new bus?', 'Adding Bus');

                    if (action == DialogsAction.yes) {
                      if (_formKey.currentState.validate()) {
                        var dbResult = await FirebaseFirestore.instance
                            .collection('$company' + '_bus')
                            .where('Bus Plate Number',
                                isEqualTo: busPlateNumber.toUpperCase())
                            .get();
                        if (dbResult.docs.length != 0) {
                          await AlertDialogs.errorAddBus(context);
                        } else {
                          db.addBusWithoutBaggage();

                          await AlertDialogs.successDialog(
                              context, 'You successfully added a bus!', '');

                          navKey.currentState.pushNamed(routeAddBus);
                        }
                      }
                    } else {
                      await AlertDialogs.ErroralertDialog(context);
                    }
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add Bus"),
                ),
              ],
            ),
          ));
    }
  }

  Widget busCodeField() => TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Bus Code',
      ),
      controller: codeController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String value) {
        if (value.isEmpty) {
          return "Please enter a Bus Code";
        } else {
          return null;
        }
      },
      onChanged: (value) => setState(
            () => busCode = value,
          )
      // controller: fieldText,
      );

  Widget busClassField() => Column(
        children: [
          Container(
            child: new StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('$company' + '_busClass')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  } else {
                    return DropdownButtonFormField(
                      isExpanded: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.8),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(0, 189, 56, 1.0),
                          ),
                        ),
                      ),
                      hint: Text(
                        "Select Bus Class",
                      ),
                      onChanged: (value) {
                        setState(() {
                          busClass = value.toUpperCase();
                        });
                      },
                      items: snapshot.data.docs.map((DocumentSnapshot docs) {
                        return new DropdownMenuItem<String>(
                          value: docs['bus class'],
                          child: new Text(
                            docs['bus class'].toUpperCase(),
                          ),
                        );
                      }).toList(),
                    );
                  }
                }),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () async {
                final action = await AlertDialogs.BusClassFieldDialog(context);

                if (action == DialogsAction.yes) {
                  db.addBusClass();
                } else {}
              },
              icon: Icon(Icons.add),
              label: Text("Add New"),
            ),
          )
        ],
      );

  Widget busPlateNumberField() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Bus Plate Number',
        ),
        controller: plateController,

        autovalidateMode: AutovalidateMode.onUserInteraction,

        validator: (String value) {
          if (value.isEmpty) {
            return "Please enter Bus Plate Number";
          } else {
            return null;
          }
        },

        onChanged: (value) => setState(() => busPlateNumber = value),
        // controller: fieldText,
      );

  Widget minBaggage() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Minimum Baggage in Kilograms',
        ),
        controller: minBagController,

        autovalidateMode: AutovalidateMode.onUserInteraction,

        validator: (String value) {
          if (value.contains(RegExp(r'[A-Z]'))) {
            return "Please enter a valid data";
          } else if (value.contains(RegExp(r'[a-z]'))) {
            return "Please enter a valid data";
          } else if (value.isEmpty) {
            return "Please enter a valid data";
          } else {
            return null;
          }
        },

        onChanged: (value) => setState(() => minimumBaggage = value),
        // controller: fieldText,
      );

  Widget maxBaggage() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Maximum Baggage in Kilograms',
        ),
        controller: maxBagController,

        autovalidateMode: AutovalidateMode.onUserInteraction,

        validator: (String value) {
          if (value.contains(RegExp(r'[A-Z]'))) {
            return "Please enter a valid data";
          } else if (value.contains(RegExp(r'[a-z]'))) {
            return "Please enter a valid data";
          } else if (value.isEmpty) {
            return "Please enter a valid data";
          } else {
            return null;
          }
        },

        onChanged: (value) => setState(() => maximumBaggage = value),
        // controller: fieldText,
      );

  Widget pesoPerBagagge() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Ammount per 1 Kilogram Baggage',
        ),
        controller: pesoPerBagController,

        autovalidateMode: AutovalidateMode.onUserInteraction,

        validator: (String value) {
          if (value.contains(RegExp(r'[A-Z]'))) {
            return "Please enter a valid data";
          } else if (value.contains(RegExp(r'[a-z]'))) {
            return "Please enter a valid data";
          } else if (value.isEmpty) {
            return "Please enter a valid data";
          } else {
            return null;
          }
        },

        onChanged: (value) => setState(() => pesoPerBaggage = value),
        // controller: fieldText,
      );

  Widget busLeftColumn() => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number of Left Column',
                ),
                controller: leftColController,

                autovalidateMode: AutovalidateMode.onUserInteraction,

                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please enter a No. of left column";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  if (value == '') {
                    flagSeat = false;
                    setState(() {
                      leftColNumber = 0;
                      leftformKeyList = List.generate(
                          leftColNumber * leftRowNumber,
                          (index) => GlobalKey<FormState>());

                      print('left form:' + "$leftformKeyList");
                    });
                  } else {
                    setState(() {
                      leftColNumber = int.parse(value);
                      leftformKeyList = List.generate(
                          leftColNumber * leftRowNumber,
                          (index) => GlobalKey<FormState>());
                    });
                  }
                },

                // controller: fieldText,
              ),
            ],
          ),
        ),
      );
  Widget busLeftRow() => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number of Left Row',
                ),
                controller: leftRowController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please enter a No. of left row";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  if (value == '') {
                    flagSeat = false;
                    setState(() {
                      leftRowNumber = 0;
                      leftformKeyList = List.generate(
                          leftColNumber * leftRowNumber,
                          (index) => GlobalKey<FormState>());

                      print('left form:' + "$leftformKeyList");
                    });
                  } else {
                    setState(() {
                      leftRowNumber = int.parse(value);
                      leftformKeyList = List.generate(
                          leftColNumber * leftRowNumber,
                          (index) => GlobalKey<FormState>());

                      print('left form:' + "$leftformKeyList");
                    });
                  }
                },
              ),
            ],
          ),
        ),
      );
  Widget busRightColumn() => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number of Right Column',
                ),
                controller: rightColController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please enter a No. of right column";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  if (value == '') {
                    flagSeat = false;
                    setState(() {
                      rightColNumber = 0;
                      rightformKeyList = List.generate(
                          leftColNumber * leftRowNumber,
                          (index) => GlobalKey<FormState>());
                    });
                  } else {
                    setState(() {
                      rightColNumber = int.parse(value);
                      rightformKeyList = List.generate(
                          rightColNumber * rightRowNumber,
                          (index) => GlobalKey<FormState>());
                    });
                  }
                },
              ),
            ],
          ),
        ),
      );
  Widget busRightRow() => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number of Right Row',
                ),
                controller: rightRowController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please enter a No. of right row";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  if (value == '') {
                    flagSeat = false;
                    setState(() {
                      rightRowNumber = 0;
                      rightformKeyList = List.generate(
                          leftColNumber * leftRowNumber,
                          (index) => GlobalKey<FormState>());
                    });
                  } else {
                    setState(() {
                      rightRowNumber = int.parse(value);
                      rightformKeyList = List.generate(
                          rightColNumber * rightRowNumber,
                          (index) => GlobalKey<FormState>());
                    });
                  }
                },
              ),
            ],
          ),
        ),
      );
  Widget busBottomRow() => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number of Bottom Row',
                ),
                controller: bottomRowController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please enter a No. of Bottom Row";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  if (value == '') {
                    flagSeat = false;
                    setState(() {
                      bottomColNumber = 0;
                      bottomFormKeyList = List.generate(
                          bottomColNumber, (index) => GlobalKey<FormState>());
                    });
                  } else {
                    setState(() {
                      bottomColNumber = int.parse(value);
                      bottomFormKeyList = List.generate(
                          bottomColNumber, (index) => GlobalKey<FormState>());
                    });
                  }
                },
              ),
            ],
          ),
        ),
      );
  Widget busTypeField() => Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF2A2D3E), width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: DropdownButtonFormField(
          value: valueChoose,
          hint: Text('Select Bus Type'),
          isExpanded: true,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.8),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(0, 189, 56, 1.0),
              ),
            ),
          ),
          onChanged: (newValue) {
            setState(() {
              busType = newValue;
            });
          },
          items: listItem.map((valueItem) {
            return DropdownMenuItem(
              value: valueItem,
              child: Text(valueItem),
            );
          }).toList(),
        ),
      );
}
