import 'package:admin/constants.dart';
import 'package:admin/screens/HomePage/components/radial_painter.dart';
import 'package:flutter/material.dart';


class UsersByDevice extends StatelessWidget {
  const UsersByDevice({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        // margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.all(10),
        height: 280,
        width: 5,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),

        child: Column(
        //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Users by device',
              style: TextStyle(
                color: primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              height: 230,
              width: 25,
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                  bgColor: primaryColor.withOpacity(0.1),
                  lineColor: primaryColor,
                  percent: 0.7,

                ),
                child: Center(
                  child: Text(
                    '70%',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: primaryColor,
                        size: 10,
                      ),
                      SizedBox(width: 15 /2,),
                      Text('Desktop',style: TextStyle(
                        color: primaryColor.withOpacity(0.5),
                        fontWeight: FontWeight.bold,
                      ),)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: primaryColor.withOpacity(0.2),
                        size: 10,
                      ),
                      SizedBox(width: 15 /2,),
                      Text('Mobile',style: TextStyle(
                        color: primaryColor.withOpacity(0.5),
                        fontWeight: FontWeight.bold,
                      ),)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
