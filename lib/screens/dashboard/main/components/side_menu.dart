import 'package:admin/routes/routeName.dart';
import 'package:admin/services/auth.dart';
import 'package:admin/widget/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'side_menu_item.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int index = 0;
  final AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/Swift_logo.png"),
          ),
          DrawerListTile(
            selected: index == 0,
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            routeName: routeHome,
            onHighlight: onHighlight,
            press: () {},
          ),
          DrawerListTile(
            selected: index == 1,
            title: "Reservation",
            svgSrc: "assets/icons/menu_tran.svg",
            routeName: routeBookings,
            onHighlight: onHighlight,
            press: () {},
          ),
          DrawerListTile(
            selected: index == 2,
            title: "Sales",
            svgSrc: "assets/icons/menu_tran.svg",
            routeName: routeSales,
            onHighlight: onHighlight,
            press: () {},
          ),
          DrawerListTile(
            selected: index == 3,
            title: "Bus Details",
            svgSrc: "assets/icons/menu_task.svg",
            routeName: routeBusDetails,
            onHighlight: onHighlight,
            press: () {},
          ),
          DrawerListTile(
            selected: index == 4,
            title: "Add Bus",
            svgSrc: "assets/icons/menu_doc.svg",
            routeName: routeAddBus,
            onHighlight: onHighlight,
            press: () {},
          ),
          DrawerListTile(
            selected: index == 5,
            title: "Walk-In Reservation",
            svgSrc: "assets/icons/Documents.svg",
            routeName: routeWalkIn,
            onHighlight: onHighlight,
            press: () {},
          ),
          DrawerListTile(
            selected: index == 6,
            title: "Trip Details",
            svgSrc: "assets/icons/menu_store.svg",
            routeName: routeTripDetails,
            onHighlight: onHighlight,
            press: () {},
          ),
          DrawerListTile(
            selected: index == 7,
            title: "Add Trip",
            svgSrc: "assets/icons/menu_notification.svg",
            routeName: routeAddTrip,
            onHighlight: onHighlight,
            press: () {},
          ),
          DrawerListTile(
            selected: index == 8,
            title: "Categories",
            svgSrc: "assets/icons/menu_setting.svg",
            routeName: routeCategory,
            onHighlight: onHighlight,
            press: () {},
          ),
          DrawerListTile(
            selected: index == 9,
            title: "Logs",
            svgSrc: "assets/icons/Documents.svg",
            routeName: routeLogs,
            onHighlight: onHighlight,
            press: () {},
          ),
           DrawerListTile(
            selected: index == 10,
            title: "Account",
            svgSrc: "assets/icons/Documents.svg",
            routeName: routeAccount,
            onHighlight: onHighlight,
            press: () {},
          ),
          Divider(
            thickness: 3,
          ),
          Column(
            children: [
              TextButton(
                  onPressed: () async {
                    final action = await AlertDialogs.sureDialog(
                        context,
                        'Are you sure you want to Logout?',
                        'Logout'
                    );

                    if (action == DialogsAction.yes) {
                      await _auth.signOut();

                    } else {

                    }
                      },
                  child: Text('Logout'))
            ],

          ),
        ],
      ),
    );
  }
  void onHighlight(String route) {
    switch (route) {
      case routeHome:
        changeHighlight(0);
        break;
      case routeBookings:
        changeHighlight(1);
        break;
      case routeSales:
        changeHighlight(2);
        break;
      case routeBusDetails:
        changeHighlight(3);
        break;
      case routeAddBus:
        changeHighlight(4);
        break;
      case routeWalkIn:
        changeHighlight(5);
        break;
      case routeTripDetails:
        changeHighlight(6);
        break;
      case routeAddTrip:
        changeHighlight(7);
        break;
      case routeCategory:
        changeHighlight(8);
        break;
      case routeLogs:
        changeHighlight(9);
        break;
      case routeAccount:
        changeHighlight(10);
        break;
    }
  }

  void changeHighlight(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }
}

