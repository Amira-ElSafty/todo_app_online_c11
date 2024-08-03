import 'package:flutter/material.dart';
import 'package:flutter_app_todo_online_c11/app_colors.dart';
import 'package:flutter_app_todo_online_c11/firebase_utils.dart';
import 'package:flutter_app_todo_online_c11/model/task.dart';
import 'package:flutter_app_todo_online_c11/provider/list_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_user_provider.dart';

class TaskListItem extends StatelessWidget {
  Task task;

  TaskListItem({required this.task});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthUserProvider>(context);

    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: 0.25,
          // A motion is a widget used to control how the pane animates.
          motion: const DrawerMotion(),
          // All actions are defined in the children parameter.
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                /// delete task
                FirebaseUtils.deleteTaskFromFireStore(
                        task, authProvider.currentUser!.id!)
                    .then((value) {
                  print("task deleted successfully");
                  listProvider
                      .getAllTasksFromFireStore(authProvider.currentUser!.id!);
                }).timeout(Duration(seconds: 1), onTimeout: () {
                  print("task deleted successfully");
                  listProvider
                      .getAllTasksFromFireStore(authProvider.currentUser!.id!);
                });
              },
              backgroundColor: AppColors.redColor,
              foregroundColor: AppColors.whiteColor,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(22)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(12),
                color: AppColors.primaryColor,
                height: MediaQuery.of(context).size.height * 0.1,
                width: 4,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(task.description,
                      style: Theme.of(context).textTheme.titleMedium)
                ],
              )),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.01, horizontal: width * 0.05),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.primaryColor),
                child: Icon(
                  Icons.check,
                  color: AppColors.whiteColor,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
