import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/task_data.dart';
import '../widgets/task_tile.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TaskData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Tracker'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                DropdownButton<TaskFilter>(
                  value: TaskFilter.all,
                  items: TaskFilter.values.map((filter) {
                    return DropdownMenuItem(
                      value: filter,
                      child: Text(filter.toString().split('.').last),
                    );
                  }).toList(),
                  onChanged: (TaskFilter? newFilter) {
                    if (newFilter != null) {
                      taskData.setFilter(newFilter);
                    }
                  },
                ),
                SizedBox(width: 16),
                DropdownButton<String>(
                  value: null,
                  hint: Text('Category'),
                  items: [
                    DropdownMenuItem<String>(
                      value: null,
                      child: Text('All Categories'),
                    ),
                    ...TaskData.categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                  ],
                  onChanged: (String? newCategory) {
                    taskData.setCategory(newCategory);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: taskData.tasks.length,
        itemBuilder: (context, index) {
          final task = taskData.getTask(index);
          return TaskTile(task: task, index: index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
      ),
    );
  }
}
