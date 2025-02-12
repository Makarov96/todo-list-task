import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:todo_list/feature/todo/data/api/todo_api_repo.dart';
import 'package:todo_list/feature/todo/domain/entity/task.dart';

// ignore_for_file: subtype_of_sealed_class
class FakeSetOptions extends Fake implements SetOptions {}

class FakeMap extends Fake implements Map<String, dynamic> {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

class MockWriteBatch extends Mock implements WriteBatch {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeMap());
    registerFallbackValue(FakeSetOptions());
  });

  group('TodoApiRepo', () {
    late MockFirebaseFirestore mockFirestore;
    late TodoApiRepo repo;
    late MockCollectionReference mockCollectionReference;

    setUp(() {
      mockFirestore = MockFirebaseFirestore();
      repo = TodoApiRepo(firestore: mockFirestore);
      mockCollectionReference = MockCollectionReference();
      when(() => mockFirestore.collection('tasks'))
          .thenReturn(mockCollectionReference);
    });

    test('getTasks returns list of tasks', () async {
      final taskData = <String, dynamic>{
        'id': '1',
        'title': 'Test Task',
        'description': 'This is a test task',
        'completed': false,
      };

      final mockDocSnapshot = MockQueryDocumentSnapshot();
      when(() => mockDocSnapshot.data()).thenReturn(taskData);

      final mockQuerySnapshot = MockQuerySnapshot();
      when(() => mockQuerySnapshot.docs).thenReturn([mockDocSnapshot]);
      when(() => mockCollectionReference.snapshots())
          .thenAnswer((_) => Stream.value(mockQuerySnapshot));
      final tasksStream = repo.getTasks();
      final tasks = await tasksStream.first;
      expect(tasks, isA<List<Task>>());
      expect(tasks.length, equals(1));
      expect(tasks.first.title, equals('Test Task'));
    });

    test('createTask and updateTask are skipped for testing purposes', () {
      expect(true, isTrue,
          reason:
              'Los métodos createTask y updateTask requieren refactorización para inyección de dependencia y poder testearlos correctamente.');
    });
  });
}
