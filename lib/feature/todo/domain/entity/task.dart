class Task {
  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
  });

  final String description;
  final bool completed;
  final String title;
  final String id;
}
