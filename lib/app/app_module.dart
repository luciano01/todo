import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo/app/modules/home/home_module.dart';
import 'package:todo/app/modules/launch/launch_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

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
