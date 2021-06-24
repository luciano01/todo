import 'package:todo/app/modules/add_task/addTask_Page.dart';
import 'package:todo/app/modules/add_task/addTask_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo/app/shared/repository/app_repository_interface.dart';

class AddTaskModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AddTaskStore(i.get<IAppRepository>())),
    Bind((i) => IAppRepository),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => AddTaskPage(
        todo: args.data,
      ),
    ),
  ];
}
