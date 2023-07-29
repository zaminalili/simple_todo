import 'package:flutter/material.dart';
import 'package:simple_todo/constants/appcolors.dart';
import 'package:simple_todo/constants/edgeinsets.dart';
import 'package:simple_todo/models/todo_model.dart';

import '../widgets/widgets.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  Home({super.key, required this.title, required this.todoList});

  final String title;
  final List<TodoItemModel> todoList;

  var textEditingController = TextEditingController();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _handle(TodoItemModel todo) {
    setState(() {
      widget.todoList.forEach((e) {
        if (e.id == todo.id) e.isDone = !e.isDone;
      });
    });
  }

  void _remove(int id) {
    setState(() {
      widget.todoList.removeWhere((e) => e.id == id);
    });
  }

  void _add() {
    if (widget.textEditingController.text.isNotEmpty) {
      setState(() {
        widget.todoList.add(TodoItemModel(
            id: DateTime.now().millisecondsSinceEpoch.toInt(),
            title: widget.textEditingController.text));

        widget.textEditingController = TextEditingController();
        FocusScope.of(context).unfocus();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.bgColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        reverse: true,
        child: Stack(
          children: [
            Container(
              padding: AppEdgeInsets.symmetric,
              child: Column(
                children: [
                  // Input(
                  //   onPressed: _add,
                  //   controller: widget.textEditingController,
                  // ),
                  Padding(
                    padding: AppEdgeInsets.bottom,
                    child: const Text(
                      'All todo items',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  _buildItems(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Input(
        onPressed: _add,
        controller: widget.textEditingController,
      ),
    );
  }

  Column _buildItems() {
    return Column(children: [
      for (TodoItemModel todoo in widget.todoList)
        Container(
          margin: AppEdgeInsets.bottom,
          child: TodoItem(
            todo: todoo,
            onTodoChange: _handle,
            removeItem: _remove,
          ),
        )
    ]);
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.bgColor,
      centerTitle: true,
      title: Text(widget.title,
          style: TextStyle(
            color: AppColors.textColor,
          )),
    );
  }
}
