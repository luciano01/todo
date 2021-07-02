import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo/app/modules/launch/components/app_name_icon_widget.dart';
import 'package:todo/app/modules/launch/launch_store.dart';
import 'package:flutter/material.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({Key? key}) : super(key: key);
  @override
  LaunchPageState createState() => LaunchPageState();
}

class LaunchPageState extends State<LaunchPage> {
  final LaunchStore store = Modular.get();

  @override
  void initState() {
    store.waitAndSwitch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFC107),
              Color(0xFFC79100),
            ],
          ),
        ),
        child: AppNameIconWidget(),
      ),
    );
  }
}
