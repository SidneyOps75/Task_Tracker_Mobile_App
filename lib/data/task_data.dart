import 'package:flutter/foundation.dart';
import '../models/task.dart';

enum TaskFilter { all, completed, incomplete }

class TaskData extends ChangeNotifier {
  final List<Task> _tasks = [];
  TaskFilter _currentFilter = TaskFilter.all;
  String? _selectedCategory;

  static const List<String> categories = ['Work', 'Personal', 'Urgent', 'Other'];

  List<Task> get tasks {
    switch (_currentFilter) {
      case TaskFilter.completed:
        return _tasks.where((task) => task.isDone).toList();
      case TaskFilter.incomplete:
        return _tasks.where((task) => !task.isDone).toList();
      default:
        return _selectedCategory == null
            ? _tasks
            : _tasks.where((task) => task.category == _selectedCategory).toList();
    }
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTaskStatus(int index) {
    _tasks[index].isDone = !_tasks[index].isDone;
    notifyListeners();
  }

  void setFilter(TaskFilter filter) {
    _currentFilter = filter;
    notifyListeners();
  }

  void setCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Task getTask(int index) => _tasks[index];
}
