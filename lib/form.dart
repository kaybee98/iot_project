import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'main.dart';
import 'Stat.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  int _selectedPage = 0;
  List<String> questions = ["Do you like this form","Any questions ?","Do you prefer corn or carrot ?","Pick the food you like"];
  List<String> type =["YesNo","Textinput","Choose1","ChooseMany"];
  List<String> Possibility = [];
  List<List<String>> solution = [[""],[""],["Corn","Carrot"],["Ice Cream","Pizza","Pop Corn","Burger"]];
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("FormPage"),
      ),
      body: Center(

      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color : Colors.black),
            label: 'HomePage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list, color : Colors.black),
            label: 'Form',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart, color : Colors.black),
            label: 'Form',
          ),
        ],
        currentIndex: _selectedPage,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
    if(index==0) _navigateToHomePage(context);
    else if(index==1) _navigateToFormPage(context);
    else _navigateToStatPage(context);
  }
  void _navigateToStatPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => StatPage()));
  }
  void _navigateToHomePage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MyHomePage(title: 'Home Page')));
  }
  void _navigateToFormPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => FormPage()));
  }
}
