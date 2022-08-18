import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../globals.dart';
import '../../../responsive.dart';
import '../../../widget/alert_dialog.dart';
import '../../../widget/date_time_picker.dart';

class discountIDCategory extends StatefulWidget {
  const discountIDCategory({Key key}) : super(key: key);

  @override
  _DiscountIDCategoryState createState() => _DiscountIDCategoryState();
}

class _DiscountIDCategoryState extends State<discountIDCategory> {
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
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Apply for Discount",
            style: Theme.of(context).textTheme.subtitle1,
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
                        await AlertDialogs.discountIDCategoryDialog(context);

                    if (action == DialogsAction.yes) {
                      if (discountIDFullName == null ||
                          discountIDEmail == null ||
                          selectedDiscountIDCategory == null ||
                          discountID == null) {
                        await AlertDialogs.errorDialog(
                            context, 'Enter valid Data', '');
                      } else {
                        print(discountIDFullName);
                        print(discountIDEmail);
                        print(selectedDiscountIDCategory);
                        print(discountID);
                        db.addDiscountID();
                        await AlertDialogs.successDialog(context,
                            'You successfully added a Discount ID', '');
                      }
                    } else {}
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add New"),
                ),
              ),
              SizedBox(width: defaultPadding),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: ElevatedButton.icon(
              //     style: TextButton.styleFrom(
              //       backgroundColor: bgColor,
              //       padding: EdgeInsets.symmetric(
              //         horizontal: defaultPadding * 1,
              //         vertical: defaultPadding /
              //             (Responsive.isMobile(context) ? 2 : 1),
              //       ),
              //     ),
              //     onPressed: () async {
              //       showDialog(
              //         context: context,
              //         builder: (BuildContext context) =>
              //             _buildPopupDialog(context),
              //       );
              //     },
              //     icon: Icon(Icons.remove_red_eye_sharp),
              //     label: Text("View"),
              //   ),
              // ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Price Categories'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SingleChildScrollView(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('$company' + '_priceCategories')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return new Text('Loading...');
                  return DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Category Name',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Discount by %',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                    rows: _createRows(snapshot.data),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

List<DataRow> _createRows(QuerySnapshot snapshot) {
  List<DataRow> newList =
      snapshot.docs.map((DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data();
    return new DataRow(cells: [
      DataCell(Text(data['category'].toString())),
      DataCell(Text(data['discount'].toString())),
    ]);
  }).toList();

  return newList;
}
