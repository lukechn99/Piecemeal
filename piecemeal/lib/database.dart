import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

/**
 * Sources:
 * https://codesundar.com/flutter-firebase-database-tutorial/
 * 
 */

class Database extends StatefulWidget {
  @override
  _DatabaseState createState() => _DatabaseState();
}

class _DatabaseState extends State<Database> {
  final textcontroller = TextEditingController();
  // final databaseRef = FirebaseDatabase.instance.reference();
  final databaseRef = FirebaseDatabase().reference().child('data');
  final Future<FirebaseApp> _future = Firebase.initializeApp();

  void addData(String data) {
    databaseRef
        .push()
        .set({'info': data, 'time': DateTime.now().millisecondsSinceEpoch});
  }

  void printFirebase() {
    databaseRef.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

  @override
  Widget build(BuildContext context) {
    printFirebase();
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Demo"),
      ),
      body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 250.0),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: textcontroller,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Center(
                        child: ElevatedButton(
                            onPressed: () {
                              addData(textcontroller.text);
                            },
                            child: Text('Add to database'))),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            printFirebase();
                          },
                          child: Text('Print database')),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
