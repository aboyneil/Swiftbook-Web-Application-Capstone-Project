import 'package:admin/constants.dart';
import 'package:admin/globals.dart';
import 'package:admin/models/bus_model.dart';
import 'package:admin/notifier/bus_notifier.dart';
import 'package:admin/responsive.dart';
import 'package:admin/widget/bus_radioButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../api/bus_api.dart';
import '../../../widget/alert_dialog.dart';

class PriceCategoryPopup extends StatefulWidget {

  @override
  _PriceCategoryPopupState createState() => _PriceCategoryPopupState();
  final bool isUpdating;


  PriceCategoryPopup({@required this.isUpdating});

}


class _PriceCategoryPopupState extends State<PriceCategoryPopup> {

  Bus _currentBus;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState(){
    BusNotifier busNotifier = Provider.of<BusNotifier>(this.context, listen: false);
    super.initState();

    if(busNotifier.currentBus != null){
      _currentBus = busNotifier.currentBus;

    } else{
      _currentBus = Bus();
    }

  }

  _saveBus() {
    if (!_formKey.currentState.validate()) {
    }

    _formKey.currentState.save();

    _currentBus.busStatus = busStatus.toString();

    final bool isUpdating = true;
    final String updated = "";
    updateBus(_currentBus, isUpdating, updated);


  }

  Widget build(BuildContext context) {
    if (_currentBus.busStatus == 'true'){
      busStatus = true;
    }else{
      busStatus = false;
    }
    BusNotifier busNotifier = Provider.of<BusNotifier>(this.context);

    _onBusDeleted(Bus bus) {
      Navigator.pop(context);
      busNotifier.deleteBus(bus);
    }
    return Column(

        children: [
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await showInformationDialog(context);
            },
            child: const Text('Update'),
            style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              padding: EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
                vertical:
                defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
              ),
            ),
          ),
        ]);
  }



  Future<void> showInformationDialog(BuildContext context) async {

    return await showDialog(context: context,

        builder: (context){

          final TextEditingController categoryTextController = TextEditingController();
          final TextEditingController discountTextController = TextEditingController();
          bool isChecked = false;
          return StatefulBuilder(builder: (context,setState){
            return AlertDialog(
              content: Form(
                  key: _formKey,

                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Update Bus Details',
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 10),
                        Container(
                          child: TextFormField(
                            enabled: false,
                            initialValue: _currentBus.busCode,
                            focusNode: FocusNode(),
                            enableInteractiveSelection: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Bus Code',
                            ),
                            onChanged: (value) => setState(() => _currentBus.busCode = value),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: TextFormField(
                            enabled: false,
                            initialValue: _currentBus.busPlateNumber,
                            focusNode: FocusNode(),
                            enableInteractiveSelection: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Bus Plate Number',
                            ),
                            onChanged: (value) => setState(() => _currentBus.busPlateNumber = value),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: TextFormField(
                            initialValue: _currentBus.busClass,
                            focusNode: FocusNode(),
                            enableInteractiveSelection: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Bus Class',
                            ),
                            onChanged: (value) => setState(() => _currentBus.busClass = value),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: TextFormField(
                            initialValue: _currentBus.busType,
                            focusNode: FocusNode(),
                            enableInteractiveSelection: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Bus Type',
                            ),
                            onChanged: (value) => setState(() => _currentBus.busType= value),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: TextFormField(
                            initialValue: _currentBus.busCapacity,
                            focusNode: FocusNode(),
                            enableInteractiveSelection: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Bus Seat Capacity',
                            ),
                            onChanged: (value) => setState(() => _currentBus.busCapacity= value),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(defaultPadding),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Column(
                            children: [
                              Text('Bus Status',
                                textAlign: TextAlign.left,
                              ),
                              Text(_currentBus.busStatus,
                                textAlign: TextAlign.left,
                              ),

                              RadioButtonGroupWidget(),
                            ],
                          ),

                        ),
                      ],
                    ),
                  )),
              actions: <Widget>[

                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                  style: TextButton.styleFrom(
                    backgroundColor: errorColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                ),
                ElevatedButton(

                  child: const Text('Add'),
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () async {
                    _saveBus();
                    Navigator.pop(context);
                    final action = await AlertDialogs.successDialog(
                        context,
                        'You successfully updated a bus!',
                        '');

                  },
                ),
              ],
            );
          });
        });
  }

}