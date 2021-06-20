import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/app/shared/models/todo_store.dart';

abstract class IAppRepository {
  Future<DocumentReference> create({TodoStore todo});

  Stream<List<TodoStore>> read();

  Future<void> udpate({TodoStore? todo});

  Future<void> delete({TodoStore? todo});
}
