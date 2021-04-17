import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

/**
 * Sources:
 * [method setup] https://codesundar.com/flutter-firebase-database-tutorial/
 * [init user] https://stackoverflow.com/questions/52210694/flutter-how-to-write-data-in-firebase-realtime-ddb-permission-denied
 * [rules] https://firebase.google.com/docs/database/security
 */

class Database extends StatefulWidget {
  @override
  _DatabaseState createState() => _DatabaseState();
}

class _DatabaseState extends State<Database> {
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

  void printFirebase() {
    databaseRef.once().then((DataSnapshot snapshot) {
      setState(() {
        _contents = 'Data : ${snapshot.value}';
      });
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
                          child: Text('Show database')),
                    ),
                    Text(
                      '$_contents',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
