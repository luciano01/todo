import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'launch_store.g.dart';

class LaunchStore = _LaunchStoreBase with _$LaunchStore;

abstract class _LaunchStoreBase with Store {
  // Function to wait 2 seconds and then switch to HomePage
  waitAndSwitch() {
    Future.delayed(Duration(seconds: 2))
        .then((value) => Modular.to.pushReplacementNamed('/home'));
  }
}
