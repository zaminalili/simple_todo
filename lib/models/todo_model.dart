class TodoItemModel {
  TodoItemModel({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  int id;
  String title;
  bool isDone;

  static List<TodoItemModel> todoList() {
    return [];
  }
}
