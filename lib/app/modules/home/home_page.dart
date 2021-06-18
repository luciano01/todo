import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo/app/modules/home/components/app_bar_title_widget.dart';
import 'package:todo/app/modules/home/components/fab_widget.dart';
import 'package:todo/app/modules/home/components/list_filter_widget.dart';
import 'package:todo/app/modules/home/components/list_item_widget.dart';
import 'package:todo/app/modules/home/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: AppBarTitleWidget(),
        leading: Icon(Icons.menu),
        elevation: 0,
      ),
      floatingActionButton: FabWidget(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ListFilterWidget(),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.2),
            thickness: 1,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListItemWidget();
              },
            ),
          ),
        ],
      ),
    );
  }
}
