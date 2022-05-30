import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
var db = FirebaseFirestore.instance;

class Question {
  String name;
  List<Map<String,dynamic>> options;
  String type;

  Question({required this.name, required this.options, this.type = ''});
  factory Question.fromFireStore(QueryDocumentSnapshot qsnap){

    return Question(
        name: qsnap.get('name'),
        options: [],
        type: 'a'
    );
  }
}

class Form {
  String title;
  List<Question> questions;

  Form({required this.title, required this.questions});

  factory Form.fromFireStore(QueryDocumentSnapshot docsnap) {
    String parsedName = docsnap.get('name');
    List<Question> parsedQuestions = [];
    db.collection(docsnap.reference.path+'/questions').get().then(
            (value) {
              for (var child in value.docs){
                parsedQuestions.add(Question.fromFireStore(child));
              }
            });
    return Form(title:parsedName,questions:parsedQuestions);
  }

}