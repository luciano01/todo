import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:todo/app/shared/models/todo_store.dart';
import 'package:todo/app/shared/repository/app_repository_interface.dart';

part 'addTask_store.g.dart';

class AddTaskStore = _AddTaskStoreBase with _$AddTaskStore;

abstract class _AddTaskStoreBase with Store {
  final IAppRepository _repository;

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  _AddTaskStoreBase(this._repository);

  String? validateTaskName(String? value) {
    if (value!.length <= 3) {
      autovalidateMode = AutovalidateMode.always;
      return 'Cannot be empty or shorter than 3 caracters.';
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
