import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/colors.dart';
import 'package:todo_list_app/model/todo.dart';

class AddEditTodoScreen extends StatefulWidget {
  final Todo? todoItem;
  const AddEditTodoScreen({super.key, this.todoItem});

  @override
  State<AddEditTodoScreen> createState() => _AddEditTodoScreenState();
}

class _AddEditTodoScreenState extends State<AddEditTodoScreen> {
  final todoColors = [lightRed, lightYellow, lightGreen, babyBlue, lightBlue];
  var selectedColor = lightRed;
  var curId = '';
  var isDone = false;
  final todoController = TextEditingController();

  @override
  void initState() {
    if (widget.todoItem != null) {
      selectedColor = widget.todoItem!.color!;
      todoController.text = widget.todoItem!.todoText!;
      curId = widget.todoItem!.id!;
      isDone = widget.todoItem!.isDone;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedColor,
      appBar: AppBar(
        backgroundColor: selectedColor,
        elevation: 0,
        title: const Text(
          'Add Todo',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: darkGray
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: darkGray,
            size: 30,
          ),
        ),
      ),
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 640) {
          return Container(
            margin: const EdgeInsets.only(
                top: 8,
                bottom: 20,
                left: 16,
                right: 16
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      for (Color todoColor in todoColors)
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedColor = todoColor;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: todoColor,
                                border: Border.all(
                                    width: selectedColor == todoColor ? 2.5 : 1,
                                    color: Colors.white
                                )
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Enter task...',
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                        fontSize: 20,
                        color: darkGray
                    ),
                    maxLines: 3,
                    controller: todoController,
                  ),
                  const SizedBox(height: 16,),
                  const Text(
                    'Priority',
                    style: TextStyle(
                        fontSize: 20,
                        color: darkGray
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Text(
                    selectedColor == lightRed ? 'Critical'
                        : selectedColor == lightYellow ? 'High priority'
                        : selectedColor == lightGreen ? 'Neutral'
                        : selectedColor == babyBlue ? 'Low priority' : 'Unknown',
                    style: const TextStyle(
                        fontSize: 24,
                        color: darkGray,
                        fontWeight: FontWeight.w600
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Container(
            margin: const EdgeInsets.only(
                top: 8,
                bottom: 20,
                left: 16,
                right: 16
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (Color todoColor in todoColors)
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedColor = todoColor;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: todoColor,
                                border: Border.all(
                                    width: selectedColor == todoColor ? 2.5 : 1,
                                    color: Colors.white
                                )
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Enter task...',
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                        fontSize: 20,
                        color: darkGray
                    ),
                    maxLines: 3,
                    controller: todoController,
                  ),
                  const SizedBox(height: 16,),
                  const Text(
                    'Priority',
                    style: TextStyle(
                        fontSize: 20,
                        color: darkGray
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Text(
                    selectedColor == lightRed ? 'Critical'
                        : selectedColor == lightYellow ? 'High priority'
                        : selectedColor == lightGreen ? 'Neutral'
                        : selectedColor == babyBlue ? 'Low priority' : 'Unknown',
                    style: const TextStyle(
                        fontSize: 24,
                        color: darkGray,
                        fontWeight: FontWeight.w600
                    ),
                  )
                ],
              ),
            ),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          if (widget.todoItem != null) {
            update(curId, todoController.text, selectedColor);
          } else {
            curId = DateTime.now().millisecondsSinceEpoch.toString();
            addTodo(curId, todoController.text, selectedColor);
          }
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.save,
          color: darkGray,
          size: 30,
        ),
      ),
    );
  }

  void addTodo(String id, String todoText, Color color) {
    todoList.add(Todo(id: id, todoText: todoText, color: selectedColor));
    todoController.clear();
    Navigator.pop(context);
  }

  void update(String id, String todoText, Color color) {
    todoList[todoList.indexWhere((element) => element.id == id)] = Todo(
      id: id,
      todoText: todoText,
      color: color,
      isDone: isDone
    );
    todoController.clear();
    Navigator.pop(context);
  }
}
