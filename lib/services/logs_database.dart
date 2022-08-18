import 'package:admin/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogsService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Add Bus Details
  Future<void> addLogs(String text) async {
    try {
      FirebaseFirestore.instance.collection('$company' + '_admins').doc(_auth.currentUser.uid).collection('logs').add({
        'email': _auth.currentUser.email ,
        'text': text,
        'datetime': DateTime.now().toString(),
      });

      FirebaseFirestore.instance.collection('$company' + '_logs').add({
        'email': _auth.currentUser.email ,
        'text': text,
        'datetime': DateTime.now().toString(),
      });


    } catch (e) {
      print(e.toString());
      return null;
    }
  }



}
