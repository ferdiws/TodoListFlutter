import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/colors.dart';
import 'package:todo_list_app/screens/add_edit_todo_screen.dart';
import 'package:todo_list_app/screens/profile_screen.dart';
import 'package:todo_list_app/widgets/todo_item.dart';

import '../model/todo.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: darkGray,
      appBar: buildAppBar(),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth < 640) {
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15
                ),
                child: Column(
                  children: [
                    searchBox(),
                    Expanded(
                      child: ListView(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: 20,
                              top: 20,
                            ),
                            child: const Text(
                              'All ToDos',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                              ),
                            ),
                          ),
                          for (Todo todoItem in todoList.where((item) =>
                              item.todoText!.toLowerCase()
                                  .contains(searchController.text.toLowerCase()))
                              .toList().reversed)
                            todoItem.isDone ? Container() : InkWell(
                              onTap: () => editTodo(todoItem),
                              child: TodoItem(
                                todo: todoItem,
                                onTodoChanged: handleTodoChanged,
                                onDeleteItem: deleteTodoItem,
                              ),
                            ),
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: const Text(
                              'Completed',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                              ),
                            ),
                          ),
                          for (Todo todoItem in todoList.where((item) =>
                              item.todoText!.toLowerCase()
                                  .contains(searchController.text.toLowerCase()))
                              .toList().reversed)
                            todoItem.isDone ? InkWell(
                              onTap: () => editTodo(todoItem),
                              child: TodoItem(
                                todo: todoItem,
                                onTodoChanged: handleTodoChanged,
                                onDeleteItem: deleteTodoItem,
                              ),
                            ) : Container(),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15
                ),
                child: Column(
                  children: [
                    searchBox(),
                    Flexible(
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 20,
                                    top: 20,
                                  ),
                                  child: const Text(
                                    'All ToDos',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                for (Todo todoItem in todoList.where((item) =>
                                    item.todoText!.toLowerCase()
                                        .contains(searchController.text.toLowerCase()))
                                    .toList().reversed)
                                  todoItem.isDone ? Container() : InkWell(
                                    onTap: () => editTodo(todoItem),
                                    child: TodoItem(
                                      todo: todoItem,
                                      onTodoChanged: handleTodoChanged,
                                      onDeleteItem: deleteTodoItem,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16,),
                          Expanded(
                            child: ListView(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 20,
                                    bottom: 20,
                                  ),
                                  child: const Text(
                                    'Completed',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                for (Todo todoItem in todoList.where((item) =>
                                    item.todoText!.toLowerCase()
                                        .contains(searchController.text.toLowerCase()))
                                    .toList().reversed)
                                  todoItem.isDone ? InkWell(
                                    onTap: () => editTodo(todoItem),
                                    child: TodoItem(
                                      todo: todoItem,
                                      onTodoChanged: handleTodoChanged,
                                      onDeleteItem: deleteTodoItem,
                                    ),
                                  ) : Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: darkGray,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddEditTodoScreen();
          })).then((_) => setState(() {}));
        },
      ),
    );
  }

  void handleTodoChanged(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void editTodo(Todo todo) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddEditTodoScreen(todoItem: todo);
    })).then((_) => setState(() {}));
  }

  void deleteTodoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: darkGray,
      elevation: 0,
      title: const Text(
        "Your To-Do List",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20
        ),
      ),
      leading: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const ProfileScreen();
          }));
        },
        child: Container(
          margin: const EdgeInsets.only(left: 12, top: 12),
          decoration: const BoxDecoration(
            shape: BoxShape.circle
          ),
          height: 30,
          width: 30,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/ferdinand.jpg',
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        onChanged: (_) => setState(() {}),
        controller: searchController,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            prefixIcon: Icon(
              Icons.search,
              color: darkGray,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
                maxHeight: 20,
                minWidth: 25
            ),
            isDense: true,
            border: InputBorder.none,
            hintText: 'Search...',
            hintStyle: TextStyle(
              color: darkGray,
            )
        ),
      ),
    );
  }
}
