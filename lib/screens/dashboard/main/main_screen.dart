import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../globals.dart';
import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  final Widget child;
  const MainScreen({@required this.child});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    conlogin();
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          children: [
            if (Responsive.isDesktop(context)) SideMenu(),
            Expanded(child: widget.child)
            // Header(), children: widget.child)],
          ],
        ),
      ),
    );
  }
}


Future<void> conlogin() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference busCollection =
  FirebaseFirestore.instance
      .collection('bus_companies');

  List<String> buscom = [];

  QuerySnapshot querySnapshot = await busCollection.get();
  for (int i = 0; i < querySnapshot.docs.length; i++) {
    buscom.insert(i, querySnapshot.docs[i]['company']);
  }
  print(buscom);


  bool flag = false;
  for (int j = 0; j < buscom.length; j++) {

    final CollectionReference adminCollection =
    FirebaseFirestore.instance.collection(buscom[j]+'_admins');
    QuerySnapshot querySnapshot = await adminCollection.get();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i]['email'] == _auth.currentUser.email) {
        userCompany = querySnapshot
            .docs[i]
            .get('company');
        userJobAccess = querySnapshot
            .docs[i]
            .get('job_access');

        userEmail = email;
        company = userCompany;

        flag = true;
        break;
      }
    }

    if (flag == true) {
      break;
    }
  }
  // List.generate(busCompanyNotifier.busCompanyList.length, (index) {
  //   List<String> busComp = busCompanyNotifier.busCompanyList[index].busCompany;
  //
  //   Text( busCompanyNotifier.busCompanyList[index].busCompany);
  // });
}

