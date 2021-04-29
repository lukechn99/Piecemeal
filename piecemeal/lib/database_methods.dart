import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseMethods {
  String _contents = "";
  final textcontroller = TextEditingController();
  // final databaseRef = FirebaseDatabase.instance.reference();
  final databaseRef = FirebaseDatabase().reference().child('data');
  final Future<FirebaseApp> _future = Firebase.initializeApp();

  void addData(String data) {
    databaseRef
        .push()
        .set({'info': data, 'time': DateTime.now().millisecondsSinceEpoch});
  }
}
