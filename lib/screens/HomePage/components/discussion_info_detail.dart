// import 'package:admin/constants.dart';
// import 'package:flutter/material.dart';
//
//
// class DiscussionInfoDetail extends StatelessWidget {
//   const DiscussionInfoDetail({Key key, @required this.info}) : super(key: key);
//
//   // final DiscussionInfoModel info;
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         margin: EdgeInsets.only(top: 15),
//         padding: EdgeInsets.all(15 / 2),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(40),
//               child: Image.asset(
//                 info.imageSrc,
//                 height: 38,
//                 width: 38,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: appPadding),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       info.name,
//                       style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.w600
//                       ),
//                     ),
//
//                     Text(
//                       info.date!,
//                       style: TextStyle(
//                         color: primaryColor.withOpacity(0.5),
//                         fontSize: 13,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Icon(Icons.more_vert_rounded,color: primaryColor.withOpacity(0.5),size: 18,)
//           ],
//         ),
//       ),
//     );
//   }
// }