import 'package:flutter/material.dart';
import 'package:my_todo/components/task_tile.dart';
import 'package:my_todo/database/todo_database.dart';
import 'package:my_todo/screens/edit_task.dart';
import 'package:provider/provider.dart';

class TaskLists extends StatefulWidget {
  const TaskLists({super.key});

  @override
  State<TaskLists> createState() => _TaskListsState();
}

class _TaskListsState extends State<TaskLists> {

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoData>(
      builder: (context, todoData, child) {
        return Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
              color: Colors.white,
            ),
            child: ListView.builder(
              itemCount: todoData.todoList.length,
              itemBuilder: (context, index) {
                final todo = todoData.todoList[index];
                return TaskTile(
                  title: todo.title,
                  description: todo.description,
                  isCheck: todo.isChecked,
                  dueDate: todo.dueDate,
                  priority: todo.priority,
                  changeCheckState: () {
                    todoData.changeCheckState(todo);
                  },
                  deleteCallBack: (BuildContext context) {
                    todoData.deleteTodo(todo);
                  },
                  editCallBack: (BuildContext context) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTask(
                          todo: todo,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
