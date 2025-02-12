import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_list/feature/todo/domain/entity/task.dart';
import 'package:todo_list/feature/todo/domain/repository/todo_repo.dart';
import 'package:uuid/v4.dart';

class TaskBloc extends ChangeNotifier {
  TaskBloc({
    required TodoRepo repo,
  }) : _repo = repo {
    _subscribeToTasks();
  }

  final TodoRepo _repo;

  final List<Task> _allTasks = [];
  List<Task> _filteredTasks = [];

  StreamSubscription<List<Task>>? _subscription;

  void _subscribeToTasks() {
    _subscription = _repo.getTasks().listen(
      (taskList) {
        _allTasks
          ..clear()
          ..addAll(taskList);
        _filteredTasks = List.from(_allTasks);
        notifyListeners();
      },
      onError: (error) {},
    );
  }

  List<Task> get tasks => _filteredTasks;
  Stream<List<Task>> get stream => _repo.getTasks();

  Future<void> addTask(String title, String description) async {
    if (title.isEmpty || description.isEmpty) {
      throw Exception("Title cannot be empty");
    }
    final task = Task(
      id: UuidV4().generate(),
      title: title,
      description: description,
      completed: false,
    );
    await _repo.createTask(task: task);
  }

  Future<void> toggleTaskStatus({
    required String id,
    required bool completed,
  }) async {
    await _repo.updateTask(
      taskId: id,
      completed: completed,
    );
    notifyListeners();
  }

  void filterByCompleted() {
    _filteredTasks = _allTasks.where((task) => task.completed).toList();
    notifyListeners();
  }

  void filterByInCompleted() {
    _filteredTasks = _allTasks.where((task) => !task.completed).toList();
    notifyListeners();
  }

  void showAll() {
    _filteredTasks = List.from(_allTasks);
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
