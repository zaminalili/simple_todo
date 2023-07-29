import 'package:flutter/material.dart';
import 'package:simple_todo/models/todo_model.dart';

import '../constants/appcolors.dart';
import '../constants/edgeinsets.dart';

class TodoItem extends StatelessWidget {
  const TodoItem(
      {super.key,
      required this.todo,
      required this.onTodoChange,
      required this.removeItem});

  final TodoItemModel todo;
  final onTodoChange;
  final removeItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onTap: () {
        onTodoChange(todo);
      },
      tileColor: AppColors.white,
      visualDensity: VisualDensity.compact,
      leading:
          Icon(todo.isDone ? Icons.check_box : Icons.check_box_outline_blank),
      title: Text(
        todo.title,
        style: TextStyle(
            decoration: todo.isDone ? TextDecoration.lineThrough : null),
      ),
      trailing: IconButton(
          onPressed: () {
            removeItem(todo.id);
          },
          icon: Icon(
            Icons.delete,
            color: AppColors.delColor,
          )),
    );
  }
}

class Input extends StatefulWidget {
  const Input({super.key, required this.onPressed, required this.controller});

  final onPressed;
  final controller;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: AppEdgeInsets.left,
      margin: AppEdgeInsets.bottom2x,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadiusDirectional.circular(20)),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
            label: const Text('A new item'),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: InputBorder.none,
            suffixIcon: IconButton(
                onPressed: widget.onPressed, icon: const Icon(Icons.add))),
      ),
    );
  }
}
