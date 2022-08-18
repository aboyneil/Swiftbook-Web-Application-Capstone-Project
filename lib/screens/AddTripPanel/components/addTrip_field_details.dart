import 'package:admin/constants.dart';
import 'package:admin/services/database.dart';
import 'package:admin/widget/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/globals.dart';

import '../../../responsive.dart';

final DatabaseService db = DatabaseService();

class AddTripBusDetails extends StatefulWidget {
  const AddTripBusDetails({
    Key key,
  }) : super(key: key);

  _AddTripBusDetails createState() => _AddTripBusDetails();
}

class _AddTripBusDetails extends State<AddTripBusDetails> {
  var busCapacityController = TextEditingController();
  var busTypeController = TextEditingController();
  var busClassController = TextEditingController();
  var busCodeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                "Add New Trip Details",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: new EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TerminalField(),
              ),
              Text(
                "Routes",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: BusOriginField(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: BusDestinationField(),
              ),
              Text(
                "Bus Details",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: BusPlateNumberField(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: busCodeField(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: BusSeatField(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: BusTypeField(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: BusClassField(),
              ),
              Text(
                "Price Details",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: priceField(),
              ),
              Text(
                "Driver",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: busDriverField(),
              ),
            ],
          ),
        ));
  }

  Widget TerminalField() => SizedBox(
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Terminal',
            contentPadding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
          ),

          autovalidateMode: AutovalidateMode.onUserInteraction,

          validator: (String value) {
            if (value.isEmpty) {
              terminalDescription = null;
              return "Please enter Trip Description";
            } else {
              return null;
            }
          },

          onChanged: (value) => setState(() => terminalDescription = value),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          // controller: fieldText,
        ),
      );

  Widget BusSeatField() => TextFormField(
        controller: busCapacityController,
        enabled: false,
        focusNode: FocusNode(),
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Bus Capacity',
        ),

        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.number,

        validator: (String value) {
          if (value.isEmpty) {
            readBusCapacity = null;
            return "Please enter Bus Capacity";
          } else {
            return null;
          }
        },
        onChanged: (value) =>
            setState(() => readBusCapacity = value), // controller: fieldText,
      );

  Widget BusTypeField() => TextFormField(
        controller: busTypeController,
        enabled: false,
        focusNode: FocusNode(),
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Bus Type',
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (String value) {
          if (value.isEmpty) {
            readBusType = null;
            return "Please enter Bus Type";
          } else {
            return null;
          }
        },
      );
  Widget BusClassField() => TextFormField(
        controller: busClassController,
        enabled: false,
        focusNode: FocusNode(),
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Bus Class',
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (String value) {
          if (value.isEmpty) {
            readBusClass = null;
            return "Please enter Bus Class";
          } else {
            return null;
          }
        },
      );
  Widget busCodeField() => TextFormField(
        controller: busCodeController,
        enabled: false,
        focusNode: FocusNode(),
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Bus Code',
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (String value) {
          if (value.isEmpty) {
            readBusCode = null;
            return "Please enter Bus Code";
          } else {
            return null;
          }
        },
      );
  Widget priceField() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Price',
        ),

        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.number,

        validator: (String value) {
          if (value.isEmpty) {
            return "Please enter Price";
          } else if (value.contains(RegExp(r'[A-Z]'))) {
            return "Please enter a Valid Number";
          } else if (value.contains(RegExp(r'[a-z]'))) {
            return "Please enter a Valid Number";
          } else
            try {
              bool isNumeric(value) {
                if (value == null) {
                  return false;
                }
                return int.tryParse(value) != null;
              }

              if (value.isEmpty) {
                priceDetails = null;
                return "Please enter Price";
              } else {
                return null;
              }
            } catch (e) {
              print(e.toString());
              return null;
            }
        },

        onChanged: (value) => setState(() => priceDetails = value),
        // controller: fieldText,
      );

  Widget BusOriginField() => Column(
        children: [
          Container(
            child: new StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('$company' + '_origin')
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
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      hint: Text(
                        "Select origin",
                      ),
                      onChanged: (value) {
                        setState(() {
                          originRoutes = value.toUpperCase();
                        });
                      },
                      items: snapshot.data.docs.map((DocumentSnapshot docs) {
                        return new DropdownMenuItem<String>(
                          value: docs['location'],
                          child: new Text(
                            docs['location'].toUpperCase(),
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
                final action = await AlertDialogs.OriginFieldDialog(context);

                if (action == DialogsAction.yes) {
                  db.addOrigin();
                } else {}
              },
              icon: Icon(Icons.add),
              label: Text("Add New"),
            ),
          )
        ],
      );

  Widget BusDestinationField() => Column(
        children: [
          Container(
            child: new StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('$company' + '_destination')
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
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      hint: Text(
                        "Select destination",
                      ),
                      onChanged: (value) {
                        setState(() {
                          destinationRoutes = value.toUpperCase();
                        });
                      },
                      items: snapshot.data.docs.map((DocumentSnapshot docs) {
                        return new DropdownMenuItem<String>(
                          value: docs['location'],
                          child: new Text(
                            docs['location'].toUpperCase(),
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
                final action =
                    await AlertDialogs.DestinationFieldDialog(context);

                if (action == DialogsAction.yes) {
                  db.addDestination();
                } else {}
              },
              icon: Icon(Icons.add),
              label: Text("Add New"),
            ),
          )
        ],
      );

  Widget BusPlateNumberField() => Column(
        children: [
          Container(
            child: new StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('$company' + '_bus')
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
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      hint: Text(
                        "Select Plate Number",
                      ),
                      onChanged: (value) async {
                        setState(() {
                          readBusPlateNumber = value;
                        });
                        final CollectionReference busCollection =
                            FirebaseFirestore.instance
                                .collection('$company' + '_bus');

                        QuerySnapshot querySnapshot = await busCollection.get();
                        for (int i = 0; i < querySnapshot.docs.length; i++) {
                          print(readBusPlateNumber);
                          if (querySnapshot.docs[i]['Bus Plate Number'] ==
                              readBusPlateNumber) {
                            readBusCapacity = querySnapshot.docs[i]
                                    ['Bus Seat Capacity']
                                .toString();
                            readBusType = querySnapshot.docs[i]['Bus Type'];
                            readBusClass = querySnapshot.docs[i]['Bus Class'];
                            seatAvailability =
                                querySnapshot.docs[i]['Bus Availability Seat'];
                            readBusCode = querySnapshot.docs[i]['Bus Code'];
                          }

                          busCapacityController.text = readBusCapacity;
                          busTypeController.text = readBusType;
                          busClassController.text = readBusClass;
                          busCodeController.text = readBusCode;
                        }
                        print("Bus Seat:" + "$readBusCapacity");
                        print("Bus Type:" + "$readBusType");
                        print("Bus Class:" + "$readBusClass");
                        print("Bus Codd:" + "$readBusCode");
                        print("Bus Availability:" + "$readBusCode");
                      },
                      items: snapshot.data.docs.map((DocumentSnapshot docs) {
                        return new DropdownMenuItem<String>(
                          value: docs['Bus Plate Number'],
                          child: new Text(
                            docs['Bus Plate Number'].toUpperCase(),
                          ),
                        );
                      }).toList(),
                    );
                  }
                }),
          ),
        ],
      );
  Widget busDriverField() => Column(
        children: [
          Container(
            child: new StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('$company' + '_drivers')
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
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      hint: Text(
                        "Select driver",
                      ),
                      onChanged: (value) {
                        setState(() {
                          busDriver = value;
                        });
                      },
                      items: snapshot.data.docs.map((DocumentSnapshot docs) {
                        return new DropdownMenuItem<String>(
                          value: docs['fullname'],
                          child: new Text(
                            docs['fullname'].toUpperCase(),
                          ),
                        );
                      }).toList(),
                    );
                  }
                }),
          ),
        ],
      );
}
