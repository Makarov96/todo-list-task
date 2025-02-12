import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_list/feature/todo/data/model/task_model.dart';
import 'package:todo_list/feature/todo/domain/entity/task.dart';
import 'package:todo_list/feature/todo/domain/repository/todo_repo.dart';

class TodoApiRepo implements TodoRepo {
  final FirebaseFirestore _firestore;

  TodoApiRepo({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Task>> getTasks() {
    return _firestore.collection('tasks').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => TaskModel.fromMap(doc.data())).toList();
    });
  }

  @override
  Future<void> createTask({
    required Task task,
  }) async {
    try {
      final docRef = await FirebaseFirestore.instance.collection('tasks').add(
            task.toModel().toMap(),
          );

      await docRef.update({'id': docRef.id});
    } catch (e) {
      debugPrint('Error al crear la tarea: $e');
    }
  }

  @override
  Future<void> updateTasks({
    required List<TaskModel> tasks,
  }) async {
    try {
      WriteBatch batch = _firestore.batch();

      for (var task in tasks) {
        DocumentReference docRef = _firestore.collection('tasks').doc(task.id);
        batch.set(docRef, task.toMap(), SetOptions(merge: true));
      }
      await batch.commit();
    } catch (e) {
      debugPrint('Error al realizar batch update: $e');
    }
  }

  @override
  Future<void> updateTask({
    required String taskId,
    required bool completed,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('tasks').doc(taskId).set(
        {'completed': completed},
        SetOptions(merge: true),
      );
    } catch (e) {
      debugPrint('Error al actualizar la tarea: $e');
    }
  }
}
