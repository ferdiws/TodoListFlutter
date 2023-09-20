import 'dart:ui';

class Todo {
  String? id;
  String? todoText;
  Color? color;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    required this.color,
    this.isDone = false
  });
}

List<Todo> todoList = [];