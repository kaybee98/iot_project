import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iot_project/Draw.dart';
import 'firebase_options.dart';
import 'main.dart';
import 'form.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:graphic/graphic.dart';

class StatPage extends StatefulWidget {
  const StatPage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<StatPage> createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  int _selectedPage = 2;
  List<String> questions = ["Do you like this form","Any questions ?","Do you prefer corn or carrot ?","Pick the food you like"];
  List<String> type =["YesNo","TextInput","Choose1","ChooseMany"];
  List<List<String>> solution = [[""],[""],["Corn","Carrot"],["Ice Cream","Pizza","Pop Corn","Burger"]];
  List<List<String>> answers = [["Yes","","Corn","IceCream Pizza"],["No","what's the weather right now ?","Corn","IceCream"],["Yes","no question","Corn","IceCream PopCron Burger"]];
  List<List<int>> stats = <List<int>>[];
  List<String> text = <String>[];
  void Stats(){
    for(int i=0;i<type.length;i++){
      if(type[i]=="YesNo"){
        stats[i]=[0,0,0];
        for(int j=0;j<answers.length;j++){
          if(answers[j][i]=="Yes"){
            stats[i][1]++;
          }else{
            stats[i][2]++;
          }
        }
      }
      if(type[i]=="TextInput"){
        stats[i]=[1];
        for(int j=0;j<answers.length;j++){
          text[j]=answers[j][i];
        }
      }
      if(type[i]=="Choose1") {
        stats[i] = [2];
        for (int k = 1; k < solution[i].length; k++) {
          stats[i][k] = 0;
          for (int j = 0; j < answers.length; j++) {
            if (answers[j][i] == solution[i][k]) {
              stats[i][k]++;
            }
          }
        }
      }
      if(type[i]=="ChooseMany") {
        stats[i] = [3];
        for (int k = 1; k < solution[i].length; k++) {
          stats[i][k]=0;
          for (int j = 0; j < answers.length; j++) {
            if (answers[j][i].contains(solution[i][k])) {
              stats[i][k]++;
            }
          }
        }
      }
    }
    print(stats);
  }
  List<List<int>> teststats = [[0,5,3],[1],[2,43,25],[3,12,2,65,30]];
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
        child: Column(
          children: [
            Chart(
              data: [
                { 'genre': 'Sports', 'sold': 275 },
                { 'genre': 'Strategy', 'sold': 115 },
                { 'genre': 'Action', 'sold': 120 },
                { 'genre': 'Shooter', 'sold': 350 },
                { 'genre': 'Other', 'sold': 150 },
              ],
              variables: {
                'genre': Variable(
                  accessor: (Map map) => map['genre'] as String,
                ),
                'sold': Variable(
                  accessor: (Map map) => map['sold'] as num,
                ),
              },
              elements: [IntervalElement()],
              axes: [
                Defaults.horizontalAxis,
                Defaults.verticalAxis,
              ],
            ),
          ],
        ),
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
            label: 'Stat',
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
        .push(MaterialPageRoute(builder: (context) => GraphScreen()));
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
