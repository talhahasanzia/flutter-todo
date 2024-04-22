import 'dart:developer';
import 'package:flutter_application1/task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_provider.g.dart';

@riverpod
class TaskProvider extends _$TaskProvider {
  List<Task> tasks = [];

  String taskName = "";

  @override
  List<Task> build() {
    return tasks;
  }

  setName(String value) {
    log(value);
    taskName = value;
    ref.notifyListeners();
  }

  addTask() {
    if (taskName == "") {
      return;
    }

    final task = Task(taskName);
    tasks.add(task);
    taskName = "";
    log("total tasks: ${tasks.length}");
    ref.notifyListeners();
  }
}
