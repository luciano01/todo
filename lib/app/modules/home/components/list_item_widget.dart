import 'package:flutter/material.dart';
import 'package:todo/app/shared/models/todo_store.dart';

class ListItemWidget extends StatelessWidget {
  final TodoStore todo;
  final void Function()? onPressedCompleteTask;
  final void Function()? onTap;
  const ListItemWidget({
    Key? key,
    required this.todo,
    required this.onPressedCompleteTask,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: ListTile(
        leading: IconButton(
          icon: todo.isCompleted!
              ? Icon(
                  Icons.check_circle,
                  color: Theme.of(context).accentColor,
                )
              : Icon(Icons.check_circle_outline),
          onPressed: onPressedCompleteTask,
        ),
        title: Text(
          todo.name!,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          '${todo.time!} - ${todo.date!}',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
