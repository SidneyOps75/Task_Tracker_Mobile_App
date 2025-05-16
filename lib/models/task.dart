class Task {
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime dueDate;
  final String category;
  bool isDone;

  Task({
    required this.title,
    required this.description,
    required this.createdAt,
    required this.dueDate,
    required this.category,
    this.isDone = false,
  });
}
