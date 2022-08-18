import 'package:admin/routes/routeName.dart';
import 'package:admin/screens/Account/account_panel.dart';
import 'package:admin/screens/AddBusPanel/bus_detailspage.dart';
import 'package:admin/screens/AddTripPanel/addTrip_page.dart';
import 'package:admin/screens/CategoryPanel/categoryPanel.dart';
import 'package:admin/screens/WalkInPanel/walkIn_generateSeats.dart';
import 'package:admin/screens/content/bookings.dart';
import 'package:admin/screens/BusDetails/bus_details.dart';
import 'package:admin/screens/HomePage/home.dart';
import 'package:admin/screens/content/records.dart';
import 'package:admin/screens/TripDetails/trip_details.dart';
import 'package:flutter/material.dart';

import '../screens/Logs/logs.dart';
import '../screens/SalesPanel/salePanel.dart';
import '../screens/WalkInPanel/walkIn.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(builder: (_) => HomePage());
        break;
      case routeBookings:
        return MaterialPageRoute(builder: (_) => BookingsPage());
        break;
      case routeSales:
        return MaterialPageRoute(builder: (_) => SalesPage());
        break;
      case routeBusDetails:
        return MaterialPageRoute(builder: (_) => BusDetailsPanel());
        break;
      case routeAddBus:
        return MaterialPageRoute(builder: (_) => BusPanelPage());
        break;
      case routeWalkIn:
        return MaterialPageRoute(builder: (_) => WalkInPanel());
        break;
      case routeTripDetails:
        return MaterialPageRoute(builder: (_) => TripDetailsPanel());
        break;
      case routeAddTrip:
        return MaterialPageRoute(builder: (_) => AddTripPanelPage());
        break;
      case routeAccount:
        return MaterialPageRoute(builder: (_) => AccountPanel());
        break;
      case routeRecords:
        return MaterialPageRoute(builder: (_) => RecordPage());
        break;
      case routeCategory:
        return MaterialPageRoute(builder: (_) => CategoryPanel());
        break;
      case routeLogs:
        return MaterialPageRoute(builder: (_) => LogsPanel());
        break;
      case routeGenerateSeats:
        return MaterialPageRoute(builder: (_) => WalkInGenerateSeats());
        break;
    }
  }

  Future reopen() async {
    MaterialPageRoute(builder: (_) => BusPanelPage());
  }
}
