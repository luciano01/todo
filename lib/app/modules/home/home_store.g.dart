// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on HomeStoreBase, Store {
  final _$listOfTasksAtom = Atom(name: 'HomeStoreBase.listOfTasks');

  @override
  ObservableStream<List<TodoStore>>? get listOfTasks {
    _$listOfTasksAtom.reportRead();
    return super.listOfTasks;
  }

  @override
  set listOfTasks(ObservableStream<List<TodoStore>>? value) {
    _$listOfTasksAtom.reportWrite(value, super.listOfTasks, () {
      super.listOfTasks = value;
    });
  }

  @override
  String toString() {
    return '''
listOfTasks: ${listOfTasks}
    ''';
  }
}
