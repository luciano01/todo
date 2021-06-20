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
}
