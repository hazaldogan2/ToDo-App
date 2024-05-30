import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../model/task.dart';

class TaskController extends GetxController {
  Rx<List<Task>> task = Rx<List<Task>>([]);
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController noteTextEditingController = TextEditingController();

  DateTime date = DateTime.now();
  Color priorityController = Colors.grey;
  int priorityIntController = 0;

  String dateTextEditingController = "";
  String timeTextEditingController = "";

  List<Task> taskmodelList = [];
  List<Task> today = [];
  List<Task> tomorrow = [];
  List<Task> nextDays = [];

  late Task taskModel;
  var itemCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    titleTextEditingController.dispose();
    noteTextEditingController.dispose();
  }


  addTask(String title, String note, String? dateTime, String? time, Color? color, DateTime? date, int? priority) {
    final DateTime now = DateTime.now();
    final DateFormat format = DateFormat('yyyy-MM-dd');
    final String formatted = format.format(now);

    taskModel = Task(
      title: title,
      note: note,
      dateTime: dateTime?? formatted,
      time: time,
      color: color ?? Colors.grey,
      date: date ?? DateTime.now(),
      priority: priority ?? 0,
    );

    task.value.add(taskModel);
    taskmodelList.addAll(task.value);

    today.clear();
    tomorrow.clear();
    nextDays.clear();

    for (int i = 0; i < taskmodelList.length; i++) {
      if (taskmodelList[i].date.year == DateTime.now().year &&
          taskmodelList[i].date.month == DateTime.now().month &&
          taskmodelList[i].date.day == DateTime.now().day) {
        today.add(taskmodelList[i]);
      } else if (taskmodelList[i].date.year == DateTime.now().year &&
          taskmodelList[i].date.month == DateTime.now().month &&
          taskmodelList[i].date.day + 1 == DateTime.now().day + 1) {
        tomorrow.add(taskmodelList[i]);
      } else {
        nextDays.add(taskmodelList[i]);
      }
    }
    task.value.clear();

    for (int i = 0; i < today.length; i++) {
      today.sort((a, b) => (b.priority ?? 0).compareTo(a.priority ?? 0));
    }
    task.value.addAll(today);

    for (int i = 0; i < tomorrow.length; i++) {
      print(tomorrow[i].priority);
      tomorrow.sort((a, b) => (b.priority ?? 0).compareTo(a.priority ?? 0));
    }
    task.value.addAll(tomorrow);

    for (int i = 0; i < nextDays.length; i++) {
      nextDays.sort((a, b) => (b.priority ?? 0).compareTo(a.priority ?? 0));
    }
    task.value.addAll(nextDays);

    itemCount.value = task.value.length;
    titleTextEditingController.clear();
    noteTextEditingController.clear();
    dateTextEditingController = formatted;
    taskmodelList.clear();
  }

  removeTask(int index) {
    task.value.removeAt(index);
    itemCount.value = task.value.length;
  }
}
