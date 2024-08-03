import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_todo_online_c11/model/task.dart';

import '../firebase_utils.dart';

class ListProvider extends ChangeNotifier {
  /// data
  List<Task> tasksList = [];
  DateTime selectDate = DateTime.now();

  void getAllTasksFromFireStore(String uId) async {
    /// get all tasks
    /// collection => documents => data
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTasksCollection(uId).get();

    /// List<QueryDocumentSnapshot<Task>>   => List<Task>
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    /// filter all tasks => select date
    /// 27/7/2024
    tasksList = tasksList.where((task) {
      if (selectDate.day == task.dateTime.day &&
          selectDate.month == task.dateTime.month &&
          selectDate.year == task.dateTime.year) {
        return true;
      }
      return false;
    }).toList();

    /// sorting tasks
    tasksList.sort((Task task1, Task task2) {
      return task1.dateTime.compareTo(task2.dateTime);
    });

    notifyListeners();
  }

  void changeSelectDate(DateTime newSelectDate, String uId) {
    selectDate = newSelectDate;
    getAllTasksFromFireStore(uId);
  }
}
