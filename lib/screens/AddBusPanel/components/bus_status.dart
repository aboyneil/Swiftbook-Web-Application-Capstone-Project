import 'package:admin/globals.dart';
import 'package:admin/responsive.dart';
import 'package:admin/widget/alert_dialog.dart';
import 'package:admin/widget/clearfield.dart';
import 'package:flutter/material.dart';
import 'package:admin/services/database.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../models/bus_model.dart';
import '../../../notifier/bus_notifier.dart';
import '../../../widget/bus_imgUpload.dart';
import '../../../widget/bus_radioButton.dart';

final DatabaseService db = DatabaseService();

class BusStatus extends StatefulWidget {
  const BusStatus({Key key}) : super(key: key);

  @override
  _BusStatusState createState() => _BusStatusState();
}

class _BusStatusState extends State<BusStatus> {


  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bus Status",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          BusInfoCard(),
        ],
      ),
    );
  }
}

class BusInfoCard extends StatefulWidget {
  @override
  State<BusInfoCard> createState() => _BusInfoCardState();
}

class _BusInfoCardState extends State<BusInfoCard> {

  Bus _currentBus;
  @override
  void initState() {
    BusNotifier busNotifier = Provider.of<BusNotifier>(this.context, listen: false);
    super.initState();

    if(busNotifier.currentBus != null){
      _currentBus = busNotifier.currentBus;

    } else{
      print("I'm here");
      _currentBus = Bus();
    }
  }
  @override
  Widget build(BuildContext context) {
    bool tappedYes = false;

    return Container(
        margin: EdgeInsets.only(top: defaultPadding),
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
          borderRadius: const BorderRadius.all(
            Radius.circular(defaultPadding),
          ),
        ),
        child: Column(
          children: [
            RadioButtonGroupWidget(),
            // Divider(
            //   thickness: 3,
            // ),
            // Text(
            //   "Upload Image",
            //   style: Theme.of(context).textTheme.subtitle1,
            // ),
            // BusImage(),
            // Divider(
            //   thickness: 3,
            // ),

          ],
        ));
  }
}
