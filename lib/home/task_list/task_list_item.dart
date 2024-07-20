import 'package:flutter/material.dart';
import 'package:flutter_app_todo_online_c11/app_colors.dart';

class TaskListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.whiteColor, borderRadius: BorderRadius.circular(22)),
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
                'Title',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.primaryColor, fontWeight: FontWeight.w500),
              ),
              Text('Desc', style: Theme.of(context).textTheme.titleMedium)
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
    );
  }
}
