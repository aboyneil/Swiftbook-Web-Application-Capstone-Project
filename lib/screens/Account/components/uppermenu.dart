import 'package:admin/constants.dart';
import 'package:admin/globals.dart';
import 'package:admin/responsive.dart';
import 'package:admin/routes/routeName.dart';
import 'package:admin/screens/Account/components/generate_pwd.dart';
import 'package:admin/services/logs_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:admin/services/auth.dart';
import 'package:admin/services/database.dart';

import '../../../widget/alert_dialog.dart';

class UpperMenu extends StatefulWidget {
  @override
  _UpperMenuState createState() => _UpperMenuState();
}

class _UpperMenuState extends State<UpperMenu> {
  final _key = GlobalKey<FormState>();
  final DatabaseService db = DatabaseService();
  final AuthService _auth = AuthService();
  final LogsService _logs = LogsService();
  final generatePWD_controller = TextEditingController();

  bool loading = false;
  String error = '';
  String password = null;
  String chooseValue = null;

  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _jobaccess = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  List listItem = ["Admin", "Driver", "Ticketing Clerk"];

  @override
  void dispose() {
    generatePWD_controller.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Bus Details",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                  defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () async {
                await showInformationDialog(context);
              },
              icon: Icon(Icons.add),
              label: Text("Add New"),
            ),
          ],
        ),
      ],
    );
  }

  Widget GeneratePasswordField() => Container(
    child: Column(
      children: [
        Text(
          'Random Password Generator',
        ),
        const SizedBox(height: 12),
        TextField(
          controller: generatePWD_controller,
          readOnly: true,
          enableInteractiveSelection: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(Icons.copy),
              onPressed: () {
                final passwordCopied =
                ClipboardData(text: generatePWD_controller.text);
                Clipboard.setData(passwordCopied);

                if (passwordCopied != null) {
                  print(
                    '✓ Password Copied!',
                  );
                }

                // final snackBar = SnackBar(
                //   content: Text(
                //     '✓ Password Copied!',
                //     style: TextStyle(color: Colors.white),
                //   ),
                //   backgroundColor: Color.fromRGBO(24, 168, 30, 1.0),
                //   duration: Duration(seconds: 1),
                // );

                // ScaffoldMessenger.of(context)
                //   ..showSnackBar(snackBar);
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        buildButton(),
      ],
    ),
  );

  Widget buildButton() {
    final backgroundColor = MaterialStateColor.resolveWith((states) =>
    states.contains(MaterialState.pressed)
        ? Colors.black
        : Color.fromRGBO(37, 150, 190, 1.0));
    return Align(
      alignment: Alignment.centerLeft,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: backgroundColor),
        child: Text('Generate Password'),
        onPressed: () {
          final pass = generatePassword();
          generatePWD_controller.text = pass;
          password = pass;
        },
      ),
    );
  }

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController categoryTextController =
          TextEditingController();
          final TextEditingController discountTextController =
          TextEditingController();
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'New Account',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                            ),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            controller: _fullname,
                            keyboardType: TextInputType.name,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Please enter a Full Name";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) {
                              setState(() => fullname = val);
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Please enter an email address";
                              } else if (!RegExp(
                                  "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return "Please enter a valid email address";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Username',
                            ),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            controller: _username,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Please enter an Username";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) {
                              setState(() => username = val);
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: jobAccess(),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: GeneratePasswordField(),
                        ),
                      ],
                    ),
                  )),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                  style: TextButton.styleFrom(
                    backgroundColor: errorColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: defaultPadding /
                          (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                ),
                ElevatedButton(
                  child: const Text('Add'),
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: defaultPadding /
                          (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () async {
                    if (password == null ||
                        chooseValue == null ||
                        email == null ||
                        fullname == null ||
                        username == null) {
                      await AlertDialogs.errorAddAccount(context);
                    } else {
                      if (_formKey.currentState.validate()) {
                        //proceed to add account
                        setState(() => loading = true);
                        var dbResult;
                        bool emailExist;
                        bool usernameExist;

                        //If Job Access is Admin or Ticketing Clerk
                        if (chooseValue == 'Admin' ||
                            chooseValue == 'Ticketing Clerk') {
                          //Check if Email is Existing
                          dbResult = await FirebaseFirestore.instance
                              .collection('$company' + '_admins')
                              .where('email', isEqualTo: email)
                              .get();
                          if (dbResult.docs.length == 0) {
                            emailExist = false;
                          } else {
                            emailExist = true;
                          }
                          //
                          //Check if Username Exist
                          dbResult = await FirebaseFirestore.instance
                              .collection('$company' + '_admins')
                              .where('username', isEqualTo: username)
                              .get();
                          if (dbResult.docs.length == 0) {
                            usernameExist = false;
                          } else {
                            usernameExist = true;
                          }
                          if (emailExist == true && usernameExist == true) {
                            await AlertDialogs.errorUserandEmail(context);
                          } else if (emailExist == true) {
                            await AlertDialogs.errorEmailExist(context);
                          } else if (usernameExist == true) {
                            await AlertDialogs.errorUsernameExist(context);
                          } else {
                            //If username and email does not exist, create account
                            String result =
                            await _auth.registerInsideWeb(email, password);
                            if (result == null) {
                              //If acc creation failed
                              setState(() {
                                error = 'Error Creating Account';
                                loading = false;
                              });
                            } else {
                              //If acc creation success
                              db.accRegisterAdmins(email, fullname, chooseValue,
                                  username, result);
                              db.accCompany(email, fullname, chooseValue,
                                  username, result);

                              _logs.addLogs(
                                  'Created $chooseValue Account $email');

                              //Pop up

                              await AlertDialogs.successDialog(context,
                                  'You successfully added an Account', '');
                              fullname = null;
                              email = null;
                              chooseValue = null;
                              username = null;
                              dbResult = null;
                              emailExist = null;
                              usernameExist = null;
                              password = null;
                              //controllers
                              _fullname.clear();
                              _email.clear();
                              _username.clear();
                              chooseValue = null;
                              generatePWD_controller.clear();

                              Navigator.of(context).pop();
                            }
                          }
                        } else {
                          //
                          //
                          //If value choose is Drivers
                          //Check if Email is Existing
                          dbResult = await FirebaseFirestore.instance
                              .collection('$company' + '_drivers')
                              .where('email', isEqualTo: email)
                              .get();
                          if (dbResult.docs.length == 0) {
                            emailExist = false;
                          } else {
                            emailExist = true;
                          }
                          //
                          //Check if Username Exist
                          dbResult = await FirebaseFirestore.instance
                              .collection('$company' + '_drivers')
                              .where('username', isEqualTo: username)
                              .get();
                          if (dbResult.docs.length == 0) {
                            usernameExist = false;
                          } else {
                            usernameExist = true;
                          }

                          if (emailExist == true && usernameExist == true) {
                            await AlertDialogs.errorUserandEmail(context);
                          } else if (emailExist == true) {
                            await AlertDialogs.errorEmailExist(context);
                          } else if (usernameExist == true) {
                            await AlertDialogs.errorUsernameExist(context);
                          } else {
                            //If username and email does not exist, create account
                            String result =
                            await _auth.registerInsideWeb(email, password);
                            if (result == null) {
                              //If acc creation failed
                              setState(() {
                                error = 'Error Creating Account';
                                loading = false;
                              });
                            } else {
                              //If acc creation success
                              db.accRegisterDrivers(email, fullname,
                                  chooseValue, username, result);
                              db.accCompany(email, fullname, chooseValue,
                                  username, result);

                              _logs.addLogs(
                                  'Created a $chooseValue Account $email');

                              //Pop up
                              await AlertDialogs.successDialog(context,
                                  'You successfully added an Account', '');
                              //variables
                              fullname = null;
                              email = null;
                              chooseValue = null;
                              username = null;
                              dbResult = null;
                              emailExist = null;
                              usernameExist = null;
                              password = null;
                              //controllers
                              _fullname.clear();
                              _email.clear();
                              _username.clear();
                              chooseValue = null;
                              generatePWD_controller.clear();

                              Navigator.of(context).pop();
                            }
                          }
                        }

                        //navKey.currentState.pushNamed(routeAccount);
                      } else {
                        await AlertDialogs.ErroralertDialog(
                          context,
                        );
                      }
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  Widget jobAccess() => DropdownButtonFormField(
    isExpanded: true,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey.withOpacity(0.8),
        ),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(0, 189, 56, 1.0),
        ),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
    ),
    hint: Text(
      "Select Job Access",
    ),
    onChanged: (value) {
      setState(() {
        chooseValue = value;
      });
    },
    items: listItem.map((valueItem) {
      return DropdownMenuItem(
        value: valueItem,
        child: Text(valueItem),
      );
    }).toList(),
  );
}
