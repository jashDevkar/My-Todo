import 'package:flutter/cupertino.dart';

class TodoModel{

  String title;
  String description;
  bool isChecked ;
  int priority ;
  String dueDate;

  TodoModel({required this.title,required this.description, required this.priority, required this.dueDate,this.isChecked=false});

  void togglestate(){
    isChecked = !isChecked;
  }

  Map<String,dynamic> toJson(TodoModel todo){
    return {
      'title':todo.title,
      'description':todo.description,
      'priority':todo.priority,
      'dueDate':todo.dueDate,
      'isChecked':todo.isChecked
    };

  }
    factory TodoModel.fromJson(Map<dynamic,dynamic> json){
    return TodoModel(
        title: json['title'],
        description: json['description'],
        priority: json['priority'],
        dueDate: json['dueDate'],
      isChecked: json['isChecked']

    );
    }

  void editTask({required String title,required String  description, required int priority, required String dueDate}){
    this.title = title;
    this.description = description;
    this.dueDate = dueDate;
    this.priority = priority;
  }





}