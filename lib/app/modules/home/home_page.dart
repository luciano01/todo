import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo/app/modules/home/components/fab_widget.dart';
import 'package:todo/app/modules/home/components/list_item_widget.dart';
import 'package:todo/app/modules/home/home_store.dart';
import 'package:todo/app/shared/models/todo_store.dart';
import 'package:todo/app/shared/utils/date_convert.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore store = Modular.get();
  final DateConvert dateConvert = DateConvert();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Home'.toUpperCase()),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FabWidget(
        mini: true,
        iconData: Icons.add,
        onPressed: () {
          Modular.to.pushNamed('/addTask');
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Observer(builder: (_) {
          List<TodoStore>? listAllTasks = store.listOfTasks!.data;
          dynamic error = store.listOfTasks?.error;

          if (error != null) {
            return Center(child: Text('$error'));
          }

          if (listAllTasks == null) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).accentColor),
              ),
            );
          }

          if (listAllTasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/empty.png',
                    width: 200,
                  ),
                  Text(
                    'Oops!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'You don\'t have any Task.',
                    style: TextStyle(),
                  ),
                ],
              ),
            );
          }

          return _buildList(listAllTasks: listAllTasks);
        }),
      ),
    );
  }

  ListView _buildList({List<TodoStore>? listAllTasks}) {
    return ListView.builder(
      itemCount: listAllTasks?.length,
      itemBuilder: (context, index) {
        TodoStore todo = listAllTasks![index];

        return ListItemWidget(
          todo: todo,
          dateConvert: dateConvert,
          onPressedCompleteTask: () {
            todo.isCompleted = !todo.isCompleted!;
            store.update(todo: todo);
          },
          onTap: () {
            Modular.to.pushNamed('/addTask', arguments: todo);
          },
        );
      },
    );
  }
}
