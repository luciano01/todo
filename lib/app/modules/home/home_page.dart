import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo/app/modules/home/components/app_bar_title_widget.dart';
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

  final _formKey = GlobalKey<FormState>();

  TodoStore? _todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: AppBarTitleWidget(),
        leading: Icon(Icons.menu),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        child: Icon(Icons.add),
        onPressed: () {
          addTask();
        },
      ),
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
                      onTap: () {
                        addTask(todo: todo);
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

  addTask({TodoStore? todo}) {
    _todo = todo ?? TodoStore();
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Form(
          key: _formKey,
          autovalidateMode: store.autoValidate,
          child: Wrap(
            children: <Widget>[
              Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Task name',
                          ),
                          initialValue: _todo!.name,
                          validator: store.validateTaskName,
                          onChanged: _todo!.setName,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        leading: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color:
                                Theme.of(context).accentColor.withOpacity(0.3),
                          ),
                          child: Icon(Icons.today,
                              color: Theme.of(context).accentColor),
                        ),
                        title: Observer(builder: (_) {
                          return _todo!.date == null
                              ? Text(
                                  '${DateTime.now().month}/${DateTime.now().day}')
                              : Text(_todo!.date!);
                        }),
                        subtitle: Text('Select a date'),
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030),
                          );
                          if (picked != null) {
                            String date = '${picked.month}/${picked.day}';
                            _todo!.setDate(date);
                          }
                        },
                      ),
                      ListTile(
                        leading: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color:
                                Theme.of(context).accentColor.withOpacity(0.3),
                          ),
                          child: Icon(Icons.access_time_rounded,
                              color: Theme.of(context).accentColor),
                        ),
                        title: Observer(builder: (_) {
                          return _todo!.time == null
                              ? Text(
                                  '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}')
                              : Text(_todo!.time!);
                        }),
                        subtitle: Text('Select a time'),
                        onTap: () async {
                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (context, child) {
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: child!,
                              );
                            },
                          );

                          if (picked != null) {
                            String time = '${picked.hour}:${picked.minute}';
                            _todo!.setTime(time);
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          child: Text('Create Task'),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              store.save(todo: _todo);
                              Modular.to.pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: _todo!.uid == null
                                      ? Text('Task created successfully!')
                                      : Text('Task updated successfully!'),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
