import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

part 'todo_store.g.dart';

class TodoStore extends _TodoStoreBase with _$TodoStore {
  TodoStore({
    String? uid,
    String? name,
    bool? isCompleted,
    String? date,
    String? time,
  }) : super(
          uid: uid,
          name: name,
          isCompleted: isCompleted,
          date: date,
          time: time,
        );

  factory TodoStore.fromJson(DocumentSnapshot snapshot) {
    return TodoStore(
      uid: snapshot.id,
      name: snapshot.get('name'),
      isCompleted: snapshot.get('isCompleted'),
      date: snapshot.get('date'),
      time: snapshot.get('time'),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'isCompleted': this.isCompleted,
        'date': this.date,
        'time': this.time,
      };
}

abstract class _TodoStoreBase with Store {
  String? uid;
  String? name;

  @observable
  bool? isCompleted = false;

  @observable
  String? date;

  @observable
  String? time;

  _TodoStoreBase({
    this.uid,
    this.name,
    this.isCompleted,
    this.date,
    this.time,
  });

  @action
  setName(String value) => name = value;

  @action
  setIsCompleted(bool value) => isCompleted = value;

  @action
  setDate(String value) => date = value;

  @action
  setTime(String value) => time = value;
}
