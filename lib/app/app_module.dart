import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/app/shared/repository/app_repository.dart';
import 'package:todo/app/shared/models/todo_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo/app/modules/home/home_module.dart';
import 'package:todo/app/modules/launch/launch_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AppRepository(i.get<FirebaseFirestore>())),
    Bind.lazySingleton((i) => TodoStore()),
    Bind((i) => FirebaseFirestore.instance),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      Modular.initialRoute,
      module: LaunchModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/home',
      module: HomeModule(),
      transition: TransitionType.rightToLeftWithFade,
    ),
  ];
}
