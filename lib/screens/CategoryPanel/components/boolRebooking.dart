import 'package:admin/services/database.dart';
import 'package:admin/widget/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../globals.dart';
import '../../../responsive.dart';

class RebookingCheck extends StatefulWidget {
  const RebookingCheck({Key key}) : super(key: key);

  @override
  _RebookingCheckState createState() => _RebookingCheckState();
}

class _RebookingCheckState extends State<RebookingCheck> {
  final DatabaseService db = DatabaseService();

  final feeController = TextEditingController();
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
            "Allow Rebooking?",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: defaultPadding),
          Row(
            children: [
              Switch(
                value: checkRebooking,
                onChanged: (bool value) {
                  setState(() {
                    checkRebooking = value;
                  });
                },
              ),
              SizedBox(width: defaultPadding),
            ],
          ),
          if(checkRebooking==true)
            Column(
              children: [

                Align(
                    alignment: Alignment.topLeft,
                    child: Text('*If no rebooking fee input 0', style: TextStyle(color: Colors.redAccent))),
                SizedBox(height: 10),
                Container(
                child: Align(
                  child: TextFormField(
                  controller: feeController,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Rebooking Fee',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
                  ),

                  onChanged: (value) {
                    setState(() {
                      String fee = feeController.text;
                      feeCategory = fee;
                    });
                  }
                  // controller: fieldText,
                  ),
                ),
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
                      final action = await AlertDialogs.yesCancelDialog(
                          context,
                          '',
                          'Adding/Updating Rebooking Details');

                      if (action == DialogsAction.yes) {
                        db.updateRebooking();
                        await AlertDialogs.successDialog(
                            context,
                            'You successfully added a rebooking fee!',
                            '');
                      } else {}
                    },
                    icon: Icon(Icons.add),
                    label: Text("Save Rebooking Details"),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}

