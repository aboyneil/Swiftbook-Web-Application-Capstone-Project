
import 'package:admin/constants.dart';
import 'package:admin/globals.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';
import 'components/AddBus_field_details.dart';

class BusPanelPage extends StatelessWidget {


  Widget build(BuildContext context) {

    return SafeArea(
      child: SingleChildScrollView(
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
                      if (userJobAccess == "admin") BusDetails(),


                      // if (Responsive.isMobile(context))
                      //   SizedBox(height: defaultPadding),
                      // if (Responsive.isMobile(context)&& userJobAccess!="ticketing clerk") BusStatus(),
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
}
