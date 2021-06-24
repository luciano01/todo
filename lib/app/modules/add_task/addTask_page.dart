import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo/app/modules/add_task/addTask_store.dart';
import 'package:flutter/material.dart';
import 'package:todo/app/shared/models/todo_store.dart';

class AddTaskPage extends StatefulWidget {
  final TodoStore? todo;
  const AddTaskPage({Key? key, this.todo}) : super(key: key);
  @override
  AddTaskPageState createState() => AddTaskPageState();
}

class AddTaskPageState extends State<AddTaskPage> {
  final AddTaskStore store = Modular.get();

  TodoStore? _todo;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _todo = widget.todo ?? TodoStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(_todo!.uid == null ? 'Create a New Task' : 'Update a Task'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: store.autovalidateMode,
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _textField(
                      hintText: 'Task name',
                      initialValue: _todo!.name,
                      validator: store.validateTaskName,
                      onChanged: _todo!.setName,
                      keyboardType: TextInputType.text,
                    ),
                    Observer(builder: (context) {
                      return _listTile(
                        title: _todo!.date == null
                            ? '${DateTime.now().month}/${DateTime.now().day}'
                            : _todo!.date!,
                        subTitle: 'Select a date',
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030),
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.light(
                                      primary: Theme.of(context).accentColor),
                                  buttonTheme: ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            String date = '${picked.month}/${picked.day}';
                            _todo!.setDate(date);
                          }
                        },
                        icon: Icon(
                          Icons.today,
                          color: Theme.of(context).accentColor,
                        ),
                      );
                    }),
                    Observer(builder: (context) {
                      return _listTile(
                        title: _todo!.time == null
                            ? '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}'
                            : _todo!.time!,
                        subTitle: 'Select a time',
                        onTap: () async {
                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.light(
                                      primary: Theme.of(context).accentColor),
                                  buttonTheme: ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary),
                                ),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: child!,
                                ),
                              );
                            },
                          );
                          if (picked != null) {
                            String time = '${picked.hour}:${picked.minute}';
                            _todo!.setTime(time);
                          }
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Theme.of(context).accentColor,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 60,
                      margin: EdgeInsets.only(top: 32),
                      child: ElevatedButton(
                        child: Text(_todo!.uid == null
                            ? 'Create Task'.toUpperCase()
                            : 'Update Task'.toUpperCase()),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).accentColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                              _snackBar(uid: _todo!.uid),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField({
    required String? hintText,
    required String? initialValue,
    required String? Function(String?)? validator,
    required void Function(String)? onChanged,
    required TextInputType? keyboardType,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 26),
      ),
      initialValue: initialValue,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 26),
    );
  }

  Widget _listTile({
    required String title,
    required String subTitle,
    required void Function()? onTap,
    required Icon icon,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Theme.of(context).accentColor.withOpacity(0.3),
          ),
          child: icon,
        ),
        title: Text(title),
        subtitle: Text(subTitle),
        onTap: onTap,
      ),
    );
  }

  SnackBar _snackBar({required String? uid}) {
    return SnackBar(
      content: uid == null
          ? Text('Task created successfully!')
          : Text('Task updated successfully!'),
    );
  }
}
