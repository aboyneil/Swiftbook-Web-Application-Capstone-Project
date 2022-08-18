import 'package:admin/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants.dart';
import '../../../../responsive.dart';
import '../../../../widget/alert_dialog.dart';
import '../../../../widget/date_time_picker.dart';
import '../../../dashboard/components/header.dart';

class ConfigureCoupon extends StatefulWidget {

  @override
  _ConfigureCouponState createState() => _ConfigureCouponState();
}

class _ConfigureCouponState extends State<ConfigureCoupon> {
  final couponCodeController = TextEditingController();
  final amountController = TextEditingController();
  final spendController = TextEditingController();
  final usageCouponController = TextEditingController();
  final usageUserController = TextEditingController();
  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();


  DateTime start;
  DateTime end;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      SizedBox(height: defaultPadding),
              Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "General",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: defaultPadding),
                      Column(
                        children: [
                          SizedBox(height: 10),
                          Container(
                            child: Align(
                              child: TextFormField(
                                  controller: couponCodeController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Coupon Code',
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      String code = couponCodeController.text;
                                      couponCode = code;
                                    });
                                  }
                                // controller: fieldText,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Align(
                              child: TextFormField(
                                initialValue: discountType,
                                enabled: false,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
                                  ),
                                // controller: fieldText,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Align(
                              child: TextFormField(
                                  controller: amountController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Coupon Amount',
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      String temp = amountController.text;
                                      couponAmount = temp;
                                    });
                                  }
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
                      Container(
                        padding: EdgeInsets.all(defaultPadding),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "General",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(height: defaultPadding),
                            Column(
                              children: [
                                SizedBox(height: 10),
                                Container(
                                  child: Align(
                                    child: TextFormField(
                                        controller: spendController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Minimum Spend',
                                          contentPadding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            String temp = spendController.text;
                                            minimumSpend = temp;
                                          });
                                        }
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  child: Align(
                                    child: TextFormField(
                                        controller: usageCouponController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Usage Limit Per Coupon',
                                          contentPadding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            String temp = usageCouponController.text;
                                            limitCoupon = temp;
                                          });
                                        }
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  child: Align(
                                    child: TextFormField(
                                        controller: usageUserController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Usage Limit Per User',
                                          contentPadding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            String temp = usageUserController.text;
                                            limitUser = temp;
                                          });
                                        }
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            datePicker(),
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
                                      'Adding Coupon Details');

                                  if (action == DialogsAction.yes) {
                                    db.addCoupon();
                                    await AlertDialogs.successDialog(
                                        context,
                                        'You successfully added a coupon!',
                                        '');
                                  } else {}
                                },
                                icon: Icon(Icons.add),
                                label: Text("Save Coupon Configuration"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget datePicker() => Container(
      child: Column(
        children: [
          Center(
              child: TextField(
                controller: startDateInput,
                //editing controller TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Select Start Date"),
                readOnly: true,
                //set it true, so that user will not able to edit text
                onTap: () async {
                  start = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));

                  if (start != null) {
                    //print(pickedDate); //pickedDate output
                    startDate = DateFormat('yyyy-MM-dd').format(start);

                    setState(() {
                      startDateInput.text = startDate;
                      print("Start Date:" +
                          '$startDate'); //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              )),
          SizedBox(height: 10),
          Center(
              child: TextField(
                controller: endDateInput,
                //editing controller TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), labelText: "Select End Date"),
                readOnly: true,
                //set it true, so that user will not able to edit text
                onTap: () async {
                  end = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));
                  if (end != null) {
                    //print(pickedDate); //pickedDate output
                    endDate = DateFormat('yyyy-MM-dd').format(end);

                    setState(() {
                      endDateInput.text = endDate;
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              )),
        ],
      ));
}
