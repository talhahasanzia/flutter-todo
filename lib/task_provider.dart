import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application1/task.dart';

class TaskProvider extends ChangeNotifier{
  List<Task> tasks = [];

  String taskName= "";

  setName(String value){
      log(value);
      taskName = value;
      notifyListeners();
  }

  addTask(){

    if(taskName == "" ){
      return;
    }

    final task = Task(taskName);
    tasks.add(task);
    taskName = "";
    log(tasks.length.toString());
    notifyListeners();
  }
}