import 'package:admin/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../globals.dart';
import '../../../models/analytic_info_model.dart';

class AnalyticInfoCard extends StatelessWidget {
  const AnalyticInfoCard({Key key, @required this.info}) : super(key: key);

  final AnalyticInfo info;

  Stream<QuerySnapshot> adminsCount() {
      return FirebaseFirestore.instance
          .collection("$company"+'_accounts')
          .snapshots();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15 / 2,
      ),
      decoration: BoxDecoration(
          color: secondaryColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ElevatedButton(onPressed: (){
              //   adminsCount(),
              //   print(snapshot.data.size.toString());
              // }),
              Text(
                info.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                // style: TextStyle(
                //   color: Colors.white,
                //   fontSize: 20,
                //   fontWeight: FontWeight.w300,
                // ),
              ),
              Container(
                // padding: EdgeInsets.all(15 / 2),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: info.color.withOpacity(0.1),
                    shape: BoxShape.circle),
                child: Icon(
                  info.icon,
                  color: info.color,
                )
              )
            ],
          ),
          if(info.title == 'Busses')
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("$company"+'_bus')
                  .snapshots(),
              builder: (context, snapshot){
                if (snapshot.hasData){
                  return Text(
                    _createText(snapshot.data).toString(),
                    // snapshot.data.length.toString(),
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator(),);
              }
          ),
          if(info.title == 'Accounts')
            StreamBuilder<QuerySnapshot>(
                stream: adminsCount(),
                builder: (context, snapshot){
                  if (snapshot.hasData){
                    return Text(
                      _createText(snapshot.data).toString(),
                      // snapshot.data.length.toString(),
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator(),);
                }
            ),
          if(info.title == 'Trips')
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("$company"+'_trips')
                    .where("Travel Status", isEqualTo: 'Upcoming')
                    .snapshots(),
                builder: (context, snapshot){
                  if (snapshot.hasData){
                    return Text(
                      _createText(snapshot.data).toString(),
                      // snapshot.data.length.toString(),
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator(),);
                }
            ),
          if(info.title == 'Passengers')
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("$company"+'_bookingForms')
                    .where("Booking Status", isEqualTo: 'Active')
                    .snapshots(),
                builder: (context, snapshot){
                  if (snapshot.hasData){
                    return Text(
                      _createText(snapshot.data).toString(),
                      // snapshot.data.length.toString(),
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator(),);
                }
            ),
        ],
      ),
    );
  }
  String _createText(QuerySnapshot snapshot) {
    print(snapshot.docs.length);
    print("$userCompany"+'_admins');
    int newText = snapshot.docs.length;
    String finalText = newText.toString();
    return finalText;
  }

}
