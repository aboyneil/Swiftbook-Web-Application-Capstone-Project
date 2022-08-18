import 'package:admin/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../globals.dart';
import '../../../responsive.dart';
import '../../../widget/alert_dialog.dart';

class RefundField extends StatefulWidget {
  const RefundField({Key key}) : super(key: key);

  @override
  _RefundFieldState createState() => _RefundFieldState();
}

class _RefundFieldState extends State<RefundField> {
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
            "Enable Refund",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: defaultPadding),
          Row(
            children: [
              Switch(
                value: checkRefund,
                onChanged: (bool value) {
                  setState(() {
                    checkRefund = value;
                  });
                },
              ),
              SizedBox(width: defaultPadding),
            ],
          ),
          // if(checkCoupon==true)
          SizedBox(height: 10),
          if(checkRefund==true)
            Column(
              children: [

                Align(
                    alignment: Alignment.topLeft,
                    child: Text('*If no refund fee input 0', style: TextStyle(color: Colors.redAccent))),
                SizedBox(height: 10),
                Container(
                  child: Align(
                    child: TextFormField(
                        controller: feeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Refund Fee By Percentage',
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
                          'Adding/Updating Refund Details');

                      if (action == DialogsAction.yes) {
                        db.updateRefund();
                        await AlertDialogs.successDialog(
                            context,
                            'You successfully added a refund fee!',
                            '');
                      } else {}
                    },
                    icon: Icon(Icons.add),
                    label: Text("Save Refund Details"),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
