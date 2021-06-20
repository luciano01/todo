// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TodoStore on _TodoStoreBase, Store {
  final _$isCompletedAtom = Atom(name: '_TodoStoreBase.isCompleted');

  @override
  bool? get isCompleted {
    _$isCompletedAtom.reportRead();
    return super.isCompleted;
  }

  @override
  set isCompleted(bool? value) {
    _$isCompletedAtom.reportWrite(value, super.isCompleted, () {
      super.isCompleted = value;
    });
  }

  final _$dateAtom = Atom(name: '_TodoStoreBase.date');

  @override
  String? get date {
    _$dateAtom.reportRead();
    return super.date;
  }

  @override
  set date(String? value) {
    _$dateAtom.reportWrite(value, super.date, () {
      super.date = value;
    });
  }

  final _$timeAtom = Atom(name: '_TodoStoreBase.time');

  @override
  String? get time {
    _$timeAtom.reportRead();
    return super.time;
  }

  @override
  set time(String? value) {
    _$timeAtom.reportWrite(value, super.time, () {
      super.time = value;
    });
  }

  final _$_TodoStoreBaseActionController =
      ActionController(name: '_TodoStoreBase');

  @override
  dynamic setName(String value) {
    final _$actionInfo = _$_TodoStoreBaseActionController.startAction(
        name: '_TodoStoreBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_TodoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsCompleted(bool value) {
    final _$actionInfo = _$_TodoStoreBaseActionController.startAction(
        name: '_TodoStoreBase.setIsCompleted');
    try {
      return super.setIsCompleted(value);
    } finally {
      _$_TodoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDate(String value) {
    final _$actionInfo = _$_TodoStoreBaseActionController.startAction(
        name: '_TodoStoreBase.setDate');
    try {
      return super.setDate(value);
    } finally {
      _$_TodoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTime(String value) {
    final _$actionInfo = _$_TodoStoreBaseActionController.startAction(
        name: '_TodoStoreBase.setTime');
    try {
      return super.setTime(value);
    } finally {
      _$_TodoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isCompleted: ${isCompleted},
date: ${date},
time: ${time}
    ''';
  }
}
