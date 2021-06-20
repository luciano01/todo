import 'package:todo/app/shared/models/todo_store.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'app_repository_interface.dart';

class AppRepository implements IAppRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference? _reference;

  AppRepository(this._firestore) {
    _reference = _firestore.collection('todo');
  }

  @override
  Future<DocumentReference> create({TodoStore? todo}) =>
      _reference!.add(todo!.toJson());

  @override
  Stream<List<TodoStore>> read() {
    return _reference!.snapshots().map((snapshot) =>
        snapshot.docs.map((document) => TodoStore.fromJson(document)).toList());
  }

  @override
  Future<void> udpate({TodoStore? todo}) =>
      _reference!.doc(todo!.uid).update(todo.toJson());

  @override
  Future<void> delete({TodoStore? todo}) => _reference!.doc(todo?.uid).delete();
}
