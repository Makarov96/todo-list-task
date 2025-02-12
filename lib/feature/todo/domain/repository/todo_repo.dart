import 'package:todo_list/feature/todo/data/model/task_model.dart';
import 'package:todo_list/feature/todo/domain/entity/task.dart';

abstract interface class TodoRepo {
  Stream<List<Task>> getTasks();
  Future<void> updateTask({
    required String taskId,
    required bool completed,
  });
  Future<void> createTask({
    required Task task,
  });
  Future<void> updateTasks({
    required List<TaskModel> tasks,
  });
}
