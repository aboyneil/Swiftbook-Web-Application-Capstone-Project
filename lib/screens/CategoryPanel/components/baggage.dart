import 'package:admin/models/bus_model.dart';
import 'package:admin/services/database.dart';
import 'package:admin/widget/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../globals.dart';
import '../../../responsive.dart';

class BaggageLimit extends StatefulWidget {
  const BaggageLimit({Key key}) : super(key: key);

  @override
  _BaggageLimitState createState() => _BaggageLimitState();
}

class _BaggageLimitState extends State<BaggageLimit> {
  final DatabaseService db = DatabaseService();

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
            "Add Baggage Limit",
            style: Theme
                .of(context)
                .textTheme
                .subtitle1,
          ),
          SizedBox(height: defaultPadding),
          Row(
            children: [
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
                    final action =
                    await AlertDialogs.baggageFieldDialog(context);

                    if (action == DialogsAction.yes) {
                      if (minimumBaggage == 0 ||
                          maximumBaggage == 0 ||
                          pesoPerBaggage == 0) {
                        await AlertDialogs.errorDialog(
                            context, 'Enter valid Data', '');
                      } else {
                        db.addBaggageLimit();
                        await AlertDialogs.successDialog(context,
                            'You successfully added a Baggage Limit!', '');
                      }
                    } else {}
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add New"),
                ),
              ),
              SizedBox(width: defaultPadding),
            ],
          )
        ],
      ),
    );
  }
}
