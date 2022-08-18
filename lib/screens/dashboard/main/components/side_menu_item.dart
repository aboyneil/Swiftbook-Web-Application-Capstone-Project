import 'package:admin/routes/routeName.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../globals.dart';

class DrawerListTile extends StatelessWidget {
  final bool selected;
  final String routeName;
  final Function onHighlight;

  const DrawerListTile({
    Key key,
    // For selecting those three line once press "Command+D"
    @required this.title,
    @required this.selected,
    @required this.svgSrc,
    @required this.press,
    @required this.routeName,
    @required this.onHighlight,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  Future<void> checkBaggagePolicy() async {
    String tempUID;
    var result = await FirebaseFirestore.instance
        .collection('$company' + '_Policies')
        .where('category', isEqualTo: 'baggage')
        .get();
    if (result.docs.length == 0) {
    } else {
      result.docs.forEach((val) {
        tempUID = val.id;
      });
      var dbResult = await FirebaseFirestore.instance
          .collection('$company' + '_Policies')
          .doc(tempUID)
          .get();

      checkBaggage = dbResult.get('status');
    }
  }

  Future<void> checkRebookingPolicy() async {
    String tempUID;
    var result = await FirebaseFirestore.instance
        .collection('$company' + '_Policies')
        .where('category', isEqualTo: 'rebooking')
        .get();
    if (result.docs.length == 0) {
    } else {
      result.docs.forEach((val) {
        tempUID = val.id;
      });
      var dbResult = await FirebaseFirestore.instance
          .collection('$company' + '_Policies')
          .doc(tempUID)
          .get();

      checkRebooking = dbResult.get('status');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        onTap: () {
          if (routeName == '/category') {
            checkBaggagePolicy();
            navKey.currentState.pushNamed(routeName);
            onHighlight(routeName);
            print('Selected:' + "$selected");
          } else {
            navKey.currentState.pushNamed(routeName);
            onHighlight(routeName);
            print('Selected:' + "$selected");
          }
        },
        horizontalTitleGap: 0.0,
        leading: SvgPicture.asset(
          svgSrc,
          color: selected == true
              ? Color.fromRGBO(24, 168, 30, 1.0)
              : Colors.white54,
          height: 16,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: selected == true
                ? Color.fromRGBO(24, 168, 30, 1.0)
                : Colors.white54,
          ),
        ),
      ),
    );
  }
}
