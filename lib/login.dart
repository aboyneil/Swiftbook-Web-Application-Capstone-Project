import 'package:admin/services/auth.dart';
import 'package:admin/widget/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/constants.dart';
import 'package:admin/widget/loading.dart';
import 'globals.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String destinationSelected = '';
  String email = '';
  String password = '';
  String error = '';

  bool showText = true; //show password
  bool rememberMe = false;

  final companyTextController = TextEditingController();

  CollectionReference<Map<String, dynamic>> adminCollection;

  void togglePasswordView() {
    setState(() {
      showText = !showText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            'assets/images/Swift_logo.png',
                            height: 200,
                            width: 200,
                          ),
                          Container(
                            height: 350,
                            width: 320,
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),

                                //Bus Company Dropdown
                                Container(
                                  child: dropdownButtonField(),
                                ),
                                //Email Field
                                Container(
                                  margin: EdgeInsets.all(30),
                                  width: 250,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      suffixIcon: Icon(
                                        Icons.account_circle_rounded,
                                        color: Colors.grey.withOpacity(0.8),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.8),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(0, 189, 56, 1.0),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter an email' : null,
                                    onChanged: (val) {
                                      setState(() {
                                        email = val;
                                      });
                                    },
                                  ),
                                ),

                                //Password Field

                                Container(
                                  width: 250,
                                  child: TextFormField(
                                    minLines: 1,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 2.5),
                                      labelText: 'Password',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.8),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(0, 189, 56, 1.0),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      //show or hide password

                                      suffixIcon: IconButton(
                                        color: Colors.grey,
                                        onPressed: (togglePasswordView),
                                        icon: showText
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility),
                                      ),
                                    ),
                                    obscureText: showText,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter a password' : null,
                                    onChanged: (val) {
                                      setState(() {
                                        password = val;
                                      });
                                    },
                                  ),
                                ),

                                Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 20, 40, 20)),

                                //button
                                Column(children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          setState(() => loading = true);

                                          // Admin details to be display on dashboard
                                          final CollectionReference
                                              adminCollection =
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      '$company' + '_admins');

                                          QuerySnapshot querySnapshot =
                                              await adminCollection.get();

                                          for (int i = 0;
                                              i < querySnapshot.docs.length;
                                              i++) {
                                            if (querySnapshot.docs[i]
                                                    ['email'] ==
                                                email) {
                                              userCompany = querySnapshot
                                                  .docs[i]
                                                  .get('company');
                                              userJobAccess = querySnapshot
                                                  .docs[i]
                                                  .get('job_access');
                                              userEmail = email;
                                            }
                                          }

                                          dynamic result = await _auth
                                              .signInWithEmailAndPass(
                                                  email, password);

                                          if (result == null) {
                                            setState(() {
                                              error =
                                                  'Could not sign in with those credentials';
                                              loading = false;
                                            });
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(100, 45),
                                        primary: primaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            side: BorderSide(
                                                color: Colors.transparent)),
                                      ),
                                      child: Text('Log in',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 0, 25, 0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        print('forgot password');
                                        final action = await AlertDialogs.forgotPasswordFieldDialog(context);

                                        if (action == DialogsAction.yes) {
                                          dynamic result = await _auth.resetPassword(ForgotPass);

                                          final action = await AlertDialogs.successDialog(
                                              context,
                                              'Change Password Now',
                                              'Reset Password Link was sent to your email');
                                        } else {

                                        }

                                      },
                                      child: Text(
                                        'Forgot password?',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontFamily: 'Poppins',
                                          fontSize:
                                          14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),

                                ]),
                                SizedBox(height: 4.5),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget dropdownButtonField() => Container(
        width: 250,
        child: new StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('bus_companies')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              } else {
                return DropdownButtonFormField(
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
                    "Select your company",
                  ),
                  onChanged: (value) {
                    setState(() {
                      company = value;
                    });
                  },
                  items: snapshot.data.docs.map((DocumentSnapshot docs) {
                    return new DropdownMenuItem<String>(
                      value: docs['company'],
                      child: new Text(
                        docs['company'].toUpperCase(),
                      ),
                    );
                  }).toList(),
                );
              }
            }),
      );
}
