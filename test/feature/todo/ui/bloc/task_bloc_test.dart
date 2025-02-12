import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/feature/todo/domain/entity/task.dart';
import 'package:todo_list/feature/todo/domain/repository/todo_repo.dart';
import 'package:todo_list/feature/todo/ui/bloc/task_bloc.dart';

class MockTodoRepo extends Mock implements TodoRepo {}

void main() {
  late MockTodoRepo mockRepo;
  late StreamController<List<Task>> taskStreamController;
  late TaskBloc bloc;

  final task1 =
      Task(id: '1', title: 'Task 1', description: 'desc1', completed: false);
  final task2 =
      Task(id: '2', title: 'Task 2', description: 'desc2', completed: true);
  final task3 =
      Task(id: '3', title: 'Task 3', description: 'desc3', completed: false);

  setUp(() {
    mockRepo = MockTodoRepo();
    taskStreamController = StreamController<List<Task>>();
    when(() => mockRepo.getTasks())
        .thenAnswer((_) => taskStreamController.stream);
    bloc = TaskBloc(repo: mockRepo);
  });

  tearDown(() async {
    await taskStreamController.close();
    bloc.dispose();
  });

  test('subscribes to tasks and updates the list', () async {
    taskStreamController.add([task1, task2]);
    await Future.delayed(Duration.zero);
    expect(bloc.tasks.length, equals(2));
    expect(bloc.tasks[0].title, equals('Task 1'));
    expect(bloc.tasks[1].title, equals('Task 2'));
  });

  test('addTask throws exception if title or description is empty', () async {
    expect(() => bloc.addTask("", "Some Description"), throwsException);
    expect(() => bloc.addTask("Some Title", ""), throwsException);
  });

  test('toggleTaskStatus calls updateTask and notifies listeners', () async {
    bool notified = false;
    bloc.addListener(() {
      notified = true;
    });

    when(() => mockRepo.updateTask(
            taskId: any(named: 'taskId'), completed: any(named: 'completed')))
        .thenAnswer((_) async => Future.value());

    await bloc.toggleTaskStatus(id: '1', completed: true);

    verify(() => mockRepo.updateTask(taskId: '1', completed: true)).called(1);
    expect(notified, isTrue);
  });

  test('filterByCompleted filters tasks correctly', () async {
    taskStreamController.add([task1, task2, task3]);
    await Future.delayed(Duration.zero);

    bloc.filterByCompleted();

    expect(bloc.tasks.length, equals(1));
    expect(bloc.tasks.first.completed, isTrue);
  });

  test('filterByInCompleted filters tasks correctly', () async {
    taskStreamController.add([task1, task2, task3]);
    await Future.delayed(Duration.zero);

    bloc.filterByInCompleted();

    expect(bloc.tasks.length, equals(2));
    expect(bloc.tasks.every((t) => t.completed == false), isTrue);
  });

  test('showAll resets the filtered tasks', () async {
    taskStreamController.add([task1, task2]);
    await Future.delayed(Duration.zero);

    bloc.filterByCompleted();
    expect(bloc.tasks.length, equals(1));

    bloc.showAll();

    expect(bloc.tasks.length, equals(2));
  });
}
