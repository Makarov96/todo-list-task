import 'package:todo_list/feature/todo/domain/entity/task.dart';

class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.completed,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
    };
  }

  factory TaskModel.fromMap(Map<dynamic, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'] as String,
      description: map['description'] as String? ?? "",
      completed: map['completed'] as bool? ?? false,
    );
  }
}

extension TaskMapper on Task {
  TaskModel toModel() {
    return TaskModel(
      id: id,
      title: title,
      description: description,
      completed: completed,
    );
  }
}

extension TaskModelMapper on TaskModel {
  Task toEntity() {
    return Task(
      id: id,
      title: title,
      description: description,
      completed: completed,
    );
  }
}
