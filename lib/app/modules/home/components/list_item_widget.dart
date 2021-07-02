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
      padding: const EdgeInsets.only(
        top: 8,
        right: 16,
      ),
      child: ListTile(
        leading: IconButton(
          icon: todo.isCompleted!
              ? Icon(
                  Icons.check_box,
                  color: Theme.of(context).accentColor,
                )
              : Icon(
                  Icons.check_box_outline_blank,
                  color: Theme.of(context).accentColor,
                ),
          onPressed: onPressedCompleteTask,
        ),
        title: Text(
          todo.name!,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18,
            decoration: todo.isCompleted!
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          '${todo.date!.toDate().month}, ${todo.date!.toDate().day}, ${todo.date!.toDate().year}',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
            decoration: todo.isCompleted!
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        trailing: Text(
          todo.time!,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
            decoration: todo.isCompleted!
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
