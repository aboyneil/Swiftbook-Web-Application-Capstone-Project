import 'package:admin/constants.dart';
import 'package:admin/routes/routeName.dart';
import 'package:admin/routes/router_genertor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:admin/login.dart';
import 'package:flutter/material.dart';
import 'package:admin/models/user.dart';
import 'models/user.dart';
import 'screens/dashboard/main/main_screen.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    print(user);
    if (user == null) {
      return Login();
    } else {
      return MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        // Why builder is used: https://stackoverflow.com/questions/49748759/example-for-builder-property-in-materialapp-class-in-flutter
        builder: (_, child) => MainScreen(
          child: child,

        ),
        initialRoute: routeHome,
        navigatorKey: navKey,
        onGenerateRoute: RouteGenerator.generateRoute,
      );
    }
  }
}
