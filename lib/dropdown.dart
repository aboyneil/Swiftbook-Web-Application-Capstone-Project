import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropdownButtonFormFieldExample extends StatefulWidget {
  @override
  _DropdownButtonFormFieldExampleState createState() =>
      _DropdownButtonFormFieldExampleState();
}

class _DropdownButtonFormFieldExampleState
    extends State<DropdownButtonFormFieldExample> {
  final updateFormKey = GlobalKey<FormState>();
  String shopId = '';
  DocumentSnapshot currentCategory;
  TextEditingController categoryController = new TextEditingController();
  String categoryname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dropdown Button'),),
          body: Container(
       child: 
                Column(
                  children: <Widget>[
                    new StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('bus_companies')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CupertinoActivityIndicator(),
                              );
                            } else {
                              var destinationSelected;
                              return DropdownButtonFormField(
                                decoration: InputDecoration(
                                    labelText: destinationSelected == null
                                        ? ''
                                        : "To:",
                          
                                    border: InputBorder.none,
                         
                                    icon: Icon(
                                      Icons.house,
                                  
                                    )),
                         
                                iconSize: 0,
                                hint: Text(
                                  "Select your company",
                         
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    destinationSelected = value;
                      
                                  });
                                },
                                items: snapshot.data.docs
                                    .map((DocumentSnapshot docs) {
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
                  ],
                ),
                
            
  

      ),
    );
  }
}