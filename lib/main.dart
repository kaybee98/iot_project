import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'listviewform.dart';
var db = FirebaseFirestore.instance;
void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
        MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => MyHome(),
            '/listviewform': (context) => const Listviewform(),
          },
        ),
      );

  var snapshot = await db.collection('forms').get();
  for (var doc in snapshot.docs){
    print(doc.data());
  }

}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Forms'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/listviewform');
          },
          child: const Text('Refresh'),
        ),
      ),
    );
  }
}

