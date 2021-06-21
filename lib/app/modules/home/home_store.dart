import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:todo/app/shared/models/todo_store.dart';
import 'package:todo/app/shared/repository/app_repository_interface.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final IAppRepository _repository;

  HomeStoreBase(this._repository) {
    read();
  }

  @observable
  ObservableStream<List<TodoStore>>? listOfTasks;

  Future<void> read() async => listOfTasks = _repository.read().asObservable();

  Future<void> delete({TodoStore? todo}) async =>
      _repository.delete(todo: todo);

  Future<void> update({TodoStore? todo}) async =>
      _repository.udpate(todo: todo);

  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  String? validateTaskName(String? value) {
    if (value!.length <= 3) {
      autoValidate = AutovalidateMode.always;
      return 'Cannot be empty or shorter than 3 characters.';
    } else {
      return null;
    }
  }

  void save({TodoStore? todo}) {
    String date = '${DateTime.now().month}/${DateTime.now().day}';
    String time = '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}';
    if (todo!.uid == null) {
      if (todo.date == null) todo.setDate(date);
      if (todo.time == null) todo.setTime(time);
      _repository.create(todo: todo);
    } else {
      _repository.udpate(todo: todo);
    }
  }
}
