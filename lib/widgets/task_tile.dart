import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:provider/provider.dart';
import '../data/task_data.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final int index;

  TaskTile({required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    final bool isOverdue = task.dueDate.isBefore(DateTime.now()) && !task.isDone;

    return ListTile(
      leading: Checkbox(
        value: task.isDone,
        onChanged: (bool? value) {
          Provider.of<TaskData>(context, listen: false).toggleTaskStatus(index);
        },
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isDone ? TextDecoration.lineThrough : null,
          color: isOverdue ? Colors.red : null,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.description),
          Text(
            'Due: ${task.dueDate.toString().substring(0, 10)}',
            style: TextStyle(
              color: isOverdue ? Colors.red : Colors.grey,
            ),
          ),
          Chip(label: Text(task.category)),
        ],
      ),
    );
  }
}
