import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo/app/modules/home/components/app_bar_title_widget.dart';
import 'package:todo/app/modules/home/components/fab_widget.dart';
import 'package:todo/app/modules/home/components/list_filter_widget.dart';
import 'package:todo/app/modules/home/components/list_item_widget.dart';
import 'package:todo/app/modules/home/home_store.dart';
import 'package:todo/app/shared/models/todo_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore store = Modular.get();

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
            child: Observer(builder: (_) {
              List<TodoStore>? listAllTasks = store.listOfTasks!.data;
              dynamic error = store.listOfTasks?.error;

              if (error != null) {
                return Center(child: Text('$error'));
              }

              if (listAllTasks == null || listAllTasks.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                itemCount: listAllTasks.length,
                itemBuilder: (context, index) {
                  TodoStore todo = listAllTasks[index];
                  return Dismissible(
                    direction: DismissDirection.startToEnd,
                    confirmDismiss: (DismissDirection direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Row(
                              children: [
                                Icon(
                                  Icons.warning_amber_outlined,
                                  color: Colors.red,
                                ),
                                Text("Confirm"),
                              ],
                            ),
                            content: Text(
                                "Are you sure you wish to delete this Task?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Modular.to.pop(true),
                                child: Text("DELETE"),
                              ),
                              TextButton(
                                onPressed: () => Modular.to.pop(false),
                                child: Text("CANCEL"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    background: Container(
                      color: Colors.red,
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.delete_forever,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    key: Key(todo.uid!),
                    onDismissed: (direction) {
                      store.delete(todo: todo).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Task deleted successfully!')),
                        );
                      });
                    },
                    child: ListItemWidget(
                      todo: todo,
                      onPressedCompleteTask: () {
                        todo.isCompleted = !todo.isCompleted!;
                        store.update(todo: todo);
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
