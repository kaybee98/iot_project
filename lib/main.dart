import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'listviewform.dart';
import 'package:charts_flutter/flutter.dart' as charts;
var db = FirebaseFirestore.instance;
void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
        Answeralyzer()
      );



}
class Answeralyzer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Answeralyzer',
      theme: ThemeData.light(),
      home: Scaffold(
        body:FormsListView(title: 'My forms'),
      ),
    );
  }
}
class FormsListView extends StatefulWidget {
  const FormsListView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<FormsListView> createState() => _FormsListViewState();
}

class _FormsListViewState extends State<FormsListView> {
  List<Map<String,String>> formsList =[];
  void refreshForms() async {
    var snapshot = await db.collection('forms').get();
    formsList.clear();
    for (var doc in snapshot.docs){
      final datad = doc.data() as Map<String,dynamic>;
      setState(() {
        formsList.add({'title':datad['title'].toString(),'ID':doc.reference.id});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   //refreshForms();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: (){refreshForms();}, icon: Icon(Icons.refresh))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(itemCount: formsList.length,
                    itemBuilder: (context,index){
                    final currentForm = formsList[index];
                      return Card(
                        child: ListTile(title: Text(currentForm['title'].toString()),
                          onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>QuestionsListView(formInfo:formsList[index])));
                          },),

                      );
                    }
                )
            ),
          ],
        ),
      )
    );
  }
}

class QuestionsListView extends StatefulWidget {
  const QuestionsListView({Key? key, required this.formInfo}) : super(key: key);
  final Map<String,String> formInfo;

  @override
  State<QuestionsListView> createState() => _QuestionsListViewState();
}

class _QuestionsListViewState extends State<QuestionsListView> {
  List<Map<String,dynamic>> questionsList = [];
  void refreshQs() async {
    final formID = widget.formInfo['ID'];
    var snapshot = await db.collection('forms/$formID/questions').get();
    questionsList.clear();
    for (var doc in snapshot.docs){
      final qTit = doc.data()['title'];
      final qOps = doc.data()['options'] as Map<String,dynamic>;

      Map<String,dynamic> currentQ = {'title':qTit,'options':qOps};
      setState(() {
        questionsList.add(currentQ);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    //refreshQs();
    return Scaffold(
        appBar: AppBar(
          title: Text('"${widget.formInfo['title']}" - Questions'),
          actions: [
            IconButton(onPressed: (){refreshQs();}, icon: Icon(Icons.refresh))
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(itemCount: questionsList.length,
                      itemBuilder: (context,index){
                        final currQ = questionsList[index];
                        final currTitle = currQ['title'].toString();
                        final currOpts = currQ['options'] as Map<String,dynamic>;
                        return Card(
                          child: ListTile(title: Text(currTitle),
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder:
                                  (context)=>GraphView(qData:questionsList[index])));
                            },),

                        );
                      }
                  )
              ),
            ],
          ),
        )
    );
  }
}

class GraphView extends StatefulWidget {
  const GraphView({Key? key, required this.qData}) : super(key: key);
  final Map<String,dynamic> qData;

  @override
  State<GraphView> createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  @override
  Widget build(BuildContext context) {
    Map<String,dynamic> optionsMap = widget.qData['options'];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.qData['title'])
      ),
      body: Column(
        children:[
          Expanded(child: MyChart(answerMap: optionsMap))
        ]
      )
    );
  }
}

class MyChart extends StatelessWidget {
  const MyChart({Key? key, required this.answerMap}) : super(key: key);
  final Map<String,dynamic> answerMap;


  @override
  Widget build(BuildContext context) {

    List<SurveyOption> qDataList = [];
    answerMap.forEach((key, value) {
      qDataList.add(SurveyOption(key, int.parse(value)));});

    List<charts.Series<SurveyOption, String>> series = [
      charts.Series(
          id: "Answers",
          data: qDataList,
          domainFn: (SurveyOption series, _) => series.optionTitle,
          measureFn: (SurveyOption series, _) => series.optionScore,
          colorFn: (SurveyOption series, _) => charts.ColorUtil.fromDartColor(Colors.blue)
      )
    ];
    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: charts.BarChart(series, animate: true,),
              )
            ],
          ),
        ),
      ),
    );
  }
}




class SurveyOption {
  final String optionTitle;
  final int optionScore;
  SurveyOption(this.optionTitle,this.optionScore);

  @override
  String toString(){
    return '$optionTitle : $optionScore';
  }
}