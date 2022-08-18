import 'package:admin/screens/CategoryPanel/components/boolCoupon.dart';
import 'package:admin/screens/CategoryPanel/components/boolRebooking.dart';
import 'package:admin/screens/CategoryPanel/components/boolRefund.dart';
import 'package:admin/screens/CategoryPanel/components/busClass.dart';
import 'package:admin/screens/CategoryPanel/components/destinationField.dart';
import 'package:admin/screens/CategoryPanel/components/originField.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../dashboard/components/header.dart';
import 'components/boolBaggage.dart';
import 'components/discountID.dart';
import 'components/priceCategory.dart';

class CategoryPanel extends StatefulWidget {
  const CategoryPanel({Key key}) : super(key: key);

  @override
  _CategoryPanelState createState() => _CategoryPanelState();
}

class _CategoryPanelState extends State<CategoryPanel> {
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
                      PriceCategory(),
                      SizedBox(height: defaultPadding),
                      BusClass(),
                      SizedBox(height: defaultPadding),
                      OriginField(),
                      SizedBox(height: defaultPadding),
                      DestinationField(),
                      SizedBox(height: defaultPadding),
                      discountIDCategory(),
                      SizedBox(height: defaultPadding),
                      baggageCheck(),
                      SizedBox(height: defaultPadding),
                      RebookingCheck(),
                      SizedBox(height: defaultPadding),
                      CouponCheck(),
                      SizedBox(height: defaultPadding),
                      RefundField(),
                    ],
                  ),
                ),

                // if (!Responsive.isMobile(context))
                //   SizedBox(width: defaultPadding),
                // // On Mobile means if the screen is less than 850 we dont want to show it
                // if (!Responsive.isMobile(context) && userJobAccess!="ticketing clerk")
                //   Expanded(
                //     flex: 2,
                //     child: BusStatus(),
                //   ),
                // if (userJobAccess == "ticketing clerk")
                //       Expanded(
                //         child: Container(
                //           padding: EdgeInsets.all(defaultPadding),
                //           decoration: BoxDecoration(
                //             color: secondaryColor,
                //             borderRadius: const BorderRadius.all(Radius.circular(10)),
                //           ),
                //         child: Text("You cannot access this panel"),
                //         ),
                //       ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
