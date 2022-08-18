import 'package:admin/screens/CategoryPanel/components/CouponDetails/configureCoupon.dart';
import 'package:admin/services/database.dart';
import 'package:admin/widget/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../globals.dart';
import '../../../responsive.dart';

class CouponCheck extends StatefulWidget {
  const CouponCheck({Key key}) : super(key: key);

  @override
  _CouponCheckState createState() => _CouponCheckState();
}

class _CouponCheckState extends State<CouponCheck> {
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
            "Enable Coupon",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: defaultPadding),
          Row(
            children: [
              Switch(
                value: checkCoupon,
                onChanged: (bool value) {
                  setState(() {
                    checkCoupon = value;
                  });
                  db.updateCoupon();
                },
              ),
              SizedBox(width: defaultPadding),
            ],
          ),
          if(checkCoupon==true)
            Column(
              children: [

                Align(
                    alignment: Alignment.topLeft,
                    child: Text('*Please Configure Coupon', style: TextStyle(color: Colors.redAccent))),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ConfigureCoupon()),
                      );
                    },
                    icon: Icon(Icons.save),
                    label: Text("Configure Coupon Details"),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
